<%--
    main_search_result_form.jsp: A customized main_search_result_form.jsp 
    for Liferay's default search portlet.
    
    The following customization have been applied: 
    
    - use font-awesome icons instead of image files
    - use structure headlines / titles instead of article title
    - add and format publish date of the asset
        
    Created:    2016-02-14 23:21 by Christian Berndt
    Modified:   2016-05-15 13:59 by Christian Berndt
    Version:    1.0.2
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

<%@ include file="/html/portlet/search/init.jsp" %>

<%@page import="com.liferay.portlet.journal.asset.JournalArticleAssetRenderer"%>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Document document = (Document)row.getObject();

String className = document.get(Field.ENTRY_CLASS_NAME);

String entryTitle = null;
String entrySummary = null;
String downloadURL = null;
String returnToFullPageURL = (String)request.getAttribute("search.jsp-returnToFullPageURL");
PortletURL viewFullContentURL = null;
String viewURL = null;

//Customized: 
Format dateFormatDate = FastDateFormatFactoryUtil.getDate(DateFormat.MEDIUM, locale, timeZone);
Date publishDate = new Date(); 
long publishTime = publishDate.getTime(); 

AssetRendererFactory assetRendererFactory = AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(className);

AssetRenderer assetRenderer = null;

boolean inheritRedirect = false;

if (assetRendererFactory != null) {
    long classPK = GetterUtil.getLong(document.get(Field.ENTRY_CLASS_PK));

    long resourcePrimKey = GetterUtil.getLong(document.get(Field.ROOT_ENTRY_CLASS_PK));

    if (resourcePrimKey > 0) {
        classPK = resourcePrimKey;
    }

    AssetEntry assetEntry = AssetEntryLocalServiceUtil.getEntry(className, classPK);

    assetRenderer = assetRendererFactory.getAssetRenderer(classPK);

    downloadURL = assetRenderer.getURLDownload(themeDisplay);

    viewFullContentURL = _getViewFullContentURL(request, themeDisplay, PortletKeys.ASSET_PUBLISHER, document);

    viewFullContentURL.setParameter("struts_action", "/asset_publisher/view_content");

    if (Validator.isNotNull(returnToFullPageURL)) {
        viewFullContentURL.setParameter("returnToFullPageURL", returnToFullPageURL);
    }

    viewFullContentURL.setParameter("assetEntryId", String.valueOf(assetEntry.getEntryId()));
    viewFullContentURL.setParameter("type", assetRendererFactory.getType());

    if (Validator.isNotNull(assetRenderer.getUrlTitle())) {
        if ((assetRenderer.getGroupId() > 0) && (assetRenderer.getGroupId() != scopeGroupId)) {
            viewFullContentURL.setParameter("groupId", String.valueOf(assetRenderer.getGroupId()));
        }

        viewFullContentURL.setParameter("urlTitle", assetRenderer.getUrlTitle());
    }

    if (viewInContext || !assetEntry.isVisible()) {
        inheritRedirect = true;

        String viewFullContentURLString = viewFullContentURL.toString();

        viewFullContentURLString = HttpUtil.setParameter(viewFullContentURLString, "redirect", currentURL);

        viewURL = assetRenderer.getURLViewInContext(liferayPortletRequest, liferayPortletResponse, viewFullContentURLString);

        viewURL = AssetUtil.checkViewURL(assetEntry, viewInContext, viewURL, currentURL, themeDisplay);
    }
    else {
        viewURL = viewFullContentURL.toString();
    }
}
else {
    String portletId = document.get(Field.PORTLET_ID);

    viewFullContentURL = _getViewFullContentURL(request, themeDisplay, portletId, document);

    if (Validator.isNotNull(returnToFullPageURL)) {
        viewFullContentURL.setParameter("returnToFullPageURL", returnToFullPageURL);
    }

    viewURL = viewFullContentURL.toString();
}

//Customized: set display / publish-date    
if (assetRenderer != null) {
    if (assetRenderer.getDisplayDate() != null) {
        publishTime = assetRenderer.getDisplayDate().getTime(); 
    }
}

String timeStr = document.get("publishDate_sortable");
    
long time = GetterUtil.getLong(timeStr);

if (time > 0) {
    publishTime = time; 
}

Indexer indexer = IndexerRegistryUtil.getIndexer(className);

Summary summary = null;

if (indexer != null) {
    String snippet = document.get(Field.SNIPPET);
    
    summary = indexer.getSummary(document, locale, snippet, viewFullContentURL);

    entryTitle = summary.getTitle();
    entrySummary = summary.getContent();  
    
    
// Customized: use the structure's headline or title field as entry title
    if (JournalArticle.class.getName().equals(className)) {
        
        if (assetRenderer != null) {
            
            JournalArticleAssetRenderer journalArticleAssetRenderer = (JournalArticleAssetRenderer)assetRenderer; 
            JournalArticle article = journalArticleAssetRenderer.getArticle();
            String languageId = LanguageUtil.getLanguageId(request);
            com.liferay.portal.kernel.xml.Document xmlDoc = SAXReaderUtil.read(article.getContentByLocale(languageId));
            
            // article.xml, intro.xml, introduction.xml
            String title = xmlDoc.valueOf("//dynamic-element[@name='headline']/dynamic-content/text()");
            
            if (Validator.isNull(title)) {
                // e.g. event.xml, genesis.xml
                title = xmlDoc.valueOf("//dynamic-element[@name='title']/dynamic-content/text()");                
            } 

            if (Validator.isNotNull(title)) {
                entryTitle = title;
            }
        }       
    }
}
else if (assetRenderer != null) {
       
    entryTitle = assetRenderer.getTitle(locale);
    entrySummary = assetRenderer.getSearchSummary(locale);
    
}

if ((assetRendererFactory == null) && viewInContext) {
    viewURL = viewFullContentURL.toString();
}

viewURL = _checkViewURL(themeDisplay, viewURL, currentURL, inheritRedirect);

String[] queryTerms = (String[])request.getAttribute("search.jsp-queryTerms");

PortletURL portletURL = (PortletURL)request.getAttribute("search.jsp-portletURL");
%>

<%-- // Customied: span8 --%>
<span class="asset-entry span8">
<%-- <span class="asset-entry"> --%>
    <span class="asset-entry-type">
        <%= ResourceActionsUtil.getModelResource(themeDisplay.getLocale(), className) %>

        <c:if test="<%= locale != summary.getLocale() %>">
            <liferay-ui:icon image='<%= "../language/" + LocaleUtil.toLanguageId(summary.getLocale()) %>' message='<%= LanguageUtil.format(locale, "this-result-comes-from-the-x-version-of-this-web-content", LocaleUtil.getLongDisplayName(summary.getLocale(), new HashSet<String>())) %>' />
        </c:if>
    </span>

    <span class="asset-entry-date">
        <%= dateFormatDate.format(publishTime) %>
    </span>
    
    <span class="asset-entry-title">
        <a href="<%= viewURL %>">
            <c:if test="<%= assetRenderer != null %>">
                <img alt="" src="<%= assetRenderer.getIconPath(renderRequest) %>" />
            </c:if>
            
            <%= StringUtil.highlight(HtmlUtil.escape(entryTitle), queryTerms) %>
        </a>

        <c:if test="<%= Validator.isNotNull(downloadURL) %>">
            <liferay-ui:icon image="../arrows/01_down" label="<%= false %>" message='<%= LanguageUtil.format(pageContext, "download-x", HtmlUtil.escape(entryTitle)) %>' url="<%= downloadURL %>" />
        </c:if>
    </span>

    <%
    String[] assetCategoryIds = document.getValues(Field.ASSET_CATEGORY_IDS);
    String[] assetTagNames = document.getValues(Field.ASSET_TAG_NAMES);
    %>

    <c:if test="<%= Validator.isNotNull(entrySummary) || Validator.isNotNull(assetCategoryIds[0]) || Validator.isNotNull(assetTagNames[0]) %>">
        <div class="asset-entry-content">
            <c:if test="<%= Validator.isNotNull(entrySummary) %>">
                <span class="asset-entry-summary">
                    <%= StringUtil.highlight(HtmlUtil.escape(entrySummary), queryTerms) %>
                </span>
            </c:if>

            <c:if test="<%= Validator.isNotNull(assetTagNames[0]) %>">
                <div class="asset-entry-tags">

                    <%
                    for (int i = 0; i < assetTagNames.length; i++) {
                        String assetTagName = assetTagNames[i].trim();

                        PortletURL tagURL = PortletURLUtil.clone(portletURL, renderResponse);

                        tagURL.setParameter(Field.ASSET_TAG_NAMES, assetTagName);
                    %>

                        <c:if test="<%= i == 0 %>">
                            <div class="taglib-asset-tags-summary">
                        </c:if>

                        <a href="<%= tagURL.toString() %>"><span class="icon-tag"></span> <%= assetTagName %></a>
<%--                         <a class="tag" href="<%= tagURL.toString() %>"><%= assetTagName %></a> --%>

                        <c:if test="<%= (i + 1) == assetTagNames.length %>">
                            </div>
                        </c:if>

                    <%
                    }
                    %>

                </div>
            </c:if>

            <c:if test="<%= Validator.isNotNull(assetCategoryIds[0]) %>">
                <div class="asset-entry-categories">

                    <%
                    Locale assetCategoryLocale = locale;

                    if (locale != summary.getLocale()) {
                        assetCategoryLocale = summary.getLocale();
                    }

                    for (int i = 0; i < assetCategoryIds.length; i++) {
                        long assetCategoryId = GetterUtil.getLong(assetCategoryIds[i]);

                        AssetCategory assetCategory = null;

                        try {
                            assetCategory = AssetCategoryLocalServiceUtil.getCategory(assetCategoryId);
                        }
                        catch (NoSuchCategoryException nsce) {
                        }

                        if ((assetCategory == null) || !permissionChecker.hasPermission(assetCategory.getGroupId(), assetCategory.getModelClassName(), assetCategory.getPrimaryKey(), ActionKeys.VIEW)) {
                            continue;
                        }

                        AssetVocabulary assetVocabulary = AssetVocabularyLocalServiceUtil.getVocabulary(assetCategory.getVocabularyId());

                        PortletURL categoryURL = PortletURLUtil.clone(portletURL, renderResponse);

                        categoryURL.setParameter(Field.ASSET_CATEGORY_IDS, String.valueOf(assetCategory.getCategoryId()));
                    %>

                        <c:if test="<%= i == 0 %>">
                            <div class="taglib-asset-categories-summary">
                            
<%-- Do not display the name of the asset-vocabulary in the search 
                                <span class="asset-vocabulary">
                                    <%= HtmlUtil.escape(assetVocabulary.getTitle(assetCategoryLocale)) %>:
                                </span>
--%>                                
                        </c:if>
                        <a href="<%= categoryURL.toString() %>"><span class="icon-tags"></span>
                            <%= _buildAssetCategoryPath(assetCategory, assetCategoryLocale) %>
                        </a>
<%-- 
                        <a class="asset-category" href="<%= categoryURL.toString() %>">
                            <%= _buildAssetCategoryPath(assetCategory, assetCategoryLocale) %>
                        </a>
--%>
                        <c:if test="<%= (i + 1) == assetCategoryIds.length %>">
                            </div>
                        </c:if>

                    <%
                    }
                    %>

                </div>
            </c:if>
        </div>
    </c:if>
</span>