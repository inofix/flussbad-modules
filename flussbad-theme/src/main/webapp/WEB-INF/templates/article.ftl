<#--
    article.ftl: Format the article structure

    Created:    2015-08-28 17:50 by Christian Berndt
    Modified:   2016-06-12 13:47 by Christian Berndt
    Version:    1.2.6

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign currentURL = "">
<#assign groupURL = "" />
<#assign layout = ""/>
<#assign namespace = "" />
<#assign pathFriendlyURL = "" />
<#assign plid = "0" />
<#assign themeDisplay = "" />

<#-- request['theme-display'] is not available in search -->
<#if request['theme-display']?? >
    <#assign namespace = request['portlet-namespace'] />
    <#assign themeDisplay = request['theme-display'] />
    <#assign plid = themeDisplay['plid'] />
    <#assign pathFriendlyURL = themeDisplay['path-friendly-url-public'] />
</#if>

<#assign articleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleService") />
<#assign articleId = getterUtil.getString(.vars['reserved-article-id'].data) />
<#assign article = articleService.getArticle(groupId, articleId) />
<#assign classPK =  article.getResourcePrimKey() />

<#assign categoryService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetCategoryLocalService") />
<#assign categories = categoryService.getCategories("com.liferay.portlet.journal.model.JournalArticle", classPK) />
<#assign language_id = languageUtil.getLanguageId(locale) />

<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") />
<#assign propertyService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetCategoryPropertyService") />

<#if plid?number gt 0 >
    <#assign layout = layoutLocalService.getLayout(plid?number) />
    <#assign groupURL = layout.group.friendlyURL />
</#if>

<#if request.attributes?? >
    <#assign currentURL = request.attributes['CURRENT_URL']/>
</#if>
<#assign pathAndGroupURL = pathFriendlyURL + groupURL />

<#-- with virtualhost configured -->
<#assign prefix = "" />

<#-- without virtualhost configured -->
<#if currentURL?starts_with(pathFriendlyURL)>
    <#assign prefix = pathAndGroupURL />
</#if>

<#assign layout_url = prefix + layout.friendlyURL />

<#assign cssClass = "" />
<#assign displayToc = false />
<#assign hasKeyVisual = false />

<#if showToc?? >
    <#if showToc.getData()?has_content>
        <#if getterUtil.getBoolean(showToc.getData())>
            <#assign displayToc = getterUtil.getBoolean(showToc.getData()) />
        </#if>
    </#if>
</#if>

<#if keyVisual??>
    <#if keyVisual.getData()?has_content>
        <#assign hasKeyVisual = true />
        <#assign style = "background-image: url('${keyVisual.getData()}&imageThumbnail=3');" />
    </#if>
</#if>

<#if hasKeyVisual >
    <#assign cssClass = "with-keyvisual" />
<#else>
    <#assign cssClass = "without-keyvisual" />
</#if>

<#macro images section>   
    <#if section.image.getSiblings()?has_content>
        <#assign j = 1 />
        <#list section.image.getSiblings() as cur_image >
            <#assign path = "${cur_image.getData()}" />
            <#if path?has_content>
                <img id="story-image-${i}-${j}" data-src="${path}&imageThumbnail=3"/>
                <#if cur_image.caption??>
                    <div class="caption">${cur_image.caption.getData()}</div>
                </#if>
             </#if>
             <#assign j = j+1 /> 
        </#list>
    </#if>
</#macro>

<#macro video section>
    <#if section.url?has_content>
<#--    <#if section.url??> -->
        <#if section.url.getData()?has_content>  
        
            <#assign config = "&format=json" />    
            <#assign embed_url = section.service.getData() + section.url.getData() + config />
            <#assign embed_url = httpUtil.encodeURL(embed_url) />
            
            <div id="${namespace}_${i}_video" class="video">&nbsp;</div>
            
            <script>
            <!--       
                var ${namespace}_${i}_oEmbedURL = "${layout_url}?p_p_id=proxyportlet_WAR_proxyportlet&p_p_lifecycle=2&_proxyportlet_WAR_proxyportlet_embedURL= ${embed_url}";
                                                             
                $( document ).ready(function() {            
                    ${namespace}_${i}_loadFrame();            
                });
                
                function ${namespace}_${i}_loadFrame() {
                
                    /**
                     * oEmbed
                     */
                    $.get( ${namespace}_${i}_oEmbedURL, function( str ) {
                    
                         var data = JSON.parse(str);
                         var html = data.html;
                         var videoHeight = data.height; 
                         var videoWidth = data.width; 
                         
                         var windowWidth = $(window).width();
                         
                         // set size of youtube iframe 
                         var width = windowWidth; 
                                                                                                  
                         width = 770;              // bootstrap span8
                         
                         if (windowWidth < 1200) {
                             width = 620;           // bootstrap span8
                         }
                         if (windowWidth < 980) {
                            width = windowWidth - 30;    // 100% - padding
                         }                     
                         if (windowWidth < 768) {
                            width = windowWidth - 30;    // 100% - padding
                         }                   
                                 
                         // set width of vimeo iframe
                         html = html.replace("1280", "100%");       // vimeo
                         
                         var height = (width / 16) * 9;
                         
                         // youtube sizes its videos with the iframe
                         html = html.replace(videoWidth, width);        // youtube default width
                         html = html.replace(videoHeight, height);      // youtube default height
                                          
                         $("#${namespace}_${i}_video").html(html);                  
                             
                    });          
                };        
            -->
            </script>                                        
            
        </#if>
    </#if>                             

</#macro>

<div class="story ${cssClass}">
    <#if hasKeyVisual>
        <div class="keyvisual" style="${style}"></div>
    </#if>
    <div class="container">
        <#assign cssStyle = "content span8 offset2" />
        
        <#if displayToc >
            <#assign cssStyle = "content span8" />       
        </#if>  

        <#if hasKeyVisual >
            <#if displayToc >
                <#assign cssStyle = "content span8 offset1" /> 
            <#else>
                <#assign cssStyle = "content span8 offset2" />             
            </#if>      
        </#if>      

        <div class="${cssStyle}">
        
            <#if categories?size gt 0 >
                <ul>
                    <#list categories as category >
                    
                        <#assign properties = propertyService.getCategoryProperties(category.getCategoryId()) />
                        <#assign layoutUuid = ""/>
                        <#assign categoryURL = "" />
                        <#list properties as property>
                            <#if property.key == "layoutUuid">
                                <#assign layoutUuid = property.value />
                                <#assign layout = layoutLocalService.getLayoutByUuidAndGroupId(layoutUuid, groupId, false) />
                                <#assign groupURL = layout.getGroup().getFriendlyURL() />
                                <#assign categoryURL = prefix + layout.friendlyURL />
                            </#if>
                        </#list>
                        
                        <#if layoutUuid?has_content >
                            <li>
                                <h3 class="category"><a href="${categoryURL}">${category.getTitle(language_id)}</a></h3>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>
            
            <#if headline??>
                <#if headline.getData()?has_content>
                    <h1 id="section-0">${headline.getData()}</h1>
                </#if>
            </#if>
            <p class="lead">${teaser.getData()}</p>
            <#if section?? >
                <#if section.getSiblings()?has_content>
                    <#assign i = 1 />
                    <#list section.getSiblings() as cur_section>
                    
                        <#assign imageAboveTheText = false />
                        
                        <#if cur_section.imageAboveTheText??>
                            <#assign imageAboveTheText = getterUtil.getBoolean(cur_section.imageAboveTheText.getData()) />
                        </#if>
                    
                        <div class="section" id="section-${i}">
                        
                            <#if cur_section.getData()?has_content>
                                <h2>${cur_section.getData()}</h2>
                            </#if>
                            
                            <#if imageAboveTheText >
                            
                                <@video cur_section/>
                                
                                <@images cur_section/>
                                
                                <#if cur_section.body??>
                                    <#if cur_section.body.getData()?has_content>                                
                                        <div class="section-body">${cur_section.body.getData()}</div>
                                    </#if>
                                </#if>
                                
                            <#else>
 
                                <#if cur_section.body??>
                                    <#if cur_section.body.getData()?has_content>                            
                                        <div class="section-body">${cur_section.body.getData()}</div>
                                    </#if>
                                </#if>
                                
                                <@video cur_section/>
                                
                                <@images cur_section/>
                                                              
                            </#if>
                            
                        </div>
                        <#assign i = i+1 />
                    </#list>
                </#if>
            </#if>
            
            <#-- Include the common social-media snippet --> 
            <#include "${templatesPath}/72079" /> 
             
                          
        </div> <#-- / .span8 -->
        
        <#if displayToc>
            <#if hasKeyVisual >
                <#assign cssClass = "span3" />
            <#else>
                <#assign cssClass = "span4" />            
            </#if>
        
            <div class="${cssClass}">
                <div class="toc">
                    <ul class="nav nav-list">                        
                        <#if section.getSiblings()?has_content>
                            <#assign i = 1 />
                            <#list section.getSiblings() as cur_section >
                                <#assign label = cur_section.getData() />
                                <#if cur_section.label??>
                                    <#if cur_section.label.getData()?has_content>
                                        <#assign label = cur_section.label.getData() /> 
                                    </#if>
                                </#if>
                                <#if label?has_content >
                                    <li class="">
                                        <a href="#section-${i}">${label}</a>
                                    </li>
                                </#if>
                                <#assign i = i+1 />
                            </#list>
                        </#if>
                    </ul>
                </div> <#-- / .toc -->
            </div> <#-- / .span3 / 4 -->
        </#if>
    </div> <#-- / .container -->
</div> <#-- / .article -->
