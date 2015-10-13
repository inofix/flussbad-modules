<#--
    Carousel template: Format the Carousel structure

    Created:    2015-08-28 17:51 by Christian Berndt
    Modified:   2015-10-13 22:22 by Michael Lustenberger
    Version:    0.9.6

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->
<div class="slide-show">
    <div id="scrollview-container">
      <div class="yui3-scrollview-loading carousel scrollview-content">
            <#if image.getSiblings()?has_content>
                <#assign i = 0 >
                <#list image.getSiblings() as cur_image>
                    <div class="item">
                        <!--
                        <div class="carousel-caption">
                            <h1>${cur_image.caption.getData()}</h1>
                        </div>
                        -->
                        <#if i gt 0>
                            <img data-src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}">
                        <#else>
                            <img src="${cur_image.getData()}&imageThumbnail=3" title="${cur_image.caption.getData()}">
                        </#if>
                    </div>
                    <#assign i = i+1>
                </#list>
            </#if>
        </div>
        <a class="left carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="prev"><span>&#x279c;</span></a>
        <a class="right carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="next"><span>&#x279c;</span></a>
    </div>
</div>
