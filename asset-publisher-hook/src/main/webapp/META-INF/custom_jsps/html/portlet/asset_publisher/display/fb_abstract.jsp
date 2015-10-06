<%--
    fb_abstract.jsp: A custom asset-publisher style where 
    
    - the asset's metadata is displayed BEFORE the title and summary
    - the title is read from the structure's headline field
    - the color-scheme property is read from the applied categories
    - shariff-based social media buttons are included 
    
    Created:    2015-07-28 11:53 by Christian Berndt
    Modified:   2015-10-06 16:16 by Christian Berndt
    Version:    1.0.8
--%>
<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/portlet/asset_publisher/init.jsp" %>

<%-- Import classes required by customization --%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>

<%@page import="com.liferay.portal.kernel.xml.Document"%>
<%@page import="com.liferay.portal.kernel.xml.Node"%>
<%@page import="com.liferay.portal.kernel.xml.SAXReaderUtil"%>

<%@page import="com.liferay.portlet.asset.service.AssetCategoryPropertyServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetCategoryProperty"%>
<%@page import="com.liferay.portlet.journal.asset.JournalArticleAssetRenderer"%>

<%
List results = (List)request.getAttribute("view.jsp-results");

int assetEntryIndex = ((Integer)request.getAttribute("view.jsp-assetEntryIndex")).intValue();

AssetEntry assetEntry = (AssetEntry)request.getAttribute("view.jsp-assetEntry");
AssetRendererFactory assetRendererFactory = (AssetRendererFactory)request.getAttribute("view.jsp-assetRendererFactory");
AssetRenderer assetRenderer = (AssetRenderer)request.getAttribute("view.jsp-assetRenderer");

boolean show = ((Boolean)request.getAttribute("view.jsp-show")).booleanValue();

request.setAttribute("view.jsp-showIconLabel", true);

String title = (String)request.getAttribute("view.jsp-title");

if (Validator.isNull(title)) {
    title = assetRenderer.getTitle(locale);
}

String viewURL = AssetPublisherHelperImpl.getAssetViewURL(liferayPortletRequest, liferayPortletResponse, assetEntry, viewInContext);

String viewURLMessage = viewInContext ? assetRenderer.getViewInContextMessage() : "read-more-x-about-x";

String summary = StringUtil.shorten(assetRenderer.getSummary(locale), abstractLength);

List<AssetCategory> assetCategories = AssetCategoryServiceUtil.getCategories(assetEntry.getClassName(), assetEntry.getClassPK());

AssetCategory assetCategory = null; 

if (assetCategories.size() > 0) {
	assetCategory = assetCategories.get(0); 
}

String scheme = StringPool.BLANK; 

if (assetCategory != null) {
    
    List<AssetCategoryProperty> categoryProperties = AssetCategoryPropertyServiceUtil.getCategoryProperties(assetCategory.getCategoryId());
    
    for (AssetCategoryProperty categoryProperty : categoryProperties) {
        
        if ("color-scheme".equals(categoryProperty.getKey())) {
            
        	String value = categoryProperty.getValue(); 
        	
        	if (Validator.isNotNull(value)) {
	            scheme = value; 
        	}
        }
    }
}

// Customization: for journal-article assets try to use the journal-article's
// articleTitle, which can be retrieved from an article's structure.

String articleTitle = null; 
long eventTime = 0; 
String eventDate = null;
String location = null; 
		
String languageId = LanguageUtil.getLanguageId(request);
   	
   	
if (JournalArticle.class.getName().equals(assetEntry.getClassName())) {
	
	JournalArticleAssetRenderer journalRenderer = (JournalArticleAssetRenderer) assetRenderer; 
	JournalArticle article = journalRenderer.getArticle(); 
	                
	if (article != null) {
	    try {
	    
	        Document document = SAXReaderUtil.read(article
	                .getContentByLocale(languageId));	       
            
			Node dateNode = document.selectSingleNode("/root/dynamic-element[@name='date']/dynamic-content");
			
	        Node headlineNode = document.selectSingleNode("/root/dynamic-element[@name='headline']/dynamic-content");
	        
	        Node locationNode = document.selectSingleNode("/root/dynamic-element[@name='location']/dynamic-content");
	        
			Node titleNode = document.selectSingleNode("/root/dynamic-element[@name='title']/dynamic-content");

			
			if (dateNode != null) {
				eventDate = dateNode.getText();
				eventTime = GetterUtil.getLong(eventDate); 
			}
            
			if (headlineNode != null && headlineNode.getText().length() > 0) {
				articleTitle = headlineNode.getText();
			}
			
			if (locationNode != null && locationNode.getText().length() > 0) {
				location = locationNode.getText();
			}
			
			if (titleNode != null && titleNode.getText().length() > 0) {
				articleTitle = titleNode.getText();
			}

	    
	    } catch (Exception ignore) {
	        articleTitle = null;
	    }
	}
	
	if (articleTitle != null) {
		title = articleTitle; 
	}
}
	
%>

<c:if test="<%= show %>">

<%-- 
    Customization: read the color-scheme from the current category 
--%> 
	<div class="asset-abstract <%= defaultAssetPublisher ? "default-asset-publisher" : StringPool.BLANK %> <%= scheme %>">
         
        <liferay-util:include page="/html/portlet/asset_publisher/asset_actions.jsp" />
<%-- 
    Customization: wrap the asset's content sections. 
--%>     
	    <div class="container"> 
	    	<div class="row">
<%-- 
    Customization: display the asset's metadata as first element.
 --%>
		 		<div class="span4">
			        <div class="asset-metadata">
			        
			            <c:if test="<%= Validator.isNotNull(eventDate) %>">
			                <span class="metadata-entry metadata-event-date"><%= dateFormatDate.format(eventTime) %></span>
			            </c:if>
			            
			            <c:if test="<%= Validator.isNotNull(location) %>">
			                <span class="metadata-entry metadata-event-location"><%= location %></span>
			            </c:if>			
			
			            <%
			            request.setAttribute("asset_metadata.jspf-filterByMetadata", true);
			            %>
			
			            <%@ include file="/html/portlet/asset_publisher/asset_metadata.jspf" %>
			        </div>
		        </div>
		
				<div class="span8">
			        <h3 class="asset-title">           
		                 
				        <c:choose>
				            <c:when test="<%= Validator.isNotNull(viewURL) %>">
				                <a href="<%= viewURL %>"><img alt="" src="<%= assetRenderer.getIconPath(renderRequest) %>" /> <%= HtmlUtil.escape(title) %></a>
				            </c:when>
				            <c:otherwise>
				                <img alt="" src="<%= assetRenderer.getIconPath(renderRequest) %>" /> <%= HtmlUtil.escape(title) %>
				            </c:otherwise>
				        </c:choose>
		
			        </h3>

			        <div class="asset-content">
			            <div class="asset-summary">
			
			                <%
								// Disabled, since we need the assetRenderer earlier
								String path = assetRenderer.render(renderRequest, renderResponse, AssetRenderer.TEMPLATE_ABSTRACT);
								
								request.setAttribute(WebKeys.ASSET_RENDERER, assetRenderer);
								request.setAttribute(WebKeys.ASSET_PUBLISHER_ABSTRACT_LENGTH, abstractLength);
								request.setAttribute(WebKeys.ASSET_PUBLISHER_VIEW_URL, viewURL);
			                 %> 
			                
			                <c:choose>
			                    <c:when test="<%= path == null %>">
			                        <%= HtmlUtil.escape(summary) %>
			                    </c:when>
			                    <c:otherwise>
			                        <liferay-util:include page="<%= path %>" portletId="<%= assetRendererFactory.getPortletId() %>" />
			                    </c:otherwise>
			                </c:choose>
			            </div>
		
			            <c:if test="<%= Validator.isNotNull(viewURL) %>">
			                <div class="asset-more">
			                    <a href="<%= viewURL %>"><liferay-ui:message arguments='<%= new Object[] {"hide-accessible", HtmlUtil.escape(assetRenderer.getTitle(locale))} %>' key="<%= viewURLMessage %>" /></a>
			                </div>
			            </c:if>
			        </div>
        
			        <div class="asset-social-media">
		        
<% 
	// TODO: make the shariff properties configurable
	String backendUrl = "https://portal.flussbad-berlin.de/shariff"; 
//     String currentURL = viewURL; 
    String mailBody = "Schau mal hier auf www.flussbad-berlin.de"; 
//     String mailBody = "Schau mal hier <a href=\"" + viewURL + "\"> + auf www.flussbad-berlin.de</a>"; 
    String mailSubject = "Schau mal auf www.flussbad-berlin.de"; 
    String mailUrl = "mailto:"; 
    String selectedOrientation = "horizontal"; 
    String servicesConfig = "[&quot;facebook&quot;,&quot;twitter&quot;,&quot;mail&quot;]"; 
    String selectedTheme = "standard"; 
    String twitterVia = ""; 

%>
						<span class="tell-others"><liferay-ui:message key="tell-others"/></span>
						<div class="shariff" data-backend-url="<%= backendUrl %>"
							data-url="<%= viewURL %>" data-mail-body="<%= mailBody %>"
							data-mail-subject="<%= mailSubject %>" data-mail-url="<%= mailUrl %>"
							data-orientation="<%= selectedOrientation %>"
							data-services="<%= servicesConfig %>"
							data-theme="<%= selectedTheme %>" data-twitter-via="<%= twitterVia %>"></div>						
			        </div>
		        </div> <!-- /.span8 -->
			</div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.asset-abstract -->
</c:if>