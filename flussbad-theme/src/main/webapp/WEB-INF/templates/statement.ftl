<#--
    statement.ftl: Format the Statement structure
    
    Created:    2015-09-29 11:28 by Christian Berndt
    Modified:   2015-10-14 12:28 by Christian Berndt
    Version:    0.9.4
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#if statement.getSiblings()?has_content>
    <#list statement.getSiblings() as cur_statement>
        <div class="container">
            <blockquote>${cur_statement.getData()}</blockquote>
            <cite class="author pull-right">${cur_statement.author.getData()}</cite>
        </div>
    </#list>
</#if>