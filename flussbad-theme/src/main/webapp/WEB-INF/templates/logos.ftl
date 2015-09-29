<#--
    Logos template: Format the Logos structure
    
    Created:    2015-09-02 18:08 by Christian Berndt
    Modified:   2015-09-02 18:08 by Christian Berndt
    Version:    0.9.0
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<div class="logos">
    <div class="container">
        <div class="logos-inner">
        <#if logo.getSiblings()?has_content>
            <#list logo.getSiblings() as cur_logo>
                <a href="${cur_logo.link.getData()}" target="_blank">
                    <img src="${cur_logo.getData()}"/>
                </a>
            </#list>
        </#if>
        </div>
    </div>
</div>