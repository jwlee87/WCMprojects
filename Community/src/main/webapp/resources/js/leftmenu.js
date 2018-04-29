$(document).ready(function(){
	
	$(".category").mouseenter(function(){
		var map = makeName(this);
		var target = $(this).children().children();
		if(map.imgname == "contents"){
			changeImg(target, map);
			var sub = $(target).parent()[1];
			$(sub).slideDown(100);
		}else{
			changeImg(target, map);
		}
	}).mouseleave(function(){
		var map = makeName(this);
		var target = $(this).children().children();
		
		if(map.imgname == "contents"){
			changeImg(target, map);
			var sub = $(target).parent()[1];
			$(sub).slideUp(100);
		}else{
			changeImg(target, map);
		}
	});
	
	$(".sub-category").mouseenter(function(){
		var map = makeName(this);
		var target = $(this).children().children();
		console.log(map);
		changeImg(target, map);
	}).mouseout(function(){
		var map = makeName(this);
		var target = $(this).children().children();
		changeImg(target, map);
	});
	
	function makeName(element){
		var name = $(element).children();
		name = $(name).children().attr("src");
		console.log(name);
		name = name.split("/");
		var path = "/"+name[1]+"/"+name[2]+"/"+name[3]+"/";
		name = name[4].split("-");
		var imgname = name[0];
		var state = name[1].split(".");
		state = state[0];
		var returnmap = {'path':path, 'imgname':imgname, 'state':state};
		return returnmap;
	}
	
	function changeImg(target, map){
		if(map.state == "off"){
			$(target).attr("src", map.path+map.imgname+"-on.png");
		}else if(map.state == "on"){
			$(target).attr("src", map.path+map.imgname+"-off.png");
		}
	}
});