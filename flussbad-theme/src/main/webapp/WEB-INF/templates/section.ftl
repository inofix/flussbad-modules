<#--
    section.ftl: Format the section structure

    Created:    2015-11-01 11:24 by Christian Berndt
    Modified:   2015-11-01 17:25 by Christian Berndt
    Version:    1.0.1

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
            
                <#-- Include the common social-media snippet -->
                <#include "${templatesPath}/72079" />            
                 
            </#if>      
        </div> <#-- / .span8 -->        
    </div> <#-- / .container -->
</div> <#-- / .story -->
