<#--
    Story template: Format the Story structure
    
    Created:    2015-08-28 17:50 by Christian Berndt
    Modified:   2015-10-07 22:45 by Christian Berndt
    Version:    1.0.0
    
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
        <#assign style = "background-image: url('${keyVisual.getData()}');" >
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
            <h3 class="category"><a href="#">Category</a></h3>
            <h1 id="section-0">${headline.getData()}</h1>
            <p class="lead">${teaser.getData()}</p>
            <#if section.getSiblings()?has_content>
                <#assign i = 1>
                <#list section.getSiblings() as cur_section>
                    <div class="section" id="section-${i}">
                        <h2>${cur_section.getData()}</h2>
                        <div class="section-body">${cur_section.body.getData()}</div>
                        
                        <#assign path = "${cur_section.image.getData()}">
                        
                        <#if path?has_content>
                            <img src="${path}"/>
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
