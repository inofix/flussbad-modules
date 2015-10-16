<#--
    introduction.ftl: Format the introduction structure
    
    Created:    2015-10-15 23:58 by Christian Berndt
    Modified:   2015-10-16 17:49 by Christian Berndt
    Version:    1.0.2
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign style = "" >

<#if keyVisual??>
    <#if keyVisual.getData()?has_content>
        <#assign style = "background-image: url('${keyVisual.getData()}&imageThumbnail=3');" >
    </#if>
</#if>


<div class="introduction with-keyvisual">
    <div class="keyvisual" style="${style}"></div>
    <div class="container">
        <div class="content span8 offset2">
            <h3 class="category"><a href="javascript:history.back();">Category</a></h3>
            <h1>${headline.getData()}</h1>
            <p class="lead">${teaser.getData()}</p>
            <div class="section">
                <div class="section-body">${description.getData()}</div>
            </div>
        </div>
    </div>
</div>
