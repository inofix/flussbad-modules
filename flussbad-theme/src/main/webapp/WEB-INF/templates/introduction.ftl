<#--
    introduction.ftl: Format the introduction structure
    
    Created:    2015-10-15 23:58 by Christian Berndt
    Modified:   2015-11-02 19:43 by Christian Berndt
    Version:    1.0.6
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign themeDisplay = request['theme-display'] />
<#assign plid = themeDisplay['plid'] />
<#assign layoutService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") />
<#assign layout = layoutService.getLayout(plid?number) />
<#assign title = layout.getName(locale) />
<#assign groupURL = layout.getGroup().getFriendlyURL() />
<#assign publicURL = "/web" />
<#assign backURL = "${publicURL}${groupURL}${layout.getFriendlyURL()}" />
<#assign parentPlid = layout.getParentPlid() >

<#if parentPlid gt 0>
    <#assign parentLayout = layoutService.getLayout(parentPlid) />
    <#assign title = parentLayout.getName(locale) />
    <#assign backURL = "${publicURL}${groupURL}${parentLayout.getFriendlyURL()}" />
</#if>

<#assign style = "" />
<#assign displayToc = false />
<#assign displayPointer = false />

<#if keyVisual??>
    <#if keyVisual.getData()?has_content>
        <#assign style = "background-image: url('${keyVisual.getData()}&imageThumbnail=3');" />
    </#if>
</#if>

<#if showToc?? >
    <#if showToc.getData()?has_content>
        <#if getterUtil.getBoolean(showToc.getData())>
            <#assign displayToc = getterUtil.getBoolean(showToc.getData()) />
        </#if>
    </#if>
</#if>

<#if showPointer?? >
    <#if showPointer.getData()?has_content>
        <#if getterUtil.getBoolean(showPointer.getData())>
            <#assign displayPointer = getterUtil.getBoolean(showPointer.getData()) />
        </#if>
    </#if>
</#if>

<#assign fullWidth = false />

<#if displayFullWidth?? >
    <#if displayFullWidth.getData()?has_content>
        <#if getterUtil.getBoolean(displayFullWidth.getData())>
            <#assign fullWidth = getterUtil.getBoolean(displayFullWidth.getData()) />
        </#if>
    </#if>
</#if>

<#assign cssStyle = "span8 offset2">

<#if fullWidth >
    <#assign cssStyle = "span10 offset1">
<#elseif displayToc >
    <#assign cssStyle = "span8 offset1">
</#if>

<div class="introduction with-keyvisual">
    <div class="keyvisual" style="${style}"></div>
    <div class="container">
        <div class="content ${cssStyle}">
            <h3 class="category"><a href="${backURL}">${title}</a></h3>
            <h1>${headline.getData()}</h1>
            <p class="lead">${teaser.getData()}</p>
            <div class="section">
                <div class="section-body">${description.getData()}</div>
            </div>
            <#if displayPointer >
                <h3 class="category">Alle Artikel zum Thema ${layout.getName(locale)}</h3>
                <div class="pointer"><span class="icon-arrow-down"></span></div>
            </#if>
        </div> <#-- /.content -->
        
        <#if displayToc>
        
            <div class="span3">
                <div class="toc">
                    <ul class="nav nav-list">                        
                        <li>TODO: retrieve the layouts modules </li>
                    </ul>
                </div> <#-- / .toc -->
            </div> <#-- / .span3 -->
        </#if>        
    </div> <#-- /.container -->
</div> <#-- /.introduction -->
