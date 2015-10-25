<%--
    view.jsp: a customized version of the site-map's 
    view.jsp which includes the custom toggle_button.jspf. 
    
    When you have to upgrade the toggle-button-hook to a new release, 
    simply replace anything below this comment with the then current
    view.jsp of the site-map portlet and include the
    toggle_button.jspf.
        
    Created:    2015-10-09 19:01 by Christian Berndt
    Modified:   2015-10-25 18:06 by Christian Berndt
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

<%@ include file="/html/portlet/site_map/init.jsp" %>

<%
List<Layout> rootLayouts = LayoutLocalServiceUtil.getLayouts(layout.getGroupId(), layout.isPrivateLayout(), rootLayoutId);

long portletDisplayDDMTemplateId = PortletDisplayTemplateUtil.getPortletDisplayTemplateDDMTemplateId(displayStyleGroupId, displayStyle);
%>

<%-- Custom site-map-wrapper class --%>
<div class="site-map-wrapper">
	<c:choose>
	    <c:when test="<%= portletDisplayDDMTemplateId > 0 %>">
	        <%= PortletDisplayTemplateUtil.renderDDMTemplate(pageContext, portletDisplayDDMTemplateId, rootLayouts) %>
	    </c:when>
	    <c:otherwise>
	
	        <%
	        StringBundler sb = new StringBundler();
	
	        _buildSiteMap(layout, rootLayouts, rootLayout, includeRootInTree, displayDepth, showCurrentPage, useHtmlTitle, showHiddenPages, 1, themeDisplay, sb);
	        %>
	
	        <%= sb.toString() %>
	    </c:otherwise>
	</c:choose>
</div> <%-- / .site-map-wrapper --%>
<%!
private void _buildLayoutView(Layout layout, String cssClass, boolean useHtmlTitle, ThemeDisplay themeDisplay, StringBundler sb) throws Exception {
    String layoutURL = PortalUtil.getLayoutURL(layout, themeDisplay);
    String target = PortalUtil.getLayoutTarget(layout);

    sb.append("<a href=\"");
    sb.append(layoutURL);
    sb.append("\" ");
    sb.append(target);

    if (Validator.isNotNull(cssClass)) {
        sb.append(" class=\"");
        sb.append(cssClass);
        sb.append("\" ");
    }

    sb.append("> ");

    String layoutName = HtmlUtil.escape(layout.getName(themeDisplay.getLocale()));

    if (useHtmlTitle) {
        layoutName = HtmlUtil.escape(layout.getHTMLTitle(themeDisplay.getLocale()));
    }

    sb.append(layoutName);
    sb.append("</a>");
}

private void _buildSiteMap(Layout layout, List<Layout> layouts, Layout rootLayout, boolean includeRootInTree, int displayDepth, boolean showCurrentPage, boolean useHtmlTitle, boolean showHiddenPages, int curDepth, ThemeDisplay themeDisplay, StringBundler sb) throws Exception {
    if (layouts.isEmpty()) {
        return;
    }

    sb.append("<ul>");

    if (includeRootInTree && (rootLayout != null) && (curDepth == 1)) {
        sb.append("<li>");

        String cssClass = "root";

        if (rootLayout.getPlid() == layout.getPlid()) {
            cssClass += " current";
        }

        _buildLayoutView(rootLayout, cssClass, useHtmlTitle, themeDisplay, sb);

        _buildSiteMap(layout, layouts, rootLayout, includeRootInTree, displayDepth, showCurrentPage, useHtmlTitle, showHiddenPages, curDepth +1, themeDisplay, sb);

        sb.append("</li>");
    }
    else {
        for (Layout curLayout : layouts) {
            if ((showHiddenPages || !curLayout.isHidden()) && LayoutPermissionUtil.contains(themeDisplay.getPermissionChecker(), curLayout, ActionKeys.VIEW)) {
                sb.append("<li>");

                String cssClass = StringPool.BLANK;

                if (curLayout.getPlid() == layout.getPlid()) {
                    cssClass = "current";
                }

                _buildLayoutView(curLayout, cssClass, useHtmlTitle, themeDisplay, sb);

                if ((displayDepth == 0) || (displayDepth > curDepth)) {
                    if (showHiddenPages) {
                        _buildSiteMap(layout, curLayout.getChildren(), rootLayout, includeRootInTree, displayDepth, showCurrentPage, useHtmlTitle, showHiddenPages, curDepth + 1, themeDisplay, sb);
                    }
                    else {
                        _buildSiteMap(layout, curLayout.getChildren(themeDisplay.getPermissionChecker()), rootLayout, includeRootInTree, displayDepth, showCurrentPage, useHtmlTitle, showHiddenPages, curDepth + 1, themeDisplay, sb);
                    }
                }

                sb.append("</li>");
            }
        }
    }

    sb.append("</ul>");
}
%>

<%-- Custom include --%>
<%@ include file="/html/portlet/toggle_button.jspf" %>
