<%--
    fb_event_title.jsp: A custom asset-publisher style where 
    
    - the date and title is read from the event-structure's fields
    
    Created:    2015-10-02 10:29 by Christian Berndt
    Modified:   2015-10-08 17:38 by Christian Berndt
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

<%-- Include fb-abstract specific setup code --%>
<%@ include file="/html/portlet/asset_publisher/display/fb_init.jsp" %>

<c:if test="<%= show %>">

<%-- 
    Customization: read the color-scheme from the current category 
--%> 
    <div class="asset-abstract <%= defaultAssetPublisher ? "default-asset-publisher" : StringPool.BLANK %> fb-event-title <%= scheme %>">
         
        <liferay-util:include page="/html/portlet/asset_publisher/asset_actions.jsp" />
<%-- 
    Customization: wrap the asset's content sections into a bootstrap container. 
--%> 
     
	    <div class="container">  
	    
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
        </div> <!-- /.container -->
    </div><!-- /.asset-abstract -->
</c:if>