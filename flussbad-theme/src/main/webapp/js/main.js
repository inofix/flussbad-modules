/**
 * Scripts required by the flussbad-theme.
 * 
 * Created: 	2015-09-02 22:31 by Christian Berndt
 * Modified:	2015-09-19 10:58 by Christian Berndt
 * Version: 	1.0.2
 */

/**
 * js for the main navigation, from 
 * https://gist.github.com/randombrad/b5ffb95519eee2c56d87
 */
AUI().ready(
'liferay-hudcrumbs', 'liferay-navigation-interaction', 'liferay-sign-in-modal',
	function(A) {
		var navigation = A.one('#navigation');

		var menu_toggle = navigation.one('#nav_toggle');

		if (navigation) {
			navigation.plug(Liferay.NavigationInteraction);
		}

		menu_toggle.on('click', function(event){
			navigation.one('.collapse.nav-collapse').toggleClass('open');
		});

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
 * js for the carousel-elements.
 */
AUI().ready('event', 'node', function (A) {

    var controls = A.all('.carousel-control');

    controls.on('click', function (e) {
      
      console.log('control clicked');
      
      var carouselId = "myCarousel";  
//      var carouselId = e.target.getData('carousel-id'); 
    
      console.log('carousel = ' + e.target.getAttribute('data-carousel'));
      console.log('slide = ' + e.target.getAttribute('data-slide'));
                  
      // Get the configured carousel
      var carousel = A.one('#' + carouselId);
      
      // Get the carousel's items
      var items = carousel.all('.item');

      var isNext = true; 
      
      if (e.target.getData('slide') === 'prev') {
        isNext = false;
      }
      
      var i = 0;
      var current = 0; 
      
      // Loop over the carousel's items
      items.each(function(item) {
        
        console.log('i = ' + i); 
        
        if (item.hasClass('active')) {
          
          current = i;
          console.log(i + ' is active'); 
          item.removeClass('active'); 
          
        }  
        
        i++;
        
      });
      
      var next = 0;
      
      if (isNext) {
        if (current < items.size()-1) {
          next = current + 1; 
        } else {
          next = 0; 
        }
      } else {
        if (current > 0) {
          next = current -1; 
        } else {
          next = items.size() - 1;
        }
      }
      
      // Set the next slide active
      items.item(next).addClass('active');
      
    });
});

/**
 * show / hide the language-portlet included in #navigation
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
	  
      trigger.on('click', function(e) {
	      popover.set('visible', !popover.get('visible'));
	          e.stopPropagation();   
      });                        
	}
);

/** 
 * Affix the main navigation
 */
YUI().use(
    'aui-affix',
    function(Y) {
        new Y.Affix(
        {
          target: '#navigation',
          offsetTop: 0
        });
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
              offsetTop: 660 /* height of the intro section - height of navigation */
            });
        }
    }
);
