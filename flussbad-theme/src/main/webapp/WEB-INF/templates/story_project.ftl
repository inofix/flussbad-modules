<#--
    story_project.ftl: Format the project article structure

    Created:    2015-10-16 19:04 by Christian Berndt
    Modified:   2015-10-16 21:34 by Christian Berndt
    Version:    1.0.1

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign cssClass = "">
<#assign displayToc = false>
<#assign hasKeyVisual = false>

<#if showToc??>
    <#if showToc.getData()?has_content>
        <#if getterUtil.getBoolean(showToc.getData())>
            <#assign displayToc = getterUtil.getBoolean(showToc.getData())>
        </#if>
    </#if>
</#if>

<#if keyVisual??>
    <#if keyVisual.getData()?has_content>
        <#assign cssClass = "with-keyvisual" >
        <#assign hasKeyVisual = true>
        <#assign style = "background-image: url('${keyVisual.getData()}&imageThumbnail=3');" >
    </#if>
</#if>

<div class="story ${cssClass}">
    <#if hasKeyVisual>
        <div class="keyvisual" style="${style}"></div>
    </#if>
    <div class="container">
        <#assign cssStyle = "content span8 offset2">

        <#if displayToc>
            <#assign cssStyle = "content span8 offset1">
        </#if>

        <div class="${cssStyle}">
            <h3 class="category"><a href="javascript:history.back();">Category</a></h3>
            <h1 id="section-0">${headline.getData()}</h1>
            <p class="lead">${teaser.getData()}</p>
            <#if section.getSiblings()?has_content>
                <#assign i = 1>
                <#list section.getSiblings() as cur_section>
                
                    <#assign path = "${cur_section.image.getData()}">
                    <#assign imageAboveTheText = false>
                    <#if cur_section.imageAboveTheText??>
                        <#assign imageAboveTheText = getterUtil.getBoolean(cur_section.imageAboveTheText.getData())>
                    </#if>
                
                    <div class="section" id="section-${i}">
                        <h2>${cur_section.getData()}</h2>
                        
                        <#if imageAboveTheText >
                            <#if path?has_content>
                                <img id="storyImage${i}" data-src="${path}&imageThumbnail=3"/>
                            </#if>
                            <div class="section-body">${cur_section.body.getData()}</div>
                        <#else >
                            <div class="section-body">${cur_section.body.getData()}</div>
                            <#if path?has_content>
                                <img id="storyImage${i}" data-src="${path}&imageThumbnail=3"/>
                            </#if>
                        </#if>
                        
                    </div>
                    <#assign i = i+1>
                </#list>
            </#if>
        </div>
        <#if displayToc>
            <div class="toc span2 offset8">
                <ul class="nav nav-list bs-docs-sidenav">
                    <li class="active"><a href="#section-0"><i class="icon-chevron-right"></i>Start</a></li>
                    <#if section.getSiblings()?has_content>
                        <#assign i = 1>
                        <#list section.getSiblings() as cur_section>
                            <#if cur_section.getData()?has_content>
                                <li class="">
                                    <a href="#section-${i}"><i class="icon-chevron-right"></i>${cur_section.getData()}</a>
                                </li>
                            </#if>
                            <#assign i = i+1>
                        </#list>
                    </#if>
                </ul>
            </div>
        </#if>
    </div>
</div>