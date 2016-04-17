<#--
    media_gallery.ftl: Loop over a list of asset-entries and
    format them in as a gallery.
    
    Created:    2016-04-16 13:07 by Christian Berndt
    Modified:   2016-04-16 13:07 by Christian Berndt
    Version:    1.0.0
-->

<#assign fileEntryService  = serviceLocator.findService("com.liferay.portlet.documentlibrary.service.DLFileEntryLocalService") />
<#assign journalArticleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService") />

<#assign namespace = renderResponse.namespace />
<#assign current_url = "" />
<#--
<#assign current_url = request.attributes['CURRENT_URL'] />
-->
<#assign path_friendly_url = "" />
<#--
<#assign path_friendly_url = theme_display['path-friendly-url-public'] />
-->
<#assign layout = themeDisplay.layout />
<#assign group_url = layout.group.friendlyURL />       

<#assign path_and_group_url = path_friendly_url + group_url />

<#-- with virtualhost configured -->
<#assign prefix = "" />

<#-- without virtualhost configured -->
<#if current_url?starts_with(path_friendly_url)>
    <#assign prefix = path_and_group_url />
</#if>    

<#assign layout_url = prefix + layout.friendlyURL />


<!-- Modal slideshow -->
<div class="modal slideshow fade" id="modalSlideshow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <div id="slider" class="flexslider">
                    <ul class="slides">
                                    
                        <#if entries?has_content>                          
                            <#assign i = 1 /> 
                                            
                            <#list entries as entry>
                            
                                <#assign entry = entry />
                                <#assign assetRenderer = entry.assetRenderer />
                                <#assign className = assetRenderer.className />              
                            
                                <#if "com.liferay.portlet.journal.model.JournalArticle" == className >
                                
                                    <#assign article = journalArticleService.getLatestArticle(entry.getClassPK()) />
                                    
                                    <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
                                    
                                    <#assign service = docXml.valueOf("//dynamic-element[@name='service']/dynamic-content/text()") />
                                    <#assign url = docXml.valueOf("//dynamic-element[@name='url']/dynamic-content/text()") />
                                   
                                    <#assign viewURL = ""/>
                                    <#assign assetRenderer = entry.getAssetRenderer() />
                                    
                                    <#if assetRenderer.getURLViewInContext(renderRequest, renderResponse, null)?? >                     
                                        <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, null) />
                                    <#else>
                                        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />                        
                                    </#if>
                                    
                                    <#if url?has_content>
                                    
                                        <#assign config = "&format=json" />    
                                        <#assign embed_url = service + url + config />
                                        <#assign embed_url = httpUtil.encodeURL(embed_url) />
                                        <li>
                                            TODO: Display video.                            
                                        </li>
                                    <#else>
                                        <li>
                                            Only structures of type "Video" can be displayed
                                            in the Media Gallery.
                                        </li>
                                    </#if>
                                
                                <#elseif "com.liferay.portlet.documentlibrary.model.DLFileEntry" == className >
                
                                    <#assign fileEntry = fileEntryService.getFileEntry(entry.classPK) />                
                                    <#assign latestFileVersion = fileEntry.getFileVersion() />
                                    <#assign latestFileVersionStatus = latestFileVersion.getStatus() />
                                    <#assign fileTitle = httpUtil.encodeURL(htmlUtil.unescape(latestFileVersion.getTitle())) />
                                
                                    <#assign imgSrc = "/documents/" + groupId + "/" + fileEntry.folder.folderId + "/" + fileTitle /> 
                                    <#assign caption = latestFileVersion.getDescription() />
                                    <li class="item">
                                        <div class="image-wrapper">
                                            <img src="${imgSrc}?imageThumbnail=3" />
                                        </div>
                                    </li>  
                                    
                                <#else>
                                    <li>
                                        This is neither a video nor a document.
                                    </li>                        
                
                                </#if>
                                
                                <#assign i = i+1 />                    
                    
                            </#list>
                        </#if>
                    </ul>
                </div>                                        
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="template gallery media">
        <#if entries?has_content>                          
            <#assign i = 1 /> 
            
            <div class="row-fluid">          
                
            <#list entries as entry>
            
                <#assign entry = entry />
                <#assign assetRenderer = entry.assetRenderer />
                <#assign className = assetRenderer.className />              
            
                <#if "com.liferay.portlet.journal.model.JournalArticle" == className >
                
                    <#assign article = journalArticleService.getLatestArticle(entry.getClassPK()) />
                    
                    <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
                    
                    <#assign service = docXml.valueOf("//dynamic-element[@name='service']/dynamic-content/text()") />
                    <#assign url = docXml.valueOf("//dynamic-element[@name='url']/dynamic-content/text()") />
                   
                    <#assign viewURL = ""/>
                    <#assign assetRenderer = entry.getAssetRenderer() />
                    
                    <#if assetRenderer.getURLViewInContext(renderRequest, renderResponse, null)?? >                     
                        <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, null) />
                    <#else>
                        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />                        
                    </#if>
                    
                    <#if url?has_content>
                    
                        <#assign config = "&format=json" />    
                        <#assign embed_url = service + url + config />
                        <#assign embed_url = httpUtil.encodeURL(embed_url) />
        
                        <div class="span3" style="height: 200px; background: lightgray;">                            
                            <div id="${namespace}_${i}_video" class="video">&nbsp;</div>
                        </div>
                        
                        <script>
                        <!--       
                            var ${namespace}_${i}_oEmbedURL = "${layout_url}?p_p_id=proxyportlet_WAR_proxyportlet&p_p_lifecycle=2&_proxyportlet_WAR_proxyportlet_embedURL= ${embed_url}";
                                                                         
                            $( document ).ready(function() {            
                                ${namespace}_${i}_loadFrame();            
                            });
                            
                            function ${namespace}_${i}_loadFrame() {
                            
                                /**
                                 * oEmbed
                                 */
                                $.get( ${namespace}_${i}_oEmbedURL, function( str ) {
                                
                                     var data = JSON.parse(str);
                                     var html = data.html;
                                     var videoHeight = data.height; 
                                     var videoWidth = data.width; 
                                     
                                     var windowWidth = $(window).width();
                                     
                                     // set size of youtube iframe 
                                     var width = windowWidth; 
                                                                                                              
                                     width = 770;              // bootstrap span8
                                     
                                     if (windowWidth < 1200) {
                                         width = 620;           // bootstrap span8
                                     }
                                     if (windowWidth < 980) {
                                        width = windowWidth - 30;    // 100% - padding
                                     }                     
                                     if (windowWidth < 768) {
                                        width = windowWidth - 30;    // 100% - padding
                                     }                   
                                             
                                     // set width of vimeo iframe
                                     html = html.replace("1280", "100%");       // vimeo
                                     
                                     var height = (width / 16) * 9;
                                     
                                     // youtube sizes its videos with the iframe
                                     html = html.replace(videoWidth, width);        // youtube default width
                                     html = html.replace(videoHeight, height);      // youtube default height
                                                      
                                     $("#${namespace}_${i}_video").html(html);                  
                                         
                                });          
                            };        
                        -->
                        </script> 
                    
                    <#else>
                        <div class="span3">
                            Only structures of type "Video" can be displayed
                            in the Media Gallery.
                        </div>
                    </#if>
                
                <#elseif "com.liferay.portlet.documentlibrary.model.DLFileEntry" == className >
                
                    <#assign fileEntry = fileEntryService.getFileEntry(entry.classPK) />
                    <#assign latestFileVersion = fileEntry.getFileVersion() />
                    <#assign latestFileVersionStatus = latestFileVersion.getStatus() />
                    <#assign title = httpUtil.encodeURL(htmlUtil.unescape(latestFileVersion.getTitle())) />
                
                    <#assign style = "background-image: url('/documents/" + groupId + "/" + fileEntry.folder.folderId + "/" + title + "?imageThumbnail=3');" /> 
                    <#assign caption = latestFileVersion.getDescription() />              
                
                    <div class="span3">
                    
                        <a href="javascript:;" data-toggle="modal" data-target="#modalSlideshow" data-index="${i}">
                            <div class="image-wrapper" style="${style}">&nbsp;</div>
                        </a>
                        <#if caption?has_content >
                            <div class="caption">${caption}</div>
                        </#if>                    
                    
                    </div>  
                    
                <#else>
                
                    <div class="span3">
                        This is neither a video nor a document.
                    </div>                        
                   
                </#if>            
                
                <#if i%4 == 0 && i gt 0 >
                    </div>
                    <div class="row-fluid">
                </#if>
                
                <#assign i = i+1 />                    
    
            </#list>
            
            </div> <#-- / .row-fluid -->
            
        <#else>
            <div class="alert alert-info"><@liferay.language key="there-are-no-results" /></div>
        </#if>              
    </div> <#-- /.media -->
</div> <#-- /.container -->
