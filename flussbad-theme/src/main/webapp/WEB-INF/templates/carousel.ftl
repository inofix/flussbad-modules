<#--
    Carousel template: Format the Carousel structure
    
    Created:    2015-08-28 17:51 by Christian Berndt
    Modified:   2015-09-28 11:54 by Christian Berndt
    Version:    0.9.4
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<div class="slide-show">
    <div id="scrollview-container">
      <div class="yui3-scrollview-loading carousel scrollview-content">
            <#if image.getSiblings()?has_content>
                <#list image.getSiblings() as cur_image>
                    <div class="item">
                        <!--
                        <div class="carousel-caption">
                            <h1>${cur_image.caption.getData()}</h1>
                        </div>
                        -->
                        <img src="${cur_image.getData()}" title="${cur_image.caption.getData()}">
                    </div>
                </#list>
            </#if>
        </div>
        <a class="left carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="prev"><span>&#x279c;</span></a>
        <a class="right carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="next"><span>&#x279c;</span></a>
    </div>
</div>