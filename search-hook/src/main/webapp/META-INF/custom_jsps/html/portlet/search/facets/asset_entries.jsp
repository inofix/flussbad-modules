<%--
    asset_entries.jsp: A customized asset_entries.jsp 
    for Liferay's default search portlet.
    
    The following customization have been applied: 
    
    - use font-awesome icons instead of image files
        
    Created:    2016-02-15 09:36 by Christian Berndt
    Modified:   2016-05-14 19:28 by Christian Berndt
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

<%@ include file="/html/portlet/search/facets/init.jsp" %>

<%@page import="com.liferay.portlet.wiki.model.WikiPage"%>
<%@page import="com.liferay.portlet.journal.model.JournalFolder"%>
<%@page import="com.liferay.portlet.journal.model.JournalArticle"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFolder"%>
<%@page import="com.liferay.portlet.documentlibrary.model.DLFileEntry"%>

<%
int frequencyThreshold = dataJSONObject.getInt("frequencyThreshold");
boolean showAssetCount = dataJSONObject.getBoolean("showAssetCount", true);

String[] values = new String[0];

if (dataJSONObject.has("values")) {
    JSONArray valuesJSONArray = dataJSONObject.getJSONArray("values");

    values = new String[valuesJSONArray.length()];

    for (int i = 0; i < valuesJSONArray.length(); i++) {
        values[i] = valuesJSONArray.getString(i);
    }
}
%>

<div class="<%= cssClass %>" data-facetFieldName="<%= HtmlUtil.escapeAttribute(facet.getFieldId()) %>" id="<%= randomNamespace %>facet">
    <aui:input name="<%= HtmlUtil.escapeAttribute(facet.getFieldId()) %>" type="hidden" value="<%= fieldParam %>" />

    <ul class="asset-type nav nav-pills nav-stacked">
        <li class="facet-value default <%= Validator.isNull(fieldParam) ? "active" : StringPool.BLANK %>">
            <a data-value="" href="javascript:;"><aui:icon image="search" /> <liferay-ui:message key="everything" /></a>
        </li>

        <%
        List<String> assetTypes = new SortedArrayList<String>(new ModelResourceComparator(locale));

        for (String className : values) {
            if (assetTypes.contains(className)) {
                continue;
            }

            if (!ArrayUtil.contains(values, className)) {
                continue;
            }

            assetTypes.add(className);
        }

        for (String assetType : assetTypes) {
            TermCollector termCollector = facetCollector.getTermCollector(assetType);
        %>

            <c:if test="<%= fieldParam.equals(termCollector.getTerm()) %>">
                <aui:script use="liferay-token-list">
                    Liferay.Search.tokenList.add(
                        {
                            clearFields: '<%= renderResponse.getNamespace() + HtmlUtil.escapeJS(facet.getFieldId()) %>',
                            text: '<%= HtmlUtil.escapeJS(ResourceActionsUtil.getModelResource(locale, assetType)) %>'
                        }
                    );
                </aui:script>
            </c:if>

        <%
            int frequency = 0;

            if (termCollector != null) {
                frequency = termCollector.getFrequency();
            }

            if (frequencyThreshold > frequency) {
                continue;
            }

            AssetRendererFactory assetRendererFactory = AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(assetType);
            
            // Custom checks
            String iconClass =  "icon-file"; 

            if (DLFileEntry.class.getName().equals(assetType)) {
                iconClass = "icon-picture";
            }
            else if (DLFolder.class.getName().equals(assetType)) {
                iconClass = "icon-folder-open";
            }
            else if (JournalArticle.class.getName().equals(assetType)) {
                iconClass = "icon-file-alt";
            }
            else if (JournalFolder.class.getName().equals(assetType)) {
                iconClass = "icon-folder-open-alt";
            }
            else if (User.class.getName().equals(assetType)) {
                iconClass = "icon-user";
            }
            else if (WikiPage.class.getName().equals(assetType)) {
                iconClass = "icon-file-alt";
            }
        %>

            <li class="facet-value <%= fieldParam.equals(termCollector.getTerm()) ? "active" : StringPool.BLANK %>">
                <a data-value="<%= HtmlUtil.escapeAttribute(assetType) %>" href="javascript:;">
                    <c:if test="<%= assetRendererFactory != null %>">
                        <span class="<%= iconClass %>"></span>
                        <%= assetRendererFactory.getTypeName(locale, false) %>
<%--                         <img alt="" src="<%= assetRendererFactory.getIconPath(renderRequest) %>" /> --%>
                    </c:if>

                    <c:if test="<%= showAssetCount %>">
                        <span class="badge badge-info frequency"><%= frequency %></span>
                    </c:if>
                </a>
            </li>

        <%
        }
        %>

    </ul>
</div>