<#--
    statements.ftl: Display a list of statements in a scrollview-carousel.
    
    Created:    2015-10-13 18:27 by Christian Berndt
    Modified:   2015-10-13 18:27 by Christian Berndt
    Version:    1.0.0
-->

<#assign journalArticleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService")>

<#assign cssClass = "gray-green">

<div class="statement ${cssClass}">
    <div id="scrollview-container">
      <div class="yui3-scrollview-loading carousel scrollview-content">
        <#if entries?has_content>
            <#list entries as curEntry>
                <div class="item">

                    <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK())>
                    <#assign content = journalContentUtil.getContent(themeDisplay.getScopeGroupId(), article.getArticleId(), article.getTemplateId(), themeDisplay.getLanguageId(), themeDisplay)>
                    ${content}

                </div>
            </#list>
        </#if>
    </div>
    <a class="left carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="prev"><span>&#x279c;</span></a>
    <a class="right carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="next"><span>&#x279c;</span></a>
</div>