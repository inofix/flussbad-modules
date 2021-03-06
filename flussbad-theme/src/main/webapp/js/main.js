/**
 * Scripts required by the flussbad-theme.
 *
 * Created:     2015-09-02 22:31 by Christian Berndt
 * Modified:    2017-04-16 16:06 by Christian Berndt
 * Version:     1.3.7
 */

/**
 * js for the main navigation, from
 * https://gist.github.com/randombrad/b5ffb95519eee2c56d87
 */
AUI().ready(
'liferay-hudcrumbs', 'liferay-navigation-interaction', 'liferay-sign-in-modal',
    function(A) {
        var navigation = A.one('#navigation');

        if (navigation) {

            navigation.plug(Liferay.NavigationInteraction);
            var menu_toggle = navigation.one('#nav_toggle');

            menu_toggle.on('click', function(event){
                navigation.one('.collapse.nav-collapse').toggleClass('open');
            });
        }

        var siteBreadcrumbs = A.one('#breadcrumbs');

        if (siteBreadcrumbs) {
            siteBreadcrumbs.plug(A.Hudcrumbs);
        }

        var signIn = A.one('li.sign-in a');

        if (signIn && signIn.getData('redirect') !== 'true') {
            signIn.plug(Liferay.SignInModal);
        }
    }
);

/**
 * A fallback for 100vh configuration of keyvisual elements.
 */
YUI().use('event', 'node', function(Y) {

    var winHeight = Y.one("body").get("winHeight") + 'px';

    /** TODO: all or only the first ? */
    Y.all('.keyvisual').setStyle('height', winHeight);

    Y.on('resize', function() {
        winHeight = Y.one("body").get("winHeight") + 'px';
        Y.all('.keyvisual').setStyle('height', winHeight);
    });
});

/**
 * Show / hide the language-portlet included in #navigation
 */
YUI().use(
    'aui-popover','widget-anim',
    function(Y) {
        
        var winWidth = Y.one("body").get("winWidth"); 
    	
        var portlet = Y.one('#p_p_id_82_');

        var trigger1 = Y.one('#langPopover1');
        var trigger2 = Y.one('#langPopover2');

        // Desktop
        if (winWidth > 979) {
    		var popover1 = new Y.Popover({
    			align: {
    			    node: trigger1,
    			    points:[Y.WidgetPositionAlign.TC, Y.WidgetPositionAlign.BC]
    			},
    			bodyContent: portlet,
    			plugins : [ Y.Plugin.WidgetAnim ],
    			position: 'bottom',
    			cssClass: 'popover-lang',
    			visible: false,
    			zIndex : 100
    		}).render();
    		
	        popover1.get('boundingBox').on('clickoutside', function() {
	            popover1.set('visible', false);
	        });
	        
	        if (trigger1) {
	            trigger1.on('click', function(e) {
	                popover1.set('visible', !popover1.get('visible'));
	                e.stopPropagation();
	            });
	        }	        
	        
        } else {
            // Tablet and mobile
            var popover2 = new Y.Popover({
                align: {
                    node: trigger2,
                    points:[Y.WidgetPositionAlign.TC, Y.WidgetPositionAlign.BC]
                },
                bodyContent: portlet,
                plugins : [ Y.Plugin.WidgetAnim ],
                position: 'bottom',
                cssClass: 'popover-lang',
                visible: false,
                zIndex : 100
            }).render();
            
            popover2.get('boundingBox').on('clickoutside', function() {
                popover2.set('visible', false);
            }); 
            
            if (trigger2) {
                trigger2.on('click', function(e) {
                    popover2.set('visible', !popover2.get('visible'));
                    popover2.set('y', 50);
                    e.stopPropagation();
                });
            }           
        }
    }
);


//TODO: needs IDs in DOM (even with AUI().ready())
AUI().ready('imageloader', function (Y) {
    var imageGroup = new Y.ImgLoadGroup({ name: 'foldGroup', foldDistance: 2 });
    // imageGroup.addTrigger('.item', 'mouseover');
    
    //TODO: decide on going for CSS-Classes or elements: Y.all('img')
     var images = document.getElementsByTagName("img");
    
     for (var i = 0; i < images.length; i++)
     {
         if ( images[i].getAttribute("data-src") )
         {   
             imageGroup.registerImage({
                 domId: images[i].getAttribute("id"),
                 srcUrl: images[i].getAttribute("data-src")
             });
         }
    }
});



/**
 * jQuery plugins
 */

$( document ).ready(function() {
	
    var windowWidth = $(window).width();    
    var windowHeight = $(window).height();
	
    var toggle = $('.toggle');
    
    /** Toggle second level navigation with headroom.js */
	var categoriesNavigation = $('.portlet-asset-categories-navigation .wrapper');	
    var sitemapPortlet = $('.portlet-site-map.project-sections .wrapper');    
	var publisher = $('.default-publisher'); 
    var story = $('.project-story');
    
    var config = { 
		tolerance : 10,
		onPin : function() {
						
			if (toggle) {
	        	toggle.toggleClass('headroom--unpinned');				
			}		
		},
		onUnpin : function() {	
						
			if (toggle) {
	        	toggle.toggleClass('headroom--unpinned');
			}
			if (publisher) {
				publisher.toggleClass('headroom--unpinned');				
			}
			if (story) {
				story.toggleClass('headroom--unpinned');				
			}			
		}
	};
  
	/**
	 * Manually toggle the site-map of project-sections and
	 * the categories navigation of the default-publisher (logbook).
	 */    
    if (toggle) {
        toggle.on('click', function(event) {
        	        	
        	if (toggle.hasClass('headroom--unpinned')) {
        		
        		// pin unpinned navigation
        		
    			toggle.toggleClass('headroom--unpinned'); 
        		
        		if (categoriesNavigation) {
        			categoriesNavigation.toggleClass('headroom--unpinned'); 
        		}
        		
        		if (publisher) {        			
        			publisher.toggleClass('headroom--unpinned'); 
        		}
        		
        		if (sitemapPortlet) {
        			sitemapPortlet.toggleClass('headroom--unpinned');
        		}
        		
        		if (story) {
        			story.toggleClass('headroom--unpinned');    			
        		} 
        		
        	} else {
        		
        		// disable auto pinning by manually closing the navigation
        		
    			toggle.toggleClass('manually--closed'); 
        		
        		if (categoriesNavigation) {
        			categoriesNavigation.toggleClass('manually--closed');
        		}
        		
        		if (publisher) {
        			publisher.toggleClass('manually--closed');    			
        		} 
        		
        		if (sitemapPortlet) {
        			sitemapPortlet.toggleClass('manually--closed');
        		}
        		
        		if (story) {
        			story.toggleClass('manually--closed');    			
        		} 
        	}            
        });
        
    	if (windowWidth < 768) {
    		
			toggle.toggleClass('manually--closed'); 
			
		    if (categoriesNavigation) {
		    	categoriesNavigation.toggleClass('manually--closed');
		    	categoriesNavigation.css('display', 'block');		    	
		    }
		    
		    if (sitemapPortlet) {
		    	sitemapPortlet.toggleClass('manually--closed');
		    	sitemapPortlet.css('display', 'block');		    	
		    }
    	}
    }

    if (categoriesNavigation) {
    	
    	if (windowWidth > 767) {
        	$(categoriesNavigation).headroom(config);
    	}
    }
    
    if (sitemapPortlet) {
    	
    	if (windowWidth > 767) {
        	$(sitemapPortlet).headroom(config);  	    		
    	}   	
    }

    /**
     * Show a modal slideshow.
     */
    $(document).on('show.bs.modal', function(event) {
        
        resizeModal(); 
                                
        var button = $(event.relatedTarget); // Button that triggered the modal     
        var target = button.data('target');
        
        $(target).css("height", "90vh");
        $(target).css("width", "90vw");                    
        $(target).css("visibility","visible");
        $(target).css("left", "5vw");
     
    });
    
    /**
     * Move the slider in the modalSlideshow to the current image.
     */
    $(document).on('shown.bs.modal', function(event) {
            
        var button = $(event.relatedTarget); // Button that triggered the modal     
        var index = button.data('index');

        var slider = $('#slider').data('flexslider');
        
        slider.flexAnimate(index - 1);

    });
    
    /**
     * Stop any running video when the modal is closed
     */
    $(document).on('hide.bs.modal', function(event) {
        
       // stop any running video
       $(".slideshow iframe").each(function( index ) {
           var src = $( this ).attr("src"); 
           $( this ).attr("src", ""); 
           $( this ).attr("src", src); 
       });
    });
	
	/**
	 * Apply the affix class to the main-navigation .
	 */
	$('.start-page #navigation').affix({
	     offset: {top: 200 }
	});

	/**
	 * Affix the toc of stories
	 */
	$('.without-keyvisual .toc').affix({
	     offset: {top: 0, bottom: 1000 }
    });
	
	$('.story.with-keyvisual .toc').affix({
	     offset: {top: (windowHeight - (60 + 60)), bottom: 1000 }
	});
	
	$('.introduction.with-keyvisual .toc').affix({
	     offset: {top: (windowHeight - (60 + 160)), bottom: 1000 }
	});
	
	/** 
	 * Loop over the modules marked as toc-item and add them to 
	 * the page's toc. (Only applied to TOCs of introduction templates.)
	 */	
	$('.toc-item .portlet-borderless-container > .portlet-title-default' ).each(function( index ) {
		var label = $(this).text();
		$(".introduction .toc ul").append('<li><a href="#item-' + index + '">' + label + '</a></li>');
		$(this).attr("id", "item-" + index);		
	});

	$('body').scrollspy({offset: 120});
	
	/**
	 * Smooth scrolling for the TOC - targets 
	 * (from: http://stackoverflow.com/questions/14804941/how-to-add-smooth-scrolling-to-bootstraps-scroll-spy-function)
	 */
	$(".toc ul li a[href^='#']").on('click', function(e) {

	   // prevent default anchor click behavior
	   e.preventDefault();

	   // store hash
	   var hash = this.hash;
	   
	   // use offset because of fixed top navigation
	   var offsetTop = 100; 
	   
	   // animate
	   $('html, body').animate({
	       scrollTop: $(hash).offset().top - offsetTop
	     }, 300, function(){

	       // when done, add hash to url
	       // (default click behaviour)
	    	 
	       // disabled, since this causes 
	       // an unwanted move in firefox
	       // window.location.hash = hash;
	     });

	});
	
	/**
	 * Configure sliders.
	 */
    $('.slideshow .flexslider').flexslider({
        animationLoop: true,
        slideshow: false,
        
        after: function(slider){
            
            // select the current slide
            var current = slider.find("li:nth-of-type("+(slider.currentSlide+1)+")")[0];
            
            // adjust the caption div
            var img = $(current).find('img');
            var caption = $(current).find('.caption');
            var wrapper = $(img).parent();  
            var padding = 2;
            
            $(caption).css("width", ($(img).width() - 2*padding) + "px" );            
            $(caption).css("left", ($(wrapper).width() - $(img).width()) / 2);
            $(caption).css("display", "block");
            
            var frame = $(current).find("iframe")[0];
            
            // reset all videos except for the current
            $(".slideshow iframe").each(function( index ) {
                var src = $( this ).attr("src"); 
                if ($(frame).attr("src") != src) {                   
                    $( this ).attr("src", ""); 
                    $( this ).attr("src", src); 
                }
            });
            
        },
        prevText:"",      
        nextText:""         
    });	
    
    $('.flexslider.statements').flexslider({
        animation: "slide", 
        randomize: true,
        pauseOnHover: true,
        controlNav: false,
        prevText:"",      
        nextText:""      
    });
	
	/**
	 * Manage the transparency of the web-form-portlet used 
	 * for the newsletter-subscription in the footer. 
	 */

	/* Check whether an input field is filled or not */
	checkInputs();
	
    $('input').bind("focus change paste keyup blur", checkInputs);
	
    /* Loop over all input fields on the page and set the muted class if necessary. */
    function checkInputs() {
		$("input").each(function() {
			if ($(this).val().length === 0) {
				var label = $('label[for="' + $(this).attr('id') + '"]');
				label.removeClass("muted");
			} else {
				var label = $('label[for="' + $(this).attr('id') + '"]');
				label.addClass("muted");
			}
		})
	}    
});

$( window ).resize(function() { 
    resizeModal();
});

function resizeModal() {
    
    var boxScale = 0.9;
    var boxWidth = $(window).width() * boxScale;
    var boxHeight = $(window).height() * boxScale;    
    var boxRatio = boxWidth / boxHeight;
    
    // rescale images
    $('.modal.slideshow img').imagesLoaded().progress( 
        function( instance, image ) {
            
        var img = image.img;
        var nh = img.naturalHeight;
        var nw = img.naturalWidth;
        var imageRatio = nw / nh;
        
        if (imageRatio < boxRatio) {
            $(img).css("height", boxHeight);
            $(img).css("width", "auto");
        } else {
            $(img).css("width", boxWidth);
            $(img).css("height", "auto");
        }
        
        // TODO: merge with the corresponding method in the gallery flexslider.
        var caption = $(img).parent().find('.caption');
        var wrapper = $(img).parent();
        var padding = 2; 
        
        $(caption).css("width", ($(img).width() - 2*padding) + "px" );            
        $(caption).css("left", ($(wrapper).width() - $(img).width()) / 2);
        
    });    
}
