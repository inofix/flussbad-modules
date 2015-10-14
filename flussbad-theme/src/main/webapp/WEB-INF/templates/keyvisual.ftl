<#--
    Keyvisual template: Format the Keyvisual structure
    
    Created:    2015-10-11 11:54 by Christian Berndt
    Modified:   2015-10-14 18:55 by Christian Berndt
    Version:    1.0.1
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#if keyvisual.getData()?has_content>
    <#assign style = "background-image: url('${keyvisual.getData()}&imageThumbnail=3');" >
</#if>


<div class="introduction">
    <div class="keyvisual" style="${style}"></div>
</div>