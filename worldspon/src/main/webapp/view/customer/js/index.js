$(document).ready(function(){
	$("form").focusin(function(){
		$(this).css("box-shadow", "1px 4px 4px 1px rgba(0, 0, 0, 0.2), 3px 6px 10px 3px rgba(0, 0, 0, 0.19)");
	}).focusout(function(){
		$(this).css("box-shadow", "0 0 0 0 rgba(0, 0, 0, 0), 0 0 0 0 rgba(0, 0, 0, 0)");
	});
	
	$(".pagination > li").focusin(function(){
		$(this).addClass("active");
	}).focusout(function(){
		$(this).removeClass("active");
	});

	function goPage(pageNo){
		location.href = "/customer/list?pageNo="+pageNo;
	}
});