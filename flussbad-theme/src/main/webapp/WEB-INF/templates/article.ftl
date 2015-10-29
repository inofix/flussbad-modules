<#--
    article.ftl: Format the article structure

    Created:    2015-08-28 17:50 by Christian Berndt
    Modified:   2015-10-29 17:29 by Christian Berndt
    Version:    1.1.7

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign articleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleService") />
<#assign articleId = getterUtil.getString(.vars['reserved-article-id'].data) />
<#assign article = articleService.getArticle(groupId, articleId) />
<#assign classPK =  article.getResourcePrimKey() />

<#assign categoryService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetCategoryLocalService") />
<#assign categories = categoryService.getCategories("com.liferay.portlet.journal.model.JournalArticle", classPK) />
<#assign language_id = languageUtil.getLanguageId(locale) />

<#assign layoutService = serviceLocator.findService("com.liferay.portal.service.LayoutService") />
<#assign propertyService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetCategoryPropertyService") />
<#assign publicURL = "/web" />

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
        <#assign cssClass = "with-keyvisual" />
        <#assign hasKeyVisual = true />
        <#assign style = "background-image: url('${keyVisual.getData()}&imageThumbnail=3');" />
    </#if>
</#if>

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
                        
                        <#list properties as property>
                            <#if property.key == "layoutUuid">
                                <#assign layoutUuid = property.value />
                                <#assign layout = layoutService.getLayoutByUuidAndGroupId(layoutUuid, groupId, false) />
                                <#assign groupURL = layout.getGroup().getFriendlyURL() />
                                <#assign url = "${publicURL}${groupURL}${layout.friendlyURL}" />
                            </#if>
                        </#list>
                        
                        <#if layoutUuid?has_content >
                            <li>
                                <h3 class="category"><a href="${url}">${category.getTitle(language_id)}</a></h3>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>
            
            <h1 id="section-0">${headline.getData()}</h1>
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
                            <h2>${cur_section.getData()}</h2>
                            
                            <#if imageAboveTheText >
                            
                                <#if cur_section.image.getSiblings()?has_content>
                                    <#assign j = 1 />
                                    <#list cur_section.image.getSiblings() as cur_image >
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
                                
                                <div class="section-body">${cur_section.body.getData()}</div>
                                
                            <#else>
                            
                                <div class="section-body">${cur_section.body.getData()}</div>
                                
                                <#if cur_section.image.getSiblings()?has_content>
                                    <#assign j = 1 />
                                    <#list cur_section.image.getSiblings() as cur_image >
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
                            </#if>
                            
                        </div>
                        <#assign i = i+1 />
                    </#list>
                </#if>
            </#if>
            
            <div class="social-media">
                
<#--                <#assign canonicalURL = portalUtil.getCanonicalURL(viewURL, themeDisplay, layout) > -->
     <#--           String[] tokens = canonicalURL.split("\\?");  -->
     <#--           String shareURL = tokens[0]; -->
                
                <#assign shareURL = "http://neu.flussbad-berlin.de" />
                <#assign backendUrl = "http://neu.flussbad-berlin.de/shariff" /> 
                <#assign mailBody = "Schau mal hier auf www.flussbad-berlin.de" /> 
                <#assign mailSubject = "Schau mal auf www.flussbad-berlin.de" />
                <#assign mailUrl = "mailto:" /> 
                <#assign selectedOrientation = "horizontal" />
                <#assign servicesConfig = "[&quot;facebook&quot;,&quot;twitter&quot;,&quot;mail&quot;]" /> 
                <#assign selectedTheme = "standard" />
                <#assign twitterVia = "flussbad" /> 
            
                <span class="tell-others"><#-- <liferay-ui:message key="tell-others" /> -->Weitersagen: </span>
                <div class="shariff" data-backend-url="${backendUrl}"
                    data-url="${shareURL}" data-mail-body="${mailBody}"
                    data-mail-subject="${mailSubject}" data-mail-url="${mailUrl}"
                    data-orientation="${selectedOrientation}"
                    data-services="${servicesConfig}"
                    data-theme="${selectedTheme}" data-twitter-via="${twitterVia}"></div>
            </div>            
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
                                <#if cur_section.getData()?has_content >
                                    <li class="">
                                        <a href="#section-${i}">${cur_section.getData()}</a>
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
</div> <#-- / .story -->