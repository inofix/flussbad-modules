<#--
    statements.ftl: Display a list of statements in a scrollview-carousel.
    
    Created:    2015-10-13 18:27 by Christian Berndt
    Modified:   2015-10-22 18:37 by Christian Berndt
    Version:    1.0.1
-->

<#assign journalArticleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService")>

<#assign cssClass = "gray-green">

<div class="statements ${cssClass}">
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

<script>
YUI().use(
  'aui-carousel',
  function(Y) {
    new Y.Carousel(
      {
        activeIndex: 'rand',
        contentBox: '.statements',
        height: (Y.one("body").get("winWidth") / 16) * 9 - 60,
        intervalTime: 20,
        width: Y.one("body").get("winWidth")
      }
    ).render();
  }
);
</script>
