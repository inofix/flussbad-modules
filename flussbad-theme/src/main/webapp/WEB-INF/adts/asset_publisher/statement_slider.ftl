<#--
    statement_slider.ftl: Display a list of statements in a scrollview-carousel.
    
    Created:    2015-10-13 18:27 by Christian Berndt
    Modified:   2016-04-22 17:00 by Christian Berndt
    Version:    1.0.5
-->

<#assign journalArticleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService") />

<#assign cssClass = "gray-green" />

<div class="statements flexslider ${cssClass}">
    <#if entries?has_content>
        <ul class="slides">
        <#list entries as curEntry>
            <li class="item">

                <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                <#assign content = journalContentUtil.getContent(themeDisplay.getScopeGroupId(), article.getArticleId(), article.getTemplateId(), themeDisplay.getLanguageId(), themeDisplay) />
                ${content}

            </li>
        </#list>
        </ul>
    </#if>
</div>
