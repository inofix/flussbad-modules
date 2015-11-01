<#--
    section.ftl: Format the section structure

    Created:    2015-11-01 11:24 by Christian Berndt
    Modified:   2015-11-01 11:24 by Christian Berndt
    Version:    1.0.0

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign displaySocialMedia = false />
<#assign cssStyle = "offset2" />     

<#if offset?? >
    <#assign cssStyle = offset.getData() />  
</#if>

<#if showSocialMedia?? >
    <#if showSocialMedia.getData()?has_content>
        <#if getterUtil.getBoolean(showSocialMedia.getData())>
            <#assign displaySocialMedia = getterUtil.getBoolean(showSocialMedia.getData()) />
        </#if>
    </#if>
</#if>

<div class="story">

    <div class="container">

        <div class="content span8 ${cssStyle}">

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

            <#if displaySocialMedia >            
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
                </div> <#-- / .social-media -->  
            </#if>      
        </div> <#-- / .span8 -->        
    </div> <#-- / .container -->
</div> <#-- / .story -->
