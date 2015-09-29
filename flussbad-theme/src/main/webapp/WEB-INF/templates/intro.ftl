<#--
    Intro template: Format the Intro structure
    
    Created:    2015-08-28 17:52 by Christian Berndt
    Modified:   2015-09-24 14:57 by Christian Berndt
    Version:    0.9.3
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<#assign bgColor = "#efefef">
<#assign cssClass = "">
<#assign path = "">
<#assign style = "background: white;">

<#if background??>
    <#assign path = "${background.getData()}">
</#if>

<#if backgroundColor??>
    <#assign bgColor = "${backgroundColor.getData()}">
</#if>
    
<#if path?has_content>
    <#assign cssClass = "with-image" >
    <#assign style = "background-image: url('${path}');" >
<#else>
    <#assign style = "background: ${bgColor}">
</#if>

<div class="intro turquois ${cssClass}">
    <div class="keyvisual" style="${style}">
        <div class="claim">
            <h1>${headline.getData()}</h1>
        </div>
    </div>
    <div class="abstracts">
        <div class="container">
            <#if caption.getSiblings()?has_content>
            <#list caption.getSiblings() as cur_caption>
            <div class="span4 abstract">
               <h3>${cur_caption.getData()}</h3>
               <h2>${cur_caption.claim.getData()}</h2>
               <strong>${cur_caption.abstract.getData()}</strong>
                    <#if cur_caption.abstractLink.getData()?has_content>
                        <div>
                            <a href="${cur_caption.abstractLink.getData()}" class="btn" title="${cur_caption.abstractLabel.getData()}">${cur_caption.abstractLabel.getData()}</a>
                        </div>
                    </#if>
            </div>
            </#list>
            </#if>
        </div>
    </div>
    <#if link.getData()?has_content>
        <div class="container link">
            <a href="${link.getData()}" class="btn" title="${label.getData()}">${label.getData()}</a>
        </div>
    </#if>
</div>