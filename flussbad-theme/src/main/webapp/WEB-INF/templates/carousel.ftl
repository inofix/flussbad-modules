<#--
    Carousel template: Format the Carousel structure

    Created:    2015-08-28 17:51 by Christian Berndt
    Modified:   2015-10-25 14:01 by Christian Berndt
    Version:    0.9.7

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
                <li class="item">
                    <#if i gt 0>
                        <img src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}">
<#--                        <img data-src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}"> -->
                    <#else>
                        <img src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}">
                    </#if>
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
        animationLoop: false,
        slideshow: false,
        pauseOnHover: true,
        controlNav: false,
        prevText:"",      
        nextText:""      
      });
    });
</script>
