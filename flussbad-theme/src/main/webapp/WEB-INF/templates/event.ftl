<#--
    event.ftl: Format the event structure
    
    Created:    2015-10-01 19:09 by Christian Berndt
    Modified:   2015-10-27 21:12 by Christian Berndt
    Version:    0.9.2
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign date = getterUtil.getLong(date.getData()) />

<div class="event">
    <div class="container">
        <div class="row">
            <div class="span4">
                <div class="metadata">
                    <#if (date gt 0)>
                        <#assign dateObj = dateUtil.newDate(date) />
                        <div class="date">${dateUtil.getDate(dateObj, "dd MMM yyyy", locale)}</div>
                    </#if>                   
                    <#if hour.getData()?has_content >
                        <div class="time">
                            <#if minute.getData()?has_content >
                                <span class="icon-time"></span>${hour.getData()}:${minute.getData()}
                            <#else>
                                <span class="icon-time"></span>${hour.getData()}:00                      
                            </#if>
                        </div>
                    </#if> 
                    <#if location.getData()?has_content >
                        <div class="location">
                            <span class="icon-map-marker"></span>
                            ${location.getData()}
                        </div>
                    </#if>
                </div> <#-- /.asset-metadata -->
            </div> <#-- /.span4 -->
            
            <div class="content span8">
            
                <h1>${title.getData()}</h1>
                <div class="lead">${summary.getData()}</div>
                <#if section.getSiblings()?has_content>
                    <#list section.getSiblings() as cur_section>
                        <div class="section">
                            <h2>${cur_section.getData()}</h2>
                            <#if cur_section.body??>
    	                        <div class="section-body">${cur_section.body.getData()}</div>
                            </#if>
                        </div>
                    </#list>
                </#if> 
                
                <#-- TODO: merge with the social media configuration from article.ftl -->
                <div class="social-media">
                    
    <#--                <#assign canonicalURL = portalUtil.getCanonicalURL(viewURL, themeDisplay, layout) > -->
         <#--           String[] tokens = canonicalURL.split("\\?");  -->
         <#--           String shareURL = tokens[0]; -->
                    
                    <#assign shareURL = "http://neu.flussbad-berlin.de" />
                    <#assign backendUrl = "http://neu.flussbad-berlin.de/shariff" /> 
                    <#assign mailBody = "Schau mal hier auf www.flussbad-berlin.de" /> 
                    <#assign mailSubject = "Schau mal auf www.flussbad-berlin.de" />
                    <#assign mailUrl = "mailto:" /> 
                    <#assign selectedOrientation = "horizontal" />
                    <#assign servicesConfig = "[&quot;facebook&quot;,&quot;twitter&quot;,&quot;mail&quot;]" /> 
                    <#assign selectedTheme = "standard" />
                    <#assign twitterVia = "flussbad" /> 
                
                    <span class="tell-others"><#-- <liferay-ui:message key="tell-others" /> -->Weitersagen: </span>
                    <div class="shariff" data-backend-url="${backendUrl}"
                        data-url="${shareURL}" data-mail-body="${mailBody}"
                        data-mail-subject="${mailSubject}" data-mail-url="${mailUrl}"
                        data-orientation="${selectedOrientation}"
                        data-services="${servicesConfig}"
                        data-theme="${selectedTheme}" data-twitter-via="${twitterVia}"></div>
                </div>                
                
            </div> <#-- /.span8 -->
        </div> <#-- /.row -->
    </div> <#-- /.container -->
</div> <#-- /.event -->