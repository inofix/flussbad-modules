<%--
    fb_event_title.jsp: A custom asset-publisher style where 
    
    - the date and title is read from the event-structure's fields
    
    Created:    2015-10-02 10:29 by Christian Berndt
    Modified:   2015-10-05 12:39 by Christian Berndt
    Version:    1.0.1
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
%>

<c:if test="<%= show %>">

<%-- 
    Customization: read the color-scheme from the current category 
--%> 
    <div class="asset-abstract <%= defaultAssetPublisher ? "default-asset-publisher" : StringPool.BLANK %> <%= scheme %>">
         
        <liferay-util:include page="/html/portlet/asset_publisher/asset_actions.jsp" />
<%-- 
    Customization: wrap the asset's content sections into a bootstrap container. 
--%> 
     
    <div class="container">  
    
<%-- 
    Customization: for journal-article assets try to use the journal-article's
    articleTitle, which can be retrieved from an article's structure.
 --%>
<%
	String articleTitle = null;
    long eventTime = 0; 
    String eventDate = null; 
	String languageId = LanguageUtil.getLanguageId(request);
%>
	<%-- custom test --%>        
	<c:if test="<%= JournalArticle.class.getName().equals(assetEntry.getClassName()) %>">
<%
		JournalArticleAssetRenderer journalRenderer = (JournalArticleAssetRenderer) assetRenderer; 
		JournalArticle article = journalRenderer.getArticle(); 
	                
	            if (article != null) {
	                try {
	                
	                    Document document = SAXReaderUtil.read(article
	                            .getContentByLocale(languageId));
	                                                                 
	                    Node dateNode = document
	                            .selectSingleNode("/root/dynamic-element[@name='date']/dynamic-content");
	                    	                    
	                    Node titleNode = document
	                            .selectSingleNode("/root/dynamic-element[@name='title']/dynamic-content");
	                    
	                    if (titleNode.getText().length() > 0) {
	                        articleTitle = titleNode.getText();
	                    }
	                    
	                    if (dateNode != null) {
	                        eventDate = dateNode.getText();
	                        eventTime = GetterUtil.getLong(eventDate); 
	                    }
	                    
	                
	                } catch (Exception ignore) {
	                    articleTitle = null;
	                    eventDate = null; 
	                }
	            }
	            
	            if (articleTitle != null) {
	            	title = articleTitle; 
	            }
	
%>
	</c:if>
<%-- 
    Customization: display the event's date in the asset-metadata section 
    (or apply the default behavior, if no date was found.
 --%>
        <div class="asset-metadata">

			<%-- Custom test --%>
	        <c:choose>
	            <c:when test="<%= Validator.isNotNull(eventDate) %>">
	                <%= dateFormatDate.format(eventTime) %>
	            </c:when>
	            
	            <%-- Default behaviour --%>
	            <c:otherwise>
		        	<%
		            request.setAttribute("asset_metadata.jspf-filterByMetadata", true);
		            %>	
		            <%@ include file="/html/portlet/asset_publisher/asset_metadata.jspf" %>            </c:otherwise>
	        </c:choose>            

        </div>

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

		<%-- event-title has no content, only date and title 
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
	                    <a href="<%= viewURL %>"><liferay-ui:message arguments='<%= new Object[] {"hide-accessible", HtmlUtil.escape(assetRenderer.getTitle(locale))} %>' key="<%= viewURLMessage %>" /> &raquo; </a>
	                </div>
	            </c:if>
	        </div>
	    --%>

        </div>
    </div>
</c:if>