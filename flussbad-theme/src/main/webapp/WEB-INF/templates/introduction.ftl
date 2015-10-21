<#--
    introduction.ftl: Format the introduction structure
    
    Created:    2015-10-15 23:58 by Christian Berndt
    Modified:   2015-10-19 15:02 by Christian Berndt
    Version:    1.0.3
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign themeDisplay = request['theme-display'] >
<#assign plid = themeDisplay['plid'] >
<#assign layoutService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") />
<#assign layout = layoutService.getLayout(plid?number) >
<#assign title = layout.getName(locale) >
<#assign groupURL = layout.getGroup().getFriendlyURL() >
<#assign publicURL = "/web" >
<#assign backURL = "${publicURL}${groupURL}${layout.getFriendlyURL()}" >
<#assign parentPlid = layout.getParentPlid() >

<#if parentPlid gt 0>
    <#assign parentLayout = layoutService.getLayout(parentPlid) >
    <#assign title = parentLayout.getName(locale) >
    <#assign backURL = "${publicURL}${groupURL}${parentLayout.getFriendlyURL()}" >
</#if>

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
            <h3 class="category"><a href="${backURL}">${title}</a></h3>
            <h1>${headline.getData()}</h1>
            <p class="lead">${teaser.getData()}</p>
            <div class="section">
                <div class="section-body">${description.getData()}</div>
            </div>
        </div>
    </div>
</div>
