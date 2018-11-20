function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function showLoader(){
	$(".lds-back").show();
	$(".lds-ring").show();
}

function hideLoader(){
	$(".lds-back").hide();
	$(".lds-ring").hide();
}