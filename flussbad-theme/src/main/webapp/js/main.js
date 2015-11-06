/**
 * Scripts required by the flussbad-theme.
 *
 * Created:     2015-09-02 22:31 by Christian Berndt
 * Modified:    2015-11-06 15:50 by Christian Berndt
 * Version:     1.1.8
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

      var trigger = Y.one('#langPopover');

          var popover = new Y.Popover(
            {
              align: {
                node: trigger,
                points:[Y.WidgetPositionAlign.TC, Y.WidgetPositionAlign.BL]
              },
              plugins : [ Y.Plugin.WidgetAnim ],
              position: 'bottom',
          visible: false,
          zIndex : 100
        }
      ).render();

      var portlet = Y.one('#p_p_id_82_');

      popover.set("bodyContent", portlet);

      popover.get('boundingBox').on('clickoutside', function() {
           popover.set('visible', false);
      });

      if (trigger) {
          trigger.on('click', function(e) {
              popover.set('visible', !popover.get('visible'));
                  e.stopPropagation();
          });
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
	
    var toggle = $('.toggle');
    
	var categories = $('.portlet-asset-categories-navigation');
	
    var portlet = $('.portlet-site-map.project-sections');
    
	var publisher = $('.default-publisher'); 

    var story = $('.project-story');   
    
	/**
	 * Manually toggle the site-map of project-sections and
	 * the categories navigation of the default-publisher (logbook).
	 */    
    if (toggle) {
        toggle.on('click', function(event) {
        	
            toggle.toggleClass('categories-closed');
            toggle.removeClass('categories-auto-closed');        	

            if (categories) {
            	categories.toggleClass('categories-closed');
            	categories.removeClass('categories-auto-closed');
            }

            if (portlet) {
                portlet.toggleClass('categories-closed');
                portlet.removeClass('categories-auto-closed');
            }

            if (publisher) {
                publisher.toggleClass('categories-closed');
                publisher.removeClass('categories-auto-closed');
            }

            if (story) {
                story.toggleClass('categories-closed');
                story.removeClass('categories-auto-closed');
            }
        });
    }
    
    /**
     * Automatically toggle the categories and sitemap 
     * while scrolling.
     */   
    var lastScrollTop = 0;
    
    $(window).scroll(function(event) {

	var scrollTop = $(this).scrollTop();

	console.log("scrollTop = " + scrollTop);

	if (scrollTop > lastScrollTop) {

		console.log("scrolling down");

		if (categories) {
			categories.addClass('categories-auto-closed');
		}
		if (story) {
			story.addClass('categories-auto-closed');
		}
		if (toggle) {
			toggle.addClass('categories-auto-closed');
		}
		if (portlet) {
			portlet.addClass('categories-auto-closed');
		}
		if (publisher) {
			publisher.addClass('categories-auto-closed');
		}		

	} else {
		
		console.log("scrolling up");

		if (categories) {
			categories.removeClass('categories-auto-closed');
		}
		if (story) {
			story.removeClass('categories-auto-closed');
		}
		if (toggle) {
			toggle.removeClass('categories-auto-closed');
		}
		if (portlet) {
			portlet.removeClass('categories-auto-closed');
		}
		if (publisher) {
			publisher.removeClass('categories-auto-closed');
		}
	}

	lastScrollTop = scrollTop;
});
    
    
	
	/**
	 * Toggle the categories navigation and project-sitemap 
	 * on mobile devices.
	 */	
    var windowWidth = $(window).width(); 
    var windowHeight = $(window).height();
    
    // console.log('windowHeight = ' + windowHeight); 
        
    if (windowWidth < 768) {
    	
    	var sitemapPortlet = $(".portlet-site-map.project-sections");
    	
    	if (sitemapPortlet) {
    		
    		sitemapPortlet.addClass("categories-closed"); 
    	}
    	
    	var categoriesNavigation = $(".portlet-asset-categories-navigation.head-categories");
    	
    	if (categoriesNavigation) {
    		
    		categoriesNavigation.addClass("categories-closed"); 
    	}    	
    }
	
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
	     offset: {top: 0, bottom: 900 }
    });
	
	$('.story.with-keyvisual .toc').affix({
	     offset: {top: (windowHeight - (60 + 60)), bottom: 900 }
	});
	
	$('.introduction.with-keyvisual .toc').affix({
	     offset: {top: (windowHeight - (60 + 160)), bottom: 900 }
	});

	$('.toc').scrollspy();

});
