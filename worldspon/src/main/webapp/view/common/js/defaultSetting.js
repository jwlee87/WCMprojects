$(document).ready(function(){
	
$(window).on("load", function(){
	var windowWidth = $(window).width();
	if(windowWidth > 1000){
		$("body").css("width", "100%");
	}else{
		$("body").css("width", "1000px");
	}
});

$(window).resize(function(){
	var windowWidth = $(window).width();
	if(windowWidth > 1000) {
		$("body").css("width", "100%");
	}else{
		$("body").css("width", "1000px");
	};
});

});
