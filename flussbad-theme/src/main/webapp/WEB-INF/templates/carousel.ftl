<#--
    carousel.ftl: Format the carousel structure

    Created:    2015-08-28 17:51 by Christian Berndt
    Modified:   2015-11-03 21:22 by Christian Berndt
    Version:    1.0.0

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->
<div class="slide-show flexslider">
    <#if image.getSiblings()?has_content>
        <ul class="slides">
            <#assign i = 0 >
            <#list image.getSiblings() as cur_image>
            
                <#assign style = "background-image: url('${cur_image.getData()}&imageThumbnail=3');" >
                
                <#if i gt 0>
<#--                        <img data-src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}"> -->
                <#else>
<#--                    <img src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}"> -->
                </#if>
                <li class="item" style="${style}" >
                    <#if cur_image.caption.getData()?has_content>
                        <p class="flex-caption">${cur_image.caption.getData()}</p>
                    </#if>
                </li>
                <#assign i = i+1>
            </#list>
        </ul>
    </#if>
</div>

<script>
    $( document ).ready(function() {
      $('.flexslider').flexslider({
        animation: "slide",
        controlNav: false,
        nextText:"",     
        pauseOnHover: true,
        prevText:"",      
        slideshow: true
      });
    });
</script>