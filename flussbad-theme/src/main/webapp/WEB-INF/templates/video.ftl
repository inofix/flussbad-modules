<#--
    video.ftl: Format the video structure

    Created:    2016-04-06 21:32 by Christian Berndt
    Modified:   2016-04-06 21:32 by Christian Berndt
    Version:    1.0.0

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") />

<#if request['theme-display']??>

    <#assign current_url = request.attributes['CURRENT_URL']/>
    <#assign group_url = "" />
    <#assign theme_display = request['theme-display'] />
    <#assign namespace = request['portlet-namespace'] />
    <#assign path_friendly_url = theme_display['path-friendly-url-public'] />   
    <#assign path_and_group_url = path_friendly_url + group_url />
    <#assign plid = theme_display['plid'] />
    <#assign proxy_ns = "proxyportlet_WAR_proxyportlet" />
    
    
    <#if plid?number gt 0 >
        <#assign layout = layoutLocalService.getLayout(plid?number) />
        <#assign group_url = layout.group.friendlyURL />       
    </#if>
    
    <#assign path_and_group_url = path_friendly_url + group_url />
    
    <#-- with virtualhost configured -->
    <#assign prefix = "" />
    
    <#-- without virtualhost configured -->
    <#if current_url?starts_with(path_friendly_url)>
        <#assign prefix = path_and_group_url />
    </#if>    
    
    <#assign layout_url = prefix + layout.friendlyURL />
    
        <div id="${namespace}_video">&nbsp;</div>
        
    <div class="container">    
    </div>
    
        
    <#assign config = "&format=json" />
    <#assign embed_url = service.getData() + url.getData() + config />
    <#assign embed_url = httpUtil.encodeURL(embed_url) />
    <#--
    -->
    
    <script>
    <!--
        
     var oEmbedURL = "${layout_url}?p_p_id=proxyportlet_WAR_proxyportlet&p_p_lifecycle=2&_proxyportlet_WAR_proxyportlet_embedURL= ${embed_url}";
    
     $( document ).ready(function() {
     
        var windowWidth = $(window).width();
        console.log(oEmbedURL);
//        oEmbedURL = oEmbedURL + "&width=" + windowWidth;
//        console.log(oEmbedURL);
//        oEmbedURL = encodeURIComponent(oEmbedURL);
        console.log(oEmbedURL);
        
        /**
         * oEmbed
         */
        $.get( oEmbedURL, function( str ) {
             var data = JSON.parse(str);
             var html = data.html;
             
             // set width of iframe
             html = html.replace("1280", "100%"); 
              $("#${namespace}_video").html(html);
        });
    
    });
    -->
    </script>

</#if>
