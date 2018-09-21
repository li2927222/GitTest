$(function() {

	// Do our DOM lookups beforehand
	var nav_container = $(".nav-lf");
	var nav = $("#nav");
	
	var top_spacing = 0;
	var waypoint_offset = 0;

	nav_container.waypoint({
		handler: function(event, direction) {
			
			if (direction == 'down') {			
			  //  nav_container.css({ 'height': nav.outerHeight() });
			    nav.stop().addClass("sticky").animate({ "top": top_spacing });
			    //������������̶�����������ͷ����ĳ�����������fixed���ԣ�������ƶ����붥������ͷ����ĳ�����ȥ��fixed����
                
				
			} else{

			    //  nav_container.css({ 'height': nav.outerHeight() });
			    nav.stop().removeClass("sticky").animate({ "top": top_spacing });

			} 
			
		},
		offset: function() {
			return -nav.outerHeight()-waypoint_offset;
		}
	});
	
	var sections = $("#container");
	var navigation_links = $("#nav a");
	
	sections.waypoint({
		handler: function(event, direction) {
		
			var active_section;
			active_section = $(this);
			if (direction === "up") active_section = active_section.prev();

			var active_link = $('nav a[href="#' + active_section.attr("id") + '"]');
			navigation_links.removeClass("#container");
			active_link.addClass("#container");

		},
		offset: '25%'
	})
	
	
	navigation_links.click( function(event) {

		//$.scrollTo(
		//	$(this).attr("href"),
		//	{
		//		duration: 200,
		//		offset: { 'left':0, 'top':-0.15*$(window).height() }
		//	}
		//);
	});


});