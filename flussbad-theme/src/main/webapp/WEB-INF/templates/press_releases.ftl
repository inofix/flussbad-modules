<#--
    press_releases.ftl: Loop over a list of asset-entries and
    format them in press-release fashion.
    
    Created:    2015-11-07 09:32 by Christian Berndt
    Modified:   2015-11-07 09:32 by Christian Berndt
    Version:    1.0.0
-->

<#assign dateFormat = "dd MMM yyyy" />
<#assign journalArticleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService") />
<#assign languageId = languageUtil.getLanguageId(request) >

<#if entries?has_content>
    <div class="container press-releases">
        <div class="span8 offset1">
            <h3><@liferay.language key="press-releases" /></h3>
            <#list entries as curEntry>   
                <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                <#assign document = saxReaderUtil.read(article.getContentByLocale(languageId)) />
                <#assign title = document.valueOf("//dynamic-element[@name='headline']/dynamic-content/text()") />
                <#assign assetRenderer = curEntry.getAssetRenderer() />
                <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, null) />                                             
                <h1><a href="${viewURL}">${title}</a></h1>
                <div class="publish-date">${dateUtil.getDate(entry.getPublishDate(), dateFormat, locale)}</div>
            </#list>
        </div>
    </div>
</#if>
