/**
 * Scripts required by the flussbad-theme.
 * 
 * Created: 	2015-09-02 22:31 by Christian Berndt
 * Modified:	2015-10-05 10:25 by Christian Berndt
 * Version: 	1.1.0
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
 * Toggle the asset-categories filter.
 */

AUI().ready('node', function(A) {
    
    var toggle = A.one('.accordion-toggle');
    
    var categories = A.one('.portlet-asset-categories-navigation');
    var publisher = A.one('.default-publisher'); 
    
    if (toggle) {
	    toggle.on('click', function(event) {
	    	
	    	if (categories) {
	            categories.toggleClass('categories-closed');
	            categories.removeClass('categories-auto-closed');    		
	    	}
	        
	    	if (publisher) {
	            publisher.toggleClass('categories-closed');
	            publisher.removeClass('categories-auto-closed');    		
	    	}
	
	    });
	}
}); 

/**
 * Show hide the asset categories filter while scrolling.
 */
AUI().ready('node', 'node-scroll-info', function(A) {
	
	var body = A.one('body');
	
	var categories = A.one('.portlet-asset-categories-navigation'); 
    var publisher = A.one('.default-publisher'); 
		
	body.plug(A.Plugin.ScrollInfo);
	
	body.scrollInfo.set('scrollDelay', 0); 
		
	body.scrollInfo.on('scrollDown', function (e) {
		
		if (categories) {
	        categories.addClass('categories-auto-closed');			
		}
		if (publisher) {
	        publisher.addClass('categories-auto-closed');			
		}

	});
	
	body.scrollInfo.on('scrollUp', function (e) {
		
		if (categories) {
	        categories.removeClass('categories-auto-closed');			
		}
		if (publisher) {
	        publisher.removeClass('categories-auto-closed');			
		}

	});
});

/**
 * A scrollview based carousel implementation.
 */
YUI().use('event', 'node', 'scrollview-base', 'scrollview-paginator', function(Y) {

    var scrollView = new Y.ScrollView({
        id: "scrollview",
        srcNode : '.carousel',
        width : Y.one("body").get("winWidth"),
        flick: {
            minDistance:10,
            minVelocity:0.3,
            axis: "x"
        }
    });

    var winWidth = Y.one("body").get("winWidth") + 'px';

    Y.all('.carousel img').setStyle('width', winWidth);  
    Y.all('.carousel .item').setStyle('width', winWidth); 

    Y.on('resize', function() {
        
      winWidth = Y.one("body").get("winWidth") + 'px';

      Y.all('.carousel img').setStyle('width', winWidth);  
      Y.all('.carousel .item').setStyle('width', winWidth);
      scrollView.set('width', winWidth); 
      scrollView.render(); 
    });

    scrollView.plug(Y.Plugin.ScrollViewPaginator, {
        selector: '.item',
    });

    scrollView.render();

    var content = scrollView.get("contentBox");

    content.delegate("click", function(e) {
        // For mouse based devices, we need to make sure the click isn't fired
        // at the end of a drag/flick. We use 2 as an arbitrary threshold.
        if (Math.abs(scrollView.lastScrolledAmt) < 2) {
//            alert(e.currentTarget.getAttribute("alt"));
        }
    }, "img");

    // Prevent default image drag behavior
    content.delegate("mousedown", function(e) {
        e.preventDefault();
    }, "img");
    
    var total = scrollView.pages.get('total');

    var nextControl = Y.one('.right.carousel-control'); 
    
    if (nextControl) {
        
        nextControl.on('click', function(e){
          
          var idx = scrollView.pages.get('index'); 
          var target = idx + 1; 
          
          if (target < total) {
            scrollView.pages.set('index', target); 
          } else {
            // TODO: improve the flick behaviour at the ends
            // scrollView.pages.set('index', total -1); 
            scrollView.pages.scrollTo(0, 0.3, 'easing');           } 
        });        
    }
   
    var prevControl = Y.one('.left.carousel-control')
    
    if (prevControl) {
      
          prevControl.on('click', function(e){

          var idx = scrollView.pages.get('index'); 
          var target = idx - 1; 

          if (target < 0) {
            // TODO: improve the flick behaviour at the ends
            // scrollView.pages.set('index', total -1); 
            scrollView.pages.scrollTo(total - 1, 0.3, 'easing'); 
          } else {
            scrollView.pages.set('index', target); 
          } 
        });
    }

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

/** 
 * Affix with offset for the main navigation on the start page
 */
YUI().use(
    'aui-affix',
    function(Y) {
    	
        var startPageNavigation = Y.one('.start-page #navigation'); 

        if (startPageNavigation) {
	        new Y.Affix(
	        {
	          target: '.start-page #navigation',
	          offsetTop: 200
	        });
        }
    }
);

/** 
 * Affix the categories navigation below the main navigation
 */
YUI().use(
    'aui-affix', 'node',
    function(Y) {
        
        var portletAssetCategories = Y.one('.portlet-asset-categories-navigation.head-categories')
        
        if (portletAssetCategories) {
                        
            new Y.Affix(
            {
              target: '.portlet-asset-categories-navigation.head-categories',
              offsetTop: 0
            });
        }
    }
);

/** 
 * Affix the project categories navigation below the main navigation
 */
YUI().use(
    'aui-affix', 'node',
    function(Y) {
        
        var portletAssetCategories = Y.one('.portlet-asset-categories-navigation.project-categories')
        
        if (portletAssetCategories) {
                        
            new Y.Affix(
            {
              target: '.portlet-asset-categories-navigation.project-categories',
              offsetTop: 720 /* height of the intro section */
            });
        }
    }
);

/** 
 * Affix the toc of stories below the main-navigation
 */
YUI().use(
    'aui-affix', 'node',
    function(Y) {
        
        var toc = Y.one('.toc')
        
        if (toc) {
                        
            new Y.Affix(
            {
              target: '.toc',
              offsetTop: 120,
            });
        }
    }
);

/**
 * Create one scrollspy per page 
 */
YUI().use(
    'aui-scrollspy',
    function(Y) {
        
        var toc = Y.one('.toc ul'); 
        
        if (toc) {
            
            console.log('has toc'); 
            
            new Y.Scrollspy({
                offset: 120, /** height of navigation + margin-top of content */
                target: '.toc ul'
            });
        } 
    }
);
