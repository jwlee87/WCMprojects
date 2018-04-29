/**
 * slide Carousel Plugin
 * made by jxwx
 * version 1.0.0
 */

$(document).ready(function(){

	var slide = null;
	var slideItem = $(".slide-item");

	var itemArray = new Array();
	var count = 0;
	var currentItem = null;
	var nextItem = null;

	function slideShowPrev(){
		currentItem = slideItem[count];
		$(currentItem).fadeOut(1500);
		count --;
		if(count < 0){count = slideItem.length-1;}
			nextItem = slideItem[count];
			$(nextItem).fadeIn(1500);
	}

	function slideShow(){
		currentItem = slideItem[count];
		$(currentItem).fadeOut(1500);
			count ++;
		if(count==slideItem.length){count = 0;}
		nextItem = slideItem[count];
		$(nextItem).fadeIn(1500);
	}

	function slideStart(){
		currentItem = slideItem[count];
		$(currentItem).css("display","block");
		slide = setInterval(function (){
			slideShow();
		}, 3000);
	};

	function slideStop(){
		clearInterval(slide);
	}

	slideStart();

	$(".slide-banner").mouseenter(function(){
		$(".arrow").css("display","block");
		$(".slide-area").css("display","block");
		slideStop();
	}).mouseleave(function(){
		$(".arrow").css("display","none");
		$(".slide-area").css("display","none");
		slideStart();
	});

	$(".slide-area").on("click", function(){
		var classText = $(this).attr("class");
		var direction = classText.substring(17);
		if(direction=='left-area'){
			slideShowPrev();
		}
		if(direction=='right-area'){
			slideShow();
		}
	});
});