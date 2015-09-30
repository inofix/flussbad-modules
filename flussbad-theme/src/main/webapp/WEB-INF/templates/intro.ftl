<#--
    Intro template: Format the Intro structure
    
    Created:    2015-08-28 17:52 by Christian Berndt
    Modified:   2015-09-30 11:22 by Christian Berndt
    Version:    0.9.6
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<#assign cssClass = "">
<#assign path = "">
<#assign style = "background: white;">

<#if background??>
    <#assign path = "${background.getData()}">
</#if>
    
<#if path?has_content>
    <#assign cssClass = "with-image" >
    <#assign style = "background-image: url('${path}');" >
</#if>

<#if backgroundColor??>
    <#assign cssClass = "${cssClass}" + " " + "${backgroundColor.getData()}">
</#if>

<div class="intro ${cssClass}">

    <div class="keyvisual" style="${style}">
        <div class="claim">
            <h1>${headline.getData()}</h1>
        </div>
    </div>
    <div class="abstracts">
        <div class="container club-link">
            <div class="span4 offset8">
            </div>
        </div>
        <div class="container">
            <#if caption.getSiblings()?has_content>
                <#assign i = 0 >
                <#list caption.getSiblings() as cur_caption>
                    <#if (i < 3) >                   
                        <div class="span4">
                            <div class="abstract">
                                <#if i==2>
                                    <button class="club-link" href="#" title="TODO">Werde aktiv!</button>
                                </#if>
                                <h3>${cur_caption.getData()}</h3>
                                <h2>${cur_caption.claim.getData()}</h2>
                                <div>${cur_caption.abstract.getData()}</div>
                                <#if cur_caption.abstractLink.getData()?has_content>
                                    <div>
                                        <a href="${cur_caption.abstractLink.getData()}" class="btn" title="${cur_caption.abstractLabel.getData()}">${cur_caption.abstractLabel.getData()}</a>
                                    </div>
                                </#if>
                            </div>
                        </div>
                        <#assign i = i+1>
                    </#if>
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