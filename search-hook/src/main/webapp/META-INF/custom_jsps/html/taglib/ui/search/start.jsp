<%--
    start.jsp: A customized start.jsp for Liferay's ui:search tag. 
    Customized sections are marked with the comment: 
    // Customized .
    
    The following customization have been made: 
    
    - use font-awesome icons.
        
    Created:    2016-06-13 15:41 by Christian Berndt
    Modified:   2016-07-08 21:13 by Christian Berndt
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

<%@ include file="/html/taglib/ui/search/init.jsp" %>

<%
long groupId = ParamUtil.getLong(request, namespace + "groupId");

Group group = themeDisplay.getScopeGroup();

String keywords = ParamUtil.getString(request, namespace + "keywords");

PortletURL portletURL = null;

if (portletResponse != null) {
    LiferayPortletResponse liferayPortletResponse = (LiferayPortletResponse)portletResponse;

    portletURL = liferayPortletResponse.createLiferayPortletURL(PortletKeys.SEARCH, PortletRequest.RENDER_PHASE);
}
else {
    portletURL = new PortletURLImpl(request, PortletKeys.SEARCH, plid, PortletRequest.RENDER_PHASE);
}

portletURL.setParameter("struts_action", "/search/search");
portletURL.setParameter("redirect", currentURL);
portletURL.setPortletMode(PortletMode.VIEW);
//Customized: do not maximize
//portletURL.setWindowState(WindowState.MAXIMIZED);

pageContext.setAttribute("portletURL", portletURL);
%>

<form action="<%= HtmlUtil.escapeAttribute(portletURL.toString()) %>" method="get" name="<%= randomNamespace %><%= namespace %>fm" onSubmit="<%= randomNamespace %><%= namespace %>search(); return false;">
<liferay-portlet:renderURLParams varImpl="portletURL" />

<%-- Customization: wrap fields into two fieldset elements --%>
<fieldset>
<aui:fieldset>
<%-- Customization: wrap input into a control-group element --%>
<div class="control-group control-group-inline">
<%-- Customization: add placeholder attribute--%>
    <input name="<%= namespace %>keywords" size="30" title="<liferay-ui:message key="search" />" type="text" value="<%= HtmlUtil.escapeAttribute(keywords) %>" placeholder='<liferay-ui:message key="search" />...' />
    <%--     <aui:input inlineField="<%= true %>" label="" name='<%= namespace + "keywords" %>' size="30" title="search" type="text" useNamespace="<%= false %>" value="<%= HtmlUtil.escapeAttribute(keywords) %>" /> --%>
</div>
    <aui:select inlineField="<%= true %>" label="" name='<%= namespace + "groupId" %>' title="scope" useNamespace="<%= false %>">
        <c:if test="<%= !group.isStagingGroup() %>">
            <aui:option label="everything" selected="<%= (groupId == 0) %>" value="0" />
            <aui:option label='<%= "this-" + (group.isOrganization() ? "organization" : "site") %>' selected="<%= (groupId != 0) %>" value="<%= group.getGroupId() %>" />
        </c:if>

    </aui:select>
<%-- Customization: use font-awesome search icon instead of search.png --%>
    <div class="control-group control-group-inline">
        <button id="<portlet:namespace/>search" name="<portlet:namespace/>search" type="submit" value="">
            <i id="<portlet:namespace/>searchIcon" class="icon-search"></i>
        </button>
    </div>
<%--     <aui:input inlineField="<%= true %>" label="" name="search" src='<%= themeDisplay.getPathThemeImages() + "/common/search.png" %>' title="search" type="image" /> --%>
</aui:fieldset>
</fieldset>

<aui:script>
    function <%= randomNamespace %><%= namespace %>search() {
        var keywords = document.<%= randomNamespace %><%= namespace %>fm.<%= namespace %>keywords.value;

        keywords = keywords.replace(/^\s+|\s+$/, '');

        if (keywords != '') {
            submitForm(document.<%= randomNamespace %><%= namespace %>fm);
        }
    }
</aui:script>