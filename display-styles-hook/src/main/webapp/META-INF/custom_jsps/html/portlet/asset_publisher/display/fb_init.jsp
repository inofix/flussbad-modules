<%--
    fb_init.jsp: Common setup-code for the flussbad-displays and abstracts.
    
    Created:    2015-10-08 16:48 by Christian Berndt
    Modified:   2017-02-13 18:50 by Christian Berndt
    Version:    1.0.8
--%>

<%@ include file="/html/portlet/asset_publisher/init.jsp" %>

<%-- Import classes required by customization --%>
<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>

<%@page import="com.liferay.portal.kernel.xml.Document"%>
<%@page import="com.liferay.portal.kernel.xml.Node"%>
<%@page import="com.liferay.portal.kernel.xml.SAXReaderUtil"%>

<%@page import="com.liferay.portlet.asset.service.AssetCategoryPropertyServiceUtil"%>
<%@page import="com.liferay.portlet.asset.model.AssetCategoryProperty"%>
<%@page import="com.liferay.portlet.journal.asset.JournalArticleAssetRenderer"%>

<%
	// From Liferay's default abstract.jsp
	List results = (List)request.getAttribute("view.jsp-results");
	
	int assetEntryIndex = ((Integer)request.getAttribute("view.jsp-assetEntryIndex")).intValue();
	
	AssetEntry assetEntry = (AssetEntry)request.getAttribute("view.jsp-assetEntry");
	AssetRendererFactory assetRendererFactory = (AssetRendererFactory)request.getAttribute("view.jsp-assetRendererFactory");
	AssetRenderer assetRenderer = (AssetRenderer)request.getAttribute("view.jsp-assetRenderer");
	
	boolean show = ((Boolean)request.getAttribute("view.jsp-show")).booleanValue();
	
	request.setAttribute("view.jsp-showIconLabel", true);
	
	String title = (String)request.getAttribute("view.jsp-title");
	
	if (Validator.isNull(title)) {
	    title = assetRenderer.getTitle(locale);
	}
	
	String viewURL = AssetPublisherHelperImpl.getAssetViewURL(liferayPortletRequest, liferayPortletResponse, assetEntry, viewInContext);
	
	String viewURLMessage = viewInContext ? assetRenderer.getViewInContextMessage() : "read-more-x-about-x";
	
	String summary = StringUtil.shorten(assetRenderer.getSummary(locale), abstractLength);
	
	List<AssetCategory> assetCategories = AssetCategoryServiceUtil.getCategories(assetEntry.getClassName(), assetEntry.getClassPK());
	
	AssetCategory assetCategory = null; 
	
	if (assetCategories.size() > 0) {
	    assetCategory = assetCategories.get(0); 
	}
	
	String scheme = StringPool.BLANK; 
	
	if (assetCategory != null) {
	    
	    List<AssetCategoryProperty> categoryProperties = AssetCategoryPropertyServiceUtil.getCategoryProperties(assetCategory.getCategoryId());
	    
	    for (AssetCategoryProperty categoryProperty : categoryProperties) {
	        
	        if ("color-scheme".equals(categoryProperty.getKey())) {
	            
	            String value = categoryProperty.getValue(); 
	            
	            if (Validator.isNotNull(value)) {
	                scheme = value; 
	            }
	        }
	    }
	}

	//Customization: for journal-article assets try to use the journal-article's
	//articleTitle, which can be retrieved from an article's structure.
	
	String articleTitle = null;
	String description = null;
	String cssStyle = "";
	long eventTime = 0;
	String eventDate = null;
	String hour = null; 
	boolean isEvent = false;
	boolean isFiltered = assetCategoryId > 0;
    boolean isGenesis = false;
	String keyVisual = null;
	String location = null;
	String minute = null; 
	String structureId = null;
	String fbDescription = null; 
	
	String languageId = LanguageUtil.getLanguageId(request);
	
	if (JournalArticle.class.getName()
	        .equals(assetEntry.getClassName())) {
	
	    JournalArticleAssetRenderer journalRenderer = (JournalArticleAssetRenderer) assetRenderer;
	    JournalArticle article = journalRenderer.getArticle();
	
	    if (article != null) {
	        try {
	
	            Document document = SAXReaderUtil.read(article
	                    .getContentByLocale(languageId));
                
                String eventDescription = document.valueOf("//dynamic-element[@name='summary']/dynamic-content/text()");
                String teaser = document.valueOf("//dynamic-element[@name='teaser']/dynamic-content/text()");
                
                if (Validator.isNotNull(eventDescription)) {
                    fbDescription = eventDescription; 
                }                
                if (Validator.isNotNull(teaser)) {
                    fbDescription = teaser; 
                }
	            	            	
                Node bodyNode = document
                        .selectSingleNode("/root/dynamic-element[@name='section']/dynamic-element[@name='body']/dynamic-content");
                
                Node dateNode = document
	                    .selectSingleNode("/root/dynamic-element[@name='date']/dynamic-content");
	
                Node headlineNode = document
                        .selectSingleNode("/root/dynamic-element[@name='headline']/dynamic-content");
    
                Node hourNode = document
                        .selectSingleNode("/root/dynamic-element[@name='hour']/dynamic-content");
    
	            Node locationNode = document
	                    .selectSingleNode("/root/dynamic-element[@name='location']/dynamic-content");
	
                Node minuteNode = document
                        .selectSingleNode("/root/dynamic-element[@name='minute']/dynamic-content");
    
	            Node keyVisualNode = document
	                    .selectSingleNode("/root/dynamic-element[@name='keyVisual']/dynamic-content");
	
	            Node titleNode = document
	                    .selectSingleNode("/root/dynamic-element[@name='title']/dynamic-content");
	            
                if (bodyNode != null && bodyNode.getText().length() > 0) {
                    description = bodyNode.getText();
                }
	            
	            if (dateNode != null) {
	                eventDate = dateNode.getText();
	                eventTime = GetterUtil.getLong(eventDate);
	            }
	
                if (headlineNode != null
                        && headlineNode.getText().length() > 0) {
                    articleTitle = headlineNode.getText();
                }
    
                if (hourNode != null
                        && hourNode.getText().length() > 0) {
                    hour = hourNode.getText();
                }
    
                if (keyVisualNode != null
                        && keyVisualNode.getText().length() > 0) {
                    keyVisual = keyVisualNode.getText();
                    cssStyle = "background-image: url('" + keyVisual + "&imageThumbnail=3');";
                }

                if (locationNode != null
                        && locationNode.getText().length() > 0) {
                    location = locationNode.getText();
                }

                if (minuteNode != null
                        && minuteNode.getText().length() > 0) {
                    minute = minuteNode.getText();
                }
    
                if (titleNode != null
                        && titleNode.getText().length() > 0) {
                    articleTitle = titleNode.getText();
                }
                
                // if it's an event, disable the viewURL if no description is available
                if (eventDate != null && description == null) {
                    viewURL = null; 
                }
                
                // TODO: read the event's structureId from a configurable property
                
                structureId = article.getStructureId();
                if ("52522".equals(structureId)) {
                    isEvent = true; 
                }
                
                if ("69567".equals(structureId)) {
                    isGenesis = true; 
                }


            } catch (Exception ignore) {
                articleTitle = null;
            }
        }

        if (articleTitle != null) {
            title = articleTitle;
        }
    }
%>