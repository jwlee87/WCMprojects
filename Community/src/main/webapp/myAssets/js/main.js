function numberWithCommas(x) {
	if(typeof x === 'number'){
		x += "";
	}
	if(x.includes(".")){
		var integer = x.split(".")[0];
		var minority = x.split(".")[1];
		return integer.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +"."+ minority.toString();
	}else{
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
}
function showLoader(){
	$(".lds-back").show();
	$(".lds-ring").show();
}

function hideLoader(){
	$(".lds-back").hide();
	$(".lds-ring").hide();
}

function pagination(pageNo, total){
	
	var page = {};
	page.no = pageNo;
	page.count = 10;
	page.total = total;
	page.max = Math.ceil(total / page.count);
	
	if(pageNo >= page.max){
		page.begin = (page.max - 1) * page.count + 1;
		page.end = page.max * page.count;
	}else{
		page.begin = (page.no - 1) * page.count + 1;
		page.end = page.no * page.count;
	}
	console.log($.extend({"location":"main.js", "name":"pagination", "debug-target":"pageObject" }, page));
	return page;
}	

function replaceAll(str, searchStr, replaceStr) {
  return str.split(searchStr).join(replaceStr);
}
function getWeekday(sDate) {

    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(5, 2), 10);
    var dd = parseInt(sDate.substr(8), 10);

    var d = new Date(yy,mm - 1, dd);
    var weekday=new Array(7);
    weekday[0]="일요일";
    weekday[1]="월요일";
    weekday[2]="화요일";
    weekday[3]="수요일";
    weekday[4]="목요일";
    weekday[5]="금요일";
    weekday[6]="토요일";

    return weekday[d.getDay()];
}