<%--
    fb_abstract.jsp: A custom asset-publisher style where 
    
    - the asset's metadata is displayed BEFORE the title and summary
    - the title is read from the structure's headline or title field
    - the event-title and event-location is read from the structures's respective fields
    - the color-scheme property is read from the applied categories
    - shariff-based social media buttons are included 
    
    Created:    2015-07-28 11:53 by Christian Berndt
    Modified:   2015-10-26 07:44 by Christian Berndt
    Version:    1.1.5
--%>

<%-- Include fb-abstract specific setup code --%>
<%@ include file="/html/portlet/asset_publisher/display/fb_init.jsp" %>

<c:if test="<%= show %>">

	<div class="asset-abstract <%= defaultAssetPublisher ? "default-asset-publisher" : StringPool.BLANK %> <%= isFiltered ? "filtered" : StringPool.BLANK %> fb-abstract <%= Validator.isNotNull(cssStyle) ? "with-keyvisual" : StringPool.BLANK %> <%= isEvent ? "event" : StringPool.BLANK %> <%= scheme %>" style="<%= cssStyle %>">
         
        <liferay-util:include page="/html/portlet/asset_publisher/asset_actions.jsp" />
    
	    <div class="container"> 
	    	<div class="row">

		 		<div class="span4">
			        <div class="asset-metadata">
			        			      			        		        			        
                        <c:if test="<%= Validator.isNotNull(eventDate) %>">
                            <span class="metadata-entry metadata-event-date"><%= dateFormatDate.format(eventTime) %></span>
                        </c:if>
                       
                        <c:if test="<%= Validator.isNotNull(hour) %>">
                            <span class="metadata-entry metadata-event-time">
		                        <c:choose>
		                           <c:when test="<%= Validator.isNotNull(minute) %>">
		                               <span class="icon-time"></span><%= hour %>:<%= minute %>
		                           </c:when>
		                           <c:otherwise>
		                               <span class="icon-time"></span><%= hour %>:00
		                           </c:otherwise>
		                        </c:choose> 
                            </span>
                        </c:if>                       			           
			            
			            <c:if test="<%= Validator.isNotNull(location) %>">
			                <span class="metadata-entry metadata-event-location">
				                 <span class="icon-map-marker"></span>
	                             <%= location %>
			                 </span>
			            </c:if>			
						
			            <%
			            request.setAttribute("asset_metadata.jspf-filterByMetadata", true);
			            %>
			
			            <%-- include the metadata (the publishdate and categories) only of no eventDate is available --%>
                        <c:if test="<%= Validator.isNull(eventDate) %>">
				            <%@ include file="/html/portlet/asset_publisher/asset_metadata.jspf" %>
			            </c:if>
			        </div>
		        </div>
		
				<div class="span8">
			        <h3 class="asset-title">  
			        
			            <% 
			                // Do not display a link for Genesis objects
							if (isGenesis) {
							    viewURL = null; 
							}
                        %>         
		                 
				        <c:choose>
				            <c:when test="<%= Validator.isNotNull(viewURL) %>">
				                <a href="<%= viewURL %>"><img alt="" src="<%= assetRenderer.getIconPath(renderRequest) %>" /> <%= HtmlUtil.escape(title) %></a>
				            </c:when>
				            <c:otherwise>
				                <img alt="" src="<%= assetRenderer.getIconPath(renderRequest) %>" /> <%= HtmlUtil.escape(title) %>
				            </c:otherwise>
				        </c:choose>
		
			        </h3>
			        
                   <c:if test="<%= !isGenesis %>">

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
				        
						<%-- Include flussbad's social-media-buttons --%>
						<%@ include file="/html/portlet/asset_publisher/display/fb_social.jspf" %>
        
                    </c:if>
                    
		        </div> <!-- /.span8 -->
			</div> <!-- /.row -->
        </div> <!-- /.container -->
    </div> <!-- /.asset-abstract -->
</c:if>
