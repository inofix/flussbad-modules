<#--
    Statement template: Format the Statement structure
    
    Created:    2015-09-29 11:28 by Christian Berndt
    Modified:   2015-09-29 21:41 by Christian Berndt
    Version:    0.9.1
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<#assign cssClass = "">

<#if colorScheme??>
    <#assign cssClass = "${cssClass}" + " " + "${colorScheme.getData()}">
</#if>

<div class="statement ${cssClass}">
    <div id="scrollview-container">
      <div class="yui3-scrollview-loading carousel scrollview-content">
        <#if statement.getSiblings()?has_content>
            <#list statement.getSiblings() as cur_statement>
                <!--
                <div class="item" style="background-image: url('bootstrap-2.3.2/docs/assets/img/examples/slide-01.jpg'); ">
                -->
                <div class="item">
                <div class="container">
                  <div class="carousel-caption">
                    <h1 class="quote">${cur_statement.getData()}</h1>
                    <!--
                    <div class="quote lead">${cur_statement.getData()}</div>
                    -->
                    <div class="author pull-right">${cur_statement.author.getData()}</div>
                  </div>
                </div>
                </div>
            </#list>
        </#if>
    </div>
    <a class="left carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="prev"><span>&#x279c;</span></a>
    <a class="right carousel-control" href="javascript:;" data-carousel-id="myCarousel" data-slide="next"><span>&#x279c;</span></a>
</div>