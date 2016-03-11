<%--
    page.jsp: A customized page.jsp for Liferay's asset-links tag.
    Customized sections are marked with the comment: 
    // Customized .    
        
    Created:    2016-03-11 09:34 by Christian Berndt
    Modified:   2015-03-11 09:34 by Christian Berndt
    Version:    1.0.0
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

<%@ include file="/html/taglib/ui/asset_links/init.jsp" %>

<%
long assetEntryId = GetterUtil.getLong((String)request.getAttribute("liferay-ui:asset-links:assetEntryId"));

List<AssetLink> assetLinks = null;

if (assetEntryId > 0) {
    assetLinks = AssetLinkLocalServiceUtil.getDirectLinks(assetEntryId);
}
%>

<c:if test="<%= (assetLinks != null) && !assetLinks.isEmpty() %>">
    <div class="taglib-asset-links">
        <h2 class="asset-links-title"><liferay-ui:message key="related-assets" />:</h2>

        <ul class="asset-links-list">

            <%
            for (AssetLink assetLink : assetLinks) {
                AssetEntry assetLinkEntry = null;

                if (assetLink.getEntryId1() == assetEntryId) {
                    assetLinkEntry = AssetEntryLocalServiceUtil.getEntry(assetLink.getEntryId2());
                }
                else {
                    assetLinkEntry = AssetEntryLocalServiceUtil.getEntry(assetLink.getEntryId1());
                }

                if (!assetLinkEntry.isVisible()) {
                    continue;
                }

                assetLinkEntry = assetLinkEntry.toEscapedModel();

                String className = PortalUtil.getClassName(assetLinkEntry.getClassNameId());

                AssetRendererFactory assetRendererFactory = AssetRendererFactoryRegistryUtil.getAssetRendererFactoryByClassName(className);

                if (Validator.isNull(assetRendererFactory)) {
                    if (_log.isWarnEnabled()) {
                        _log.warn("No asset renderer factory found for class " + className);
                    }

                    continue;
                }

                if (!assetRendererFactory.isActive(company.getCompanyId())) {
                    continue;
                }

                AssetRenderer assetRenderer = assetRendererFactory.getAssetRenderer(assetLinkEntry.getClassPK());

                if (assetRenderer.hasViewPermission(permissionChecker)) {
                    String asseLinktEntryTitle = assetLinkEntry.getTitle(locale);

                    LiferayPortletURL assetPublisherURL = new PortletURLImpl(request, PortletKeys.ASSET_PUBLISHER, plid, PortletRequest.RENDER_PHASE);

                    assetPublisherURL.setParameter("struts_action", "/asset_publisher/view_content");
                    assetPublisherURL.setParameter("redirect", currentURL);
                    assetPublisherURL.setParameter("assetEntryId", String.valueOf(assetLinkEntry.getEntryId()));
                    assetPublisherURL.setParameter("type", assetRendererFactory.getType());

                    if (Validator.isNotNull(assetRenderer.getUrlTitle())) {
                        if (assetRenderer.getGroupId() != themeDisplay.getSiteGroupId()) {
                            assetPublisherURL.setParameter("groupId", String.valueOf(assetRenderer.getGroupId()));
                        }

                        assetPublisherURL.setParameter("urlTitle", assetRenderer.getUrlTitle());
                    }

                    if (themeDisplay.isStatePopUp()) {
                        assetPublisherURL.setWindowState(LiferayWindowState.POP_UP);
                    }
                    else {
                        assetPublisherURL.setWindowState(WindowState.MAXIMIZED);
                    }

                    String viewFullContentURLString = assetPublisherURL.toString();

                    viewFullContentURLString = HttpUtil.setParameter(viewFullContentURLString, "redirect", currentURL);

                    String urlViewInContext = assetRenderer.getURLViewInContext((LiferayPortletRequest)portletRequest, (LiferayPortletResponse)portletResponse, viewFullContentURLString);

                    urlViewInContext = HttpUtil.setParameter(urlViewInContext, "inheritRedirect", true);
// Customized
// Remove the noSuchEntryRedirect from viewInContext URL 
// because a yet unresolved error in the flussbad installation
// causes errors. Probably the error is caused by a NoSuchLayoutException
// in FindAction.java, line 117 ff. and might be fixed by the correct
// reconfiguration of the default display page.
                    urlViewInContext = HttpUtil.removeParameter(urlViewInContext, "noSuchEntryRedirect");
            %>

                    <li class="asset-links-list-item">
                        <liferay-ui:icon
                            label="<%= true %>"
                            message="<%= asseLinktEntryTitle %>"
                            src="<%= assetRenderer.getIconPath(portletRequest) %>"
                            url="<%= urlViewInContext %>"
                        />
                    </li>

            <%
                }
            }
            %>

        </ul>
    </div>
</c:if>

<%!
private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.taglib.ui.asset_links.page_jsp");
%>
