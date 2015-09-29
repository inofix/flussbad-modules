<#--
    Link template: Format the Link structure
    
    Created:    2015-09-29 11:36 by Christian Berndt
    Modified:   2015-09-29 11:36 by Christian Berndt
    Version:    0.9.0
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<div class="container link">
    <a href="${target.getFriendlyUrl()}">
        ${target.label.getData()}
    </a>
</div>