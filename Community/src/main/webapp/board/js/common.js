function bad_chk(x){ // 욕 필터링, 스크립트 아이프레임도 필터링
	
	alert("bad_chk 입장");
	
	var YokList = new Array('개새끼','개색기','개색끼','개자식'
		,'개보지','개자지','개년','개걸래','개걸레'
		,'시발','씨발','씨팔','씨부랄','씨바랄','씹창','씹탱'
		,'씹보지','씹자지','씨방세','씨방새','씨펄','시펄'
		,'십탱','씨박','썅','쌍놈','쌍넘','싸가지','쓰벌'
		,'씁얼','상넘이','상놈의','상놈이','상놈을','좆','좃'
		,'존나게','존만한','같은년','넣을년','버릴년','부랄년'
		,'바랄년','미친년','니기미','니미씹','니미씨','니미럴'
		,'니미랄','호로','후레아들','호로새끼','후레자식','후래자식'
		,'후라들년','후라들넘','빠구리','script','iframe','병신');
	var Tmp;
	for( i=0; i< YokList.length; i++){
		Tmp = x.toLowerCase().indexOf(YokList[i]);
		if(Tmp >= 0){
			alert("비속어가 포함되어 있습니다.");
			break;
		}
	}
	event.stopPropagation();
	event.preventDefault();
	return false;
}
