$(document).ready(function(){
	
	var sub = $(".navi-menu").children("ul").children("li");

	$(".navi-menu > a").mouseenter(function(){
		var a = $(this).parent().children($("ul.navi-sub"))[1];
		var b = $(this).parent().find("a")[0];
		$(a).show();
		$(b).addClass("active");
		subHover();
	});

	$(".navi-menu").mouseleave(function(){
		var a = $(this).children($("ul.navi-sub"))[1];
		var b = $(this).find("a")[0];
		$(a).hide();
		$(b).removeClass("active");
	});

	function subHover(){
		$(sub).mouseenter(function(){
			$(this).addClass("sub-active");
		}).mouseleave(function(){
			$(this).removeClass("sub-active")
		});
	}
});