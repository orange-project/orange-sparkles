$(function(){
	$(".page-listing-title a strong, .page-listing-child-title a strong, .page-listing-title a em, .page-listing-child-title a em").hover(
		function(){
			$(this).parent().siblings(".page-listing-excerpt").show();
		},
		function(){
			$(this).parent().siblings(".page-listing-excerpt").hide();
	});
	$("a.status-draft").hover(function(){
		  $(this).removeClass("status-draft");
		  $(this).addClass("status-published");
		  $(this).text("Publish?");
	  },
	  function(){
  		  $(this).removeClass("status-published");
  		  $(this).addClass("status-draft");
		  $(this).text("Draft");
	  }
	);
	$('.page-listing-extras .menu-toggle a.yes-button').click(function(){
	  
	});
	$('.page-listing-extras .menu-toggle a.no-button').click(function(){
	  
	});
  
	$("a.expand").toggle(
		function(){
			$(this).children("img").attr("src","/assets/public/images/page-listing-hide.png");
			var id = $(this).parent().parent().parent().parent().attr('id');
			$(this).parent().parent().parent().parent().siblings(".child-of-"+id).fadeIn();
		},
		function(){
			$(this).children("img").attr("src","/assets/public/images/page-listing-expand.png");
			var id = $(this).parent().parent().parent().parent().attr('id');
			$(this).parent().parent().parent().parent().siblings(".child-of-"+id).fadeOut();
		});
	$("a.page-listing-more-info").toggle(
		function(){
			$(this).siblings(".page-listing-extras").show();
		},
		function(){
			$(this).siblings(".page-listing-extras").hide();
		});
	$("a.move-button").click(
		function(){
		  var my_controls = $(this).parent().parent().siblings("td.move").children("div.move-container").children(" div.move-controls").css('display');
		  $("div.move-controls").hide();
			if(my_controls == 'none') $(this).parent().parent().siblings("td.move").children("div.move-container").children(" div.move-controls").show();
			return false;
		});
	$("a.move-higher").click(function(){
		$(this).parent("form").submit();
		return false;
	});
	$("a.move-lower").click(function(){
		$(this).parent("form").submit(); 
		return false;
	});
	$("a.move-indent").click(function(){
		$(this).parent("form").submit(); 
		return false;
	});
	$("a.move-outdent").click(function(){
		$(this).parent("form").submit(); 
		return false;
	});
	$('.list-view').each(function(i, me){
  	var table = $("table.tablesorter", me);
  	var my_size = 10;
  	if(table.hasClass("is_short")) my_size = 5;
  	if($("tbody tr", table).size() == 0) $("tbody", table).append("<tr><td></td></tr>");
  	
	  table.tablesorter({widthFixed: true, widgets: ['zebra'], headers: {0: {sorter: false}}});
	  table.tablesorterPager({container: $(".pager", me), positionFixed: false, size: my_size});
	  $(".pager .pagesize", table).change();
	});
	// $("form.move-arrow").ajaxForm();
});