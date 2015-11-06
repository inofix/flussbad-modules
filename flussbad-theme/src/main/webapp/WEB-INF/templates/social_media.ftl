<#--
    social_media.ftl: social_media.ftl is a template which displays
    social-media-buttons with the shariff.js (which is imported via
    the social-media-portlet). It can be included by any freemarker
    template.

    Created:    2015-11-01 11:41 by Christian Berndt
    Modified:   2015-11-06 18:30 by Christian Berndt
    Version:    1.0.2

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign articleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleService") />
<#assign articleId = getterUtil.getString(.vars['reserved-article-id'].data) />
<#assign article = articleService.getArticle(groupId, articleId) />
<#assign urlTitle = article.urlTitle />

<#assign shareURL = "http://www.flussbad-berlin.de/-/${urlTitle}" />

<#assign backendUrl = "http://www.flussbad-berlin.de/shariff" /> 
<#assign mailBody = "Schau mal hier auf www.flussbad-berlin.de" /> 
<#assign mailSubject = "Schau mal auf www.flussbad-berlin.de" />
<#assign mailUrl = "mailto:" /> 
<#assign selectedOrientation = "horizontal" />
<#assign servicesConfig = "[&quot;facebook&quot;,&quot;twitter&quot;,&quot;mail&quot;]" /> 
<#assign selectedTheme = "standard" />
<#assign twitterVia = "flussbad" />

<div class="social-media">
    <span class="tell-others"><#-- <liferay-ui:message key="tell-others" /> -->Weitersagen: </span>
    <div class="shariff" data-backend-url="${backendUrl}"
    data-url="${shareURL}" data-mail-body="${mailBody}"
    data-mail-subject="${mailSubject}" data-mail-url="${mailUrl}"
    data-orientation="${selectedOrientation}"
    data-services="${servicesConfig}"
    data-theme="${selectedTheme}" data-twitter-via="${twitterVia}">
    </div>
</div> <#-- / .social-media -->
