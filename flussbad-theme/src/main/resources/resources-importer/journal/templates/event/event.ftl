<#--
    event.ftl: Format the event structure
    
    Created:    2015-10-01 19:09 by Christian Berndt
    Modified:   2015-11-01 17:27 by Christian Berndt
    Version:    0.9.3
    
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
                
                <#-- Include the common social-media snippet -->
                <#include "${templatesPath}/72079" />                
                
            </div> <#-- /.span8 -->
        </div> <#-- /.row -->
    </div> <#-- /.container -->
</div> <#-- /.event -->