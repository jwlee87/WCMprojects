<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- <%@ include file="/WEB-INF/view/common/includeJstl.jsp"%> --%>
<%-- <%@	page import="com.smilegate.commons.utils.StringUtil"%> --%>
<%
	String select2 = request.getParameter("select2");
	String select3 = request.getParameter("select3");
	String select4 = request.getParameter("select4");
	String select5 = request.getParameter("select5");
	String current_page = request.getParameter("current_page");
	String search_key = request.getParameter("search_key");
	String page_sort = request.getParameter("page_sort");
	String period = request.getParameter("period");
	String list_size = request.getParameter("list_size");

// 	if (StringUtil.isEmpty(select2))
// 		select2 = "";
// 	if (StringUtil.isEmpty(select3))
// 		select3 = "";
// 	if (StringUtil.isEmpty(select4))
// 		select4 = "";
// 	if (StringUtil.isEmpty(select5))
// 		select5 = "";
// 	if (StringUtil.isEmpty(current_page))
// 		current_page = "1";
// 	if (StringUtil.isEmpty(search_key))
// 		search_key = "";
// 	if (StringUtil.isEmpty(page_sort))
// 		page_sort = "LA";
// 	if (StringUtil.isEmpty(period))
// 		period = "";
// 	if (StringUtil.isEmpty(list_size))
// 		list_size = "10";

%>
<!doctype html>
<html lang="ko">
<head>
	<title>스토브 백오피스</title>
	<meta http-equiv="Content-type" content="text/html;charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<%-- 	<jsp:include page="/WEB-INF/view/common/include.jsp"/> --%>
    <%-- Excel Start --%>
    <script src="/resources/js/module/excel/base64.min.js"></script>
    <script src="/resources/js/module/excel/Blob.js"></script>
    <script src="/resources/js/module/excel/downloadify.min.js"></script>
    <script src="/resources/js/module/excel/FileSaver.js"></script>
    <script src="/resources/js/module/excel/ga.js"></script>
    <script src="/resources/js/module/excel/shim.js"></script>
    <script src="/resources/js/module/excel/swfobject.js"></script>
    <script src="/resources/js/module/excel/xlsx.full.min.js"></script>
    <script src="/resources/js/module/excel/excel.js"></script>
    <%-- Excel End --%>
</head>
<body>
<div class="page">
	<div class="page-scroll-wrapper">
		<div class="page-scroll" id="page-scroll">
			<div class="page-body">
			
				<c:import url="/menu/titleInfo">
					<c:param name="menuNo" value="${menu_no}" />
					<c:param name="language_cd" value="${language_cd}" />
				</c:import> 
				
				<div class="row in-page-searchbar">
					<div class="panel panel-fullgray">
						<div class="panel-body">
							<div class="page-searchbar">
								<div class="form-group">
									<div class="table-form">
										<div class="table-group">
											<div class="colgroup">
												<div class="col" style="width:20%"></div>
												<div class="col" style="width:20%"></div>
												<div class="col" style="width:20%"></div>
												<div class="col" style="width:20%"></div>
												<div class="col"></div>
											</div>		
																				
											<div class="cell-group cell-group-body">
												<div class="cell cell-body" id="div_select2">
													<div class="cell-text" data-i18n="page\cc\best:game_select">게임 선택</div>
													<div class="cell-form">
														<div class="select  small" id="search_game_id"></div>
													</div>
												</div>   
												<div class="cell cell-body" id="div_select3">
													<div class="cell-text" data-i18n="page\cc\best:community_select">커뮤니티 선택</div>
													<div class="cell-form">
														<div class="select  small" id="search_community"></div>
													</div>
												</div>  
												<div class="cell cell-body" id="div_select4">
													<div class="cell-text" data-i18n="page\cc\best:page_select">페이지 선택</div>
													<div class="cell-form">
														<div class="select  small" id="search_page"></div>
													</div>
												</div>
												<div class="cell cell-body" id="div_select6" style="display:none;">
													<div class="cell-text">타입 선택</div>
													<div class="cell-form">
														<div class="select  small" id="search_type"></div>
													</div>
												</div>
												<div class="cell cell-body" id="div_select5">
													<div class="cell-text" data-i18n="page\cc\best:board_select"></div>
													<div class="cell-form">
														<div class="select  small" id="search_menu_no"></div>
													</div>
												</div>
											</div>
										</div>			

									</div>
								</div>
								<div class="form-actions">
									<%-- 
									<button type="submit" onclick="card.fnSearch();" class="btn btn-lg btn-fullblue"><i class="icon icon-search"></i></button>
									 --%>
									<button type="submit" onclick="card.fnReset();" class="btn btn-lg btn-blue"><i class="icon icon-refresh"></i></button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row in-form-actions">
					<div class="form-actions">
						<div class="form-actions-right">
							<iop:button viewResourceId="SBC5014" paramResources="${resourceList}" id="cardBtnReg" type="button" iopclass="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:regi">등록</span></iop:button>
							<iop:button viewResourceId="SBC5015" paramResources="${resourceList}" id="cardBtnChange" type="button" iopclass="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:order_list">순서관리</span></iop:button>
							<iop:button viewResourceId="SBC5016" paramResources="${resourceList}" id="cardBtnLive" type="button" iopclass="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:select_show">선택노출</span></iop:button>
							<iop:button viewResourceId="SBC5016" paramResources="${resourceList}" id="cardBtnHidden" type="button" iopclass="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:select_hide">선택미노출</span></iop:button>
							<iop:button viewResourceId="SBD5017" paramResources="${resourceList}" id="cardBtnDel" type="button" iopclass="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:select_delete">선택삭제</span></iop:button>
							<%-- <button id="cardBtnReg" type="button" class="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:regi">등록</span></button>
							<button id="cardBtnChange" type="button" class="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:order_list">순서관리</span></button>				
							<button id="cardBtnLive" type="button" class="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:select_show">선택노출</span></button>
							<button id="cardBtnHidden" type="button" class="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i18n="common:select_hide">선택미노출</span></button>
							<button id="cardBtnDel" type="button" class="btn btn-lg btn-primary btn-square"><span class="btn-text" data-i1 -->8n="common:select_delete">선택삭제</span></button> --%>
									
						</div>
					</div>
				</div>
				<div class="row in-data-filter in-page-title">
					<div class="col col-md-6">
						<div class="page-title">
							<h2 data-i18n="page\cc\best:best_list_title">BEST 게시물 리스트</h2>
						</div>	
					</div>
					<div class="col col-md-6">						
						<div class="data-filter">
							<span class="result" >
                                <span data-i18n="common:search_result"></span>: <span class="num" id="totalCnt">0</span><span data-i18n="common:cnt"></span><%--검색결과 : @개--%>
							</span>		
							<div class="sorting">
								<div class="dropdown">
									<div class="dropdown-header">
										<a href="#" data-toggle-name="data-filter" class="dropdown-toggle" data-toggle="dropdown"  data-toggle-target="#data-filter" role="button">
											<span class="text" data-i18n="common:filter.filter">필터</span>
											<i class="icon icon-filter"></i>
											<i class="icon icon-arrow"></i>
										</a>
									</div>
<%-- 									<jsp:include page="/WEB-INF/view/cc/best/popup/bestSearchPopup.jsp"> --%>
<%-- 										<jsp:param name="fnName" value="getList"/> --%>
<%-- 										<jsp:param name="defaultValue" value="10,Y"/> --%>
<%-- 										<jsp:param name="removeItem" value="Y,Y" /> --%>
<%-- 									</jsp:include> --%>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row in-table-default" id="tableList"></div>
				<div class="row in-pagination" id="pageList"></div>
				
			</div>	
		</div>	
	</div>
</div>
<%-- <jsp:include page="/WEB-INF/view/cc/card/popup/gradePopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/mc/exhibitbanner/exhibitbannerImgInfo.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/mc/onstove/popup/claimPopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/cc/card/popup/cardPopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/mc/onstove/popup/userPopup.jsp" /> --%>
<%-- <jsp:include page="/WEB-INF/view/mc/onstove/popup/nicknamePopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/mc/onstove/popup/userNicknamePopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/cc/guestbook/popup/guestTagPopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/cc/card/popup/cardMovePopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/cc/best/popup/bestFormPopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/cc/card/popup/memoPopup.jsp"/> --%>
<%-- <jsp:include page="/WEB-INF/view/mc/onstove/popup/likeUserPopup.jsp"/> --%>


            
<script type="text/javascript">
var currentPage = '${current_page}';
var pageRowCount = 10;
var getSelect2;
var getSelect3;
var getSelect4;
var getSelect5;
var getSelect6;
var checkName = 'chkAdd';
var claimPopup;
var cardDetailPopup;
var bestDetailPopup;
var tagData = {};
var pfontUrl="";
var gradeList = [];
var userPopup;
var gradePopup;
var nicknamePopup;
var userNicknamePopup;
var popGameNo;
var popCafeNo;
var popChannelNo;
var popCommunityNo;
var popCardArr;
var bestFormPopup;
var backFlag;
var boardGetData;
var totalCount;

$(function(){
	
	/* 전체 선택 */
    $(document).on('change','[name="all_'+checkName+'"]',function(){
        if ($(this).is(":checked")) {
			$('input[name="'+checkName+'"]').each(function(idx){
	        	if($('[name="'+checkName+'"]:eq('+idx+')').attr("disabled") != "disabled"){
	        		$('[name="'+checkName+'"]:eq('+idx+')').checked();
	        	}
			})
        } else {
            $('[name="'+checkName+'"]').unchecked();
        }
    });
	
	/* 체크 선택 */
    $(document).on('change','[name="'+checkName+'"]',function(){
        if($('input[name="'+checkName+'"]').filter(':checked').length === $('input[name="'+checkName+'"]').length) {
            $('[name="all_'+checkName+'"]').checked();
        } else {
            $('[name="all_'+checkName+'"]').unchecked();
        }
    });
	
	/* 등록 버튼 클릭 */
	$("#cardBtnReg").on("click",function(e){

		card.bestFormPopupOpen();
		
	});
	
	$("#cardBtnChange").on("click",function(e){
		
		if(!card.fnValidation()) return;
		
		
		
		if($('#div_select6').css('display') == 'block') {
			var param = {
    			"select1"       : $("#search_game_id #serviceKey").val()
	    		, "select2"       : $("#search_game_id #serviceKey").val()
    			, "select3"       : $("#search_community #serviceKey").val()
    			, "select4"       : $("#search_page #serviceKey").val()
    			, "select5"       : $("#search_menu_no #serviceKey").val()
    			, "select6"       : $("#search_type #serviceKey").val()
	    		, "current_page"  : currentPage
	    		, "search_filter" : searchFilter
	    		, "use_yn"	: searchFilter.liveYn
	    	};
		} else {
			var param = {
    			"select1"       : $("#search_game_id #serviceKey").val()
	    		, "select2"       : $("#search_game_id #serviceKey").val()
    			, "select3"       : $("#search_community #serviceKey").val()
    			, "select4"       : $("#search_page #serviceKey").val()
    			, "select5"       : $("#search_menu_no #serviceKey").val()
	    		, "current_page"  : currentPage
	    		, "search_filter" : searchFilter
	    		, "use_yn"	: searchFilter.liveYn
	    	};
		}
		
		
		
    	//GET 파리미터 생성.
		var getUrl = gFnGetUrlParamAll(param);
		getUrl = getUrl.substr(1,getUrl.length);
		
		getUrl += '&search_game_id_nm='+encodeURIComponent($("#search_game_id .form-value").val());
		getUrl += '&search_community_nm='+encodeURIComponent($("#search_community .form-value").val());
		getUrl += '&search_page_nm='+encodeURIComponent($("#search_page .form-value").val());
		getUrl += '&search_menu_nm='+encodeURIComponent($("#search_menu_no .form-value").val());
		getUrl += '&search_key='+encodeURIComponent($("#searchText").val());
		
		var req_url = $(location).attr('pathname') + '?' + getUrl;
		console.log('req url > ' + req_url);
    	
    	$(location).attr('href','/cc/best/bestOrderList/page?req_url='+req_url);
		
	})
	
	/* 선택노출 버튼 클릭 */
	$("#cardBtnLive").on("click",function(e){
        var bestNogArray = new Array();
        var logArray = new Array();
        var channelNo = '';
        var bestTypeCd = '';
        var gameNo = '';
        $(':checkbox[name='+checkName+']:checked').each(function(pi,po){
        	bestNogArray.push(parseInt($(this).val()));
            if(channelNo == ''){
            	channelNo = $(this).attr('channelno');
            }
            if(bestTypeCd == ''){
            	bestTypeCd = $(this).attr('besttypecd');
            }
            gameNo = $(this).attr('gameno');
            var logData = {
				"log_type_cd" : "BESTCARD_SHOW",
				"game_no" : parseInt(gameNo),
				"reference_no" : parseInt($(this).attr('cardno')),
				"params" : parseInt($(this).attr('cardno')),
				"memo" : ""
			}
            logArray.push(logData);
        });
        
        if(isEmpty(bestNogArray) !== '' && bestNogArray.length > 0){
        	
        	if($('#search_type').find('.form-key').val() == 'layout') {
        		gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_1'),function () {
	                card.fnLayoutListUpdate('N', bestNogArray, logArray);
	            });
        	} else {
	        	//게시물을 BEST 게시물 목록에서 노출 하시겠습니까?
	            gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_2'),function () {
	            	card.cpContentsListUpdate( 'Y', bestNogArray, channelNo , -1, logArray);
	            });
        	}
        }else{
        	//선택된 게시물이 없습니다.
        	alertMessage(i18nUt.get().t('page\\cc\\best:select_list_empty'));
        }
	});
	
	/* 선택미노출 버튼 클릭 */
	$("#cardBtnHidden").on("click",function(e){
        var bestNogArray = new Array();
        var logArray = new Array();
        var channelNo = '';
        var bestTypeCd = '';
        var gameNo = '';
        $(':checkbox[name='+checkName+']:checked').each(function(pi,po){
        	bestNogArray.push(parseInt($(this).val()));
            if(channelNo == ''){
            	channelNo = $(this).attr('channelno');
            }
            if(bestTypeCd == ''){
            	bestTypeCd = $(this).attr('besttypecd');
            }
            gameNo = $(this).attr('gameno');
            var logData = {
				"log_type_cd" : "BESTCARD_HIDE",
				"game_no" : parseInt(gameNo),
				"reference_no" : parseInt($(this).attr('cardno')),
				"params" : parseInt($(this).attr('cardno')),
				"memo" : ""
			}
            logArray.push(logData);
        });
        if(isEmpty(bestNogArray) !== '' && bestNogArray.length > 0){
        	
        	if($('#search_type').find('.form-key').val() == 'layout') {
        		gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_1'),function () {
	                card.fnLayoutListUpdate('N', bestNogArray, logArray);
	            });
        	} else {
	    		//게시물을 BEST 게시물 목록에서 미노출 하시겠습니까?
	        	gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_1'),function () {
	                card.cpContentsListUpdate('N',bestNogArray,channelNo, -1, logArray);
	            });
        	}
        	
        }else{
        	//선택된 게시물이 없습니다.
            alertMessage(i18nUt.get().t('page\\cc\\best:select_list_empty'));
        }
	});
	
	/* 선택삭제 버튼 클릭 */
	$("#cardBtnDel").on("click",function(e){
		
		if($(":checkbox[name='"+checkName+"']:checked").length <= 0){
			//선택된 게시물이 없습니다.
			alertMessage(i18nUt.get().t('page\\cc\\best:select_list_empty'));
		} else{
			
			var seqArray = new Array();
			$(":checkbox[name='"+checkName+"']:checked").each(function(index, e){
				seqArray.push(parseInt(e.value));
			});
			
			
			if($('#search_type').find('.form-key').val() == 'layout') {
				
				//pagelayout item delete
		        gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:delete_message'), function(){
					var sendUrl =  '/best/cafe/DeletePageLayoutItemList';
					var postData = { 
							"page_layout_item_nos" : seqArray,
							"status" : 'D'
					};
				    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
				    	if(res.return_code == 0){
					    	gFnShowSuccessAlert(i18nUt.get().t('page\\cc\\best:delete_ok'),function(){
					    		getPageLayoutItem(currentPage);
							});
				    	}
	    			});
    			});
				
			} else if($('#search_type').find('.form-key').val() == 'board') {
				
				//bestcard delete
		        gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:delete_message'), function(){
					var sendUrl =  '/best/cafe/DeleteBestCard';
					var postData = { "best_card_list" : seqArray };
				    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
				    	if(res.return_code == 0){
					    	gFnShowSuccessAlert(i18nUt.get().t('page\\cc\\best:delete_ok'),function(){
					    		getBoardSubmenuList(currentPage);
							});
				    	}
	    			});
    			});
				
			} else {
				
				//bestcard delete
		        gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:delete_message'), function(){
					var sendUrl =  '/best/cafe/DeleteBestCard';
					var postData = { "best_card_list" : seqArray };
				    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
				    	if(res.return_code == 0){
					    	gFnShowSuccessAlert(i18nUt.get().t('page\\cc\\best:delete_ok'),function(){
								   getList(currentPage);
							});
				    	}
	    			});
    			});
				
			}
			
			
		}
	});
	
	$(document).on("keypress", "#searchText", function(e) {
		if(e.keyCode==13) {
			card.fnSearch();
		}
	});
	
	if(searchFilter.liveYn == 'Y'){
		$("#cardBtnLive").hide();
		$("#cardBtnHidden").show();
		$("#cardBtnDel").hide();
		$("#cardBtnChange").show();
	}else{
		$("#cardBtnLive").show();
		$("#cardBtnHidden").hide();
		$("#cardBtnDel").show();
		$("#cardBtnChange").hide();
	}
	
	i18nUt.init({
        lang: getCookieData().LOCALE,
        namespace: ['page\\cc\\best','page\\cc\\recommendtag','page\\cc\\cafesetting','page\\cc\\card']
    }).then(function(){
    	card.fnInit();
    });

	
});

function getPageLayoutItem(page) {
	card.fnGetListByGroupNo(page);
}

function getList(page) {
	card.fnGetList(page);
}

function getBoardSubmenuList (page) {
	card.fnGetListByBoardKey(page);
}

function changeBoardContentTextLocal(data,content,clickfunc,key) {
    var result = '';
    var replaceContent = content;
    replaceContent = removeHtmlTag(replaceContent);
    replaceContent = htmlTagEscape(replaceContent);
    replaceContent = replaceContent.replace(/&nbsp;/gi,'');
    replaceContent = replaceContent.replace(/ /gi,'');
    if(isEmpty(replaceContent) === ''){
        replaceContent = '-';
    }
    if(clickfunc !== undefined){
        var str = key.split(',');
        var arrKey = '';
        for(var i=0; i<str.length;i++){
            arrKey += '\''+data[str[i]]+'\',';
        }
        arrKey = arrKey.substr(0,arrKey.length-1);

        var returnStr2 = data['title'] == '' ? '-' : data['title'];
        returnStr2 = returnStr2.replace(/<script>/gi, "");
        returnStr2 = returnStr2.replace(/<\/script>/gi, "");
        returnStr2 = returnStr2.replace(/alert/gi, "");
        
        result = '<a href="javascript:void(0);" data-sticky-title="' + returnStr2 + '"  data-parent="sample010-'+data[str[0]]+'" onclick="'+clickfunc+'('+arrKey+',this)" tabindex="-1">'
		        + replaceContent + '</a><div class="hide" data-sticky-content="sample010-'+data[str[0]]+'">'
		        + replaceContent + '</div>';
    }else{
        result = replaceContent;
    }

    if(isEmpty(replaceContent) === ''){
        result = '-';
    }
    return result;
}
var card = {

	//Inin
	fnInit : function() {
		
		card.fnOnSelect();
		
		//GET 파라미터가 있을 경우
		if('${list_size}') {
			backFlag = 'Y';
			//GET 파라미터 세팅
			gFnSetUrlParam('',
					'${select2}',
					'${select3}',
					'${select4}',
					'${select5}',
					'${page_sort}',
					'${list_size}',
					'${period}',
					'${start_date}',
					'${end_date}',
					'${use_yn}'
					);
			
		}else{
				
			card.fnTableChange();
		}

	},	
	
    //Validation
	fnValidation : function() {
		
		if($("#search_game_id .form-key").val() == ''){
			gFnAlertMessage(i18nUt.get().t('page\\cc\\best:game_valid')); //게임을 선택해주세요.
			return false;
		}
		if($("#search_community .form-key").val() == ''){
			gFnAlertMessage(i18nUt.get().t('page\\cc\\best:community_valid')); //커뮤니티를 선택해주세요.
			return false;
		}
		if($("#search_page .form-key").val() == ''){
			gFnAlertMessage(i18nUt.get().t('page\\cc\\best:page_valid')); //페이지를 선택해주세요.
			return false;
		}
		if($("#search_menu_no .form-key").val() == ''){
			gFnAlertMessage(i18nUt.get().t('page\\cc\\best:board_valid')); //게시판을 선택해주세요.
			return false;
		}
		
		return true;
	},
	
	// 조회 
	fnSearch : function() {
		card.fnGetList();
	},
	
	//초기화
	fnReset : function() {
		getSelect2.data.selected(getSelect2.find("li:eq(0)").attr('data-value'));
        getSelect6.data.selected(getSelect6.find("li:eq(0)").attr('data-value'));
		card.fnTableChange();
	},
	
	fnOnSelect : function() {
		getSelectHTML();
		
		
		getSelect2 = $("#search_game_id").formfield();
		getSelect2.fieldChange = function(val, key) {
			if(key == ''){
				$('#div_select6').css('display', 'none');
				var msg = i18nUt.get().t('page\\cc\\best:community_empty'); // 등록된 커뮤니티가 없습니다.
				getSelect3.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
				card.fnTableChange();
				return;
			} 
			
			card.fnGetCommList(key);
		}
		getSelect2.selectfield();
		
		card.fnGetGameList(getSelect2);
		
		getSelect3 = $("#search_community").formfield();
		getSelect3.fieldChange = function(val, key) {
			//console.log('select:(' + val + ') key:(' + key + ')');
			if(key == ''){
				$('#div_select6').css('display', 'none');
				var msg = i18nUt.get().t('page\\cc\\best:page_empty'); // 등록된 페이지가 없습니다.
				getSelect4.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
				card.fnTableChange();
				return;
			} 
			
			card.fnGetChannelList(key);
		}
		getSelect3.selectfield();
		
		getSelect4 = $("#search_page").formfield();
		getSelect4.fieldChange = function(val, key) {
			if(key == ''){
				$('#div_select6').css('display', 'none');
                var msg = i18nUt.get().t('page\\cc\\best:board_empty'); // 등록된 게시판이 없습니다.
                getSelect5.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
                card.fnTableChange();
                return;
// 				if($("#search_type .form-key").val() == 1){

// 				}
			}else {
				card.fnGetPageLayoutCd($("#search_page .form-key").val())
			}

			
		}
		getSelect4.selectfield();
		
		getSelect5 = $("#search_menu_no").formfield();
		getSelect5.fieldChange = function(val, key) {
			
			if(key != ''){

				if ($('#search_menu_no').find('.list-base>li:eq(0)').attr('data') == 'pageLayout') {
					console.log('레이아웃서브메뉴아이템조회');
					card.fnGetListByGroupNo();
				} else if ($('#search_menu_no').find('.list-base>li:eq(0)').attr('data') == 'boardGroup') {
					console.log('게시판그룹조회');
					card.fnGetListByBoardKey();
				} else {
					console.log('베스트게시물조회');
					card.fnSearch();
				}
			}
			
			card.fnTableChange();
		}
		getSelect5.selectfield();

        getSelect6 = $("#search_type").formfield();
        getSelect6.fieldChange = function(val, key) {

			if(key == 'best'){
			    $("#div_select5 .cell-text").text(t('page\\cc\\best:board_select'));
                card.fnGetMenuList($("#search_page .form-key").val());
			}
            else if(key == 'layout'){
                $("#div_select5 .cell-text").text(t('page\\cc\\best:best_type_select2_title'));
				card.fnGetLayoutSubList($("#search_page .form-key").val());
            }
            else if(key == 'board'){
                $("#div_select5 .cell-text").text(t('page\\cc\\best:best_type_select3_title'));
                card.fnGetBoardSubList(getSelect5);
            }
			else{
                card.fnGetMenuList("");
			}
        }
        getSelect6.selectfield();

//         card.fnGetBestTypeList(getSelect6);

	},
	
	getCodeAndList : function(groupCd, langCd, allfg){
		var sendUrl = '/code/codeList';
	    var postData = { group_cd    : groupCd
	            , use_yn      : "Y"
	            , language_cd : langCd
	        };
	        
	   
	    
	    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
	  	   if(res.return_code == 0){
	 	       var listLength = res.context.data_list.length;
	  		   var paramData = res.context.data_list;
	  		   
	  		   var listTxt = "";
	  		   
	  		   if(listLength > 0){
	  			 gradeList = paramData;
	  		   }

	        }
	     });
	},
	
	//게임 목록 조회
	fnGetGameList : function(select) {
		var sendUrl = "/note/GameInfoGameNmList";
		var postData = {"list_live":"Y"};
		//임시
// 		var postData = {admin_member_no : "167003"};
		
		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){
			
			if(typeof res.context == 'undefined'){
				res.context = {};
	            res.return_count = 0;
	            res.context.list = [];
			}
			
			var returnData = '';
			var paramData = res.context.list;
			var paramCnt = paramData.length;
			
			if(paramData == null || paramData.length == 0){
				var msg = i18nUt.get().t('page\\cc\\best:game_empty'); // 등록된 게임이 없습니다.
				select.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
				return;
			}
			
			var listTxt = "";
			$.each(paramData,function(index,obj){
			    var value = obj.game_no;
				var name = obj.title_game_nm;
				var type = obj.platform_type;
				
				listTxt += '<li class="item" data-value="'+ value +'" data-platform="'+type+'"><a href=""><span>'+ name +'</span></a></li>';
			    
			});

			returnData = listTxt;
			select.data.html(returnData);
			
			if(backFlag == 'Y'){
				getSelect2.data.selected('${select2}');
			}else{
				select.data.selected(select.find("li:eq(0)").attr('data-value'));
			}
			
		});
	},
	
	//커뮤니티 목록 조회
	fnGetCommList : function(gameNo){
		var sendUrl = "/note/CafeListByGameId";
		var postData = {
				"game_no"		: gameNo,
			};
		
		var msg = i18nUt.get().t('page\\cc\\best:community_empty'); // 등록된 커뮤니티가 없습니다.
		getSelect3.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){
			
				if(typeof res.context == 'undefined'){
					res.context = {};
		            res.return_count = 0;
		            res.context.list = [];
				}
			
				var returnData = '';
				
				var paramData = res.context.cafe_list;
				var listLength = res.context.cafe_list.length;
				
				if(listLength == 0){
					var msg = i18nUt.get().t('page\\cc\\best:community_empty'); // 등록된 커뮤니티가 없습니다.
					getSelect3.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
					return;
				}
				
				var listTxt = "";
				$.each(paramData,function(index,obj){
				    var value = obj.cafe_no;
					var name = obj.cafe_nm;
					listTxt += '<li class="item" data-value="'+ value +'"><a href=""><span>'+ name +'</span></a></li>';
				});

				returnData = listTxt;
				getSelect3.data.html(returnData);
				
				if(backFlag == 'Y'){
					getSelect3.data.selected('${select3}');
				}
				else{
					getSelect3.data.selected(getSelect3.find("li:eq(0)").attr('data-value'));
				}
				
		});
	},
	
	//채널 목록 조회
	fnGetChannelList : function(cate_no){
		
		var sendUrl = "/note/ChannelListByCafeNo";
		var postData = {
				"cafe_no"		: cate_no
			};
		
		var msg = i18nUt.get().t('page\\cc\\best:page_empty'); // 등록된 페이지가 없습니다.
		getSelect4.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){
			
				if(typeof res.context == 'undefined'){
					res.context = {};
		            res.return_count = 0;
		            res.context.list = [];
				}
			
				var returnData = '';
				var paramData = res.context.channel_list;
				var listLength = res.context.channel_list.length;
				
				if(listLength == 0){
					var msg = i18nUt.get().t('page\\cc\\best:page_empty'); // 등록된 페이지가 없습니다.
					getSelect4.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
					return;
				}
				
				var listTxt = "";
	 		   
				$.each(paramData,function(index,obj){
				    var value = obj.channel_no;
					var name = obj.channel_nm;
					
					listTxt += '<li class="item" data-value="'+ value +'"><a href=""><span>'+ name +'</span></a></li>';
				});
				
				returnData = listTxt;
				getSelect4.data.html(returnData);
		 	    
				if(backFlag == 'Y'){
					getSelect4.data.selected('${select4}');
				}
				else{
					getSelect4.data.selected(getSelect4.find("li:eq(0)").attr('data-value'));
				}
		});
	},
	
	//채널 상세 조회
	fnGetPageLayoutCd : function(channel_no) {
		var sendUrl = "/CafeChannel/ChannelInfo";
		var postData = {
				"channel_no"		: channel_no
			};
		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){

			if(typeof res.context == 'undefined'){
				res.context = {};
			}
			var pageLayoutCd = res.context.page_layout_cd;
			if(pageLayoutCd == 1) {
				$('#div_select6').css('display', 'none');
				$("#div_select5 .cell-text").html(t('page\\cc\\best:board_select'));
				card.fnGetMenuList($("#search_page .form-key").val());
			}else {
				$('#div_select6').css('display', 'block');
				getSelect6.data.selected($("#search_type .form-key").val());
				card.fnGetBestTypeList(getSelect6);
			}
		});
	},

	//게시판 목록 조회
	fnGetMenuList : function(channel_no){

		var sendUrl = "/best/cafe/BestBoardList";
		var postData = {
				"channel_no"		: channel_no
			};

		var msg = i18nUt.get().t('page\\cc\\best:board_empty'); // 등록된 게시판이 없습니다.
		getSelect5.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){

				if(typeof res.context == 'undefined'){
					res.context = {};
		            res.return_count = 0;
		            res.context.best_board_list = [];
				}
				
				var returnData = '';
				var paramData = res.context.best_board_list != null? res.context.best_board_list : [];
				var listLength = paramData.length;

				if(listLength == 0){
					var msg = i18nUt.get().t('page\\cc\\best:board_empty'); // 등록된 게시판이 없습니다.
					getSelect5.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
					return;
				}

				var listTxt = "";
	 		   $.each(paramData,function(index,obj){
				    var value = obj.board_no;
					var name = obj.menu_nm;
					listTxt += '<li class="item" data-value="'+ value +'"><a href=""><span>'+ name +'</span></a></li>';
				});

				returnData = listTxt;
				getSelect5.data.html(returnData);

				if(backFlag == 'Y'){
					getSelect5.data.selected('${select5}');
				}
				else{
					getSelect5.data.selected(getSelect5.find("li:eq(0)").attr('data-value'));
				}

		});
	},

	fnGetBestTypeList : function(select){

        var listTxt = '';
        listTxt+= '<li class="item" data-value="best"><a href=""><span>'+ t('page\\cc\\best:best_type_select1') +'</span></a></li>';
        listTxt+= '<li class="item" data-value="layout"><a href=""><span>'+ t('page\\cc\\best:best_type_select2') +'</span></a></li>';

        if($('#div_select2').find('.form-key').val() == "${projectf}") {
	    	listTxt+= '<li class="item" data-value="board"><a href=""><span>'+ t('page\\cc\\best:best_type_select3') +'</span></a></li>';
        }

        select.data.html(listTxt);
        
        if(backFlag == 'Y'){
        	select.data.selected('${select6}');
		}
		else{
	        select.data.selected(select.find("li:eq(1)").attr('data-value'));
		}
        
	},

    fnGetLayoutSubList: function(channel_no){

    	var sendUrl = '/CafeChannel/ChannelInfo';
		var postData = {
				'channel_no' : channel_no
			};

		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){

			var lang_cd = "${language_cd}"
			if (res.context.language_list) {
				$.each(res.context.language_list, function (k,v) {
					if (v.lang_cd == '1') lang_cd = v.lang;
				});
			}

	    	var sendUrl = '/best/cafe/PageLayoutSubMenuList';
			var postData = {
					'channel_no' : channel_no,
					'lang' : lang_cd
				};

			var msg = i18nUt.get().t('page\\cc\\best:submenu_empty');
			getSelect5.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
			sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function(res){
				var listTxt = '';
				if(res.return_code == 0) {
					if(res.context.page_layout_sub_menu_list.length > 0) {
						$.each(res.context.page_layout_sub_menu_list, function (idx, val) {
							listTxt += '<li class="item" data="pageLayout" data-value="'+ val.group_no +'"><a href=""><span>'+ val.channel_card_group_nm +'</span></a></li>';
						})
					} else {
						var msg = i18nUt.get().t('page\\cc\\best:submenu_empty');
						getSelect5.data.html('<li class="item selected" data-value=""><a href=""><span>'+msg+'</span></a></li>');
						return false;
					}
					
				}

				getSelect5.data.html(listTxt);

				if(backFlag == 'Y'){
					getSelect5.data.selected('${select5}');
				}
				else{
					getSelect5.data.selected(getSelect5.find("li:eq(0)").attr('data-value'));
				}

			});
		});

	},

    fnGetBoardSubList: function(select){
        var listTxt = '';

        /*
        TODO data-value값은 베스트 게시물 목록 API에서 어떤값을 받을지 확정되면 변경 할 것. (우선 1,2,3으로 처리)
        */

        listTxt += '<li class="item" data="boardGroup" data-value="pf-design"><a href=""><span>'+ i18nUt.get().t('page\\cc\\best:best_type_layout_select1') +'</span></a></li>';
        listTxt += '<li class="item" data="boardGroup" data-value="pf-usermode"><a href=""><span>'+ i18nUt.get().t('page\\cc\\best:best_type_layout_select2') +'</span></a></li>';
        listTxt += '<li class="item" data="boardGroup" data-value="pf-homeland"><a href=""><span>'+ i18nUt.get().t('page\\cc\\best:best_type_layout_select3') +'</span></a></li>';

        select.data.html(listTxt);
        select.data.selected(select.find("li:eq(0)").attr('data-value'));
    },

	fnGetJson : function(excelYn) {
		
		var param = {
				"channel_no" : parseInt($("#search_page .form-key").val()),
				"board_no" : parseInt($("#search_menu_no .form-key").val()),
				"use_yn" : searchFilter.liveYn, 
				"size" : parseInt(searchFilter.pageRowCount),
				"page" : currentPage
			};

		return param;
	},
	
	//조회
	fnGetList : function(page) {
		
		if(!card.fnValidation()) return;
		
		if (page) {
			currentPage = page;
		} else {
			currentPage = 1;
		}
		
		if(searchFilter.liveYn == 'Y'){
			$("#cardBtnLive").hide();
			$("#cardBtnHidden").show();
			$("#cardBtnDel").hide();
			$("#cardBtnChange").show();
		}else{
			$("#cardBtnLive").show();
			$("#cardBtnHidden").hide();
			$("#cardBtnDel").show();
			$("#cardBtnChange").hide();
		}
		backFlag = 'N';
		var sendUrl = "/best/cafe/BestCardList";
		var postData = card.fnGetJson('N');
			
		// 조회 된 결과로 파라메터 SET한 후, 보드타입 리스트 조회
		boardGetData = card.fnGetJson('N');
		boardGetData.search_menu_no = $("#search_menu_no .form-key").val();
		delete boardGetData.menu_no;
		
		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), card.fnTableChange);	
	},
	
	fnGetListByGroupNo : function (page) {
		if(!card.fnValidation()) return;

		if (page) {
			currentPage = page;
		} else {
			currentPage = 1;
		}

		if(searchFilter.liveYn == 'Y'){
			$("#cardBtnLive").hide();
			$("#cardBtnHidden").show();
			$("#cardBtnDel").hide();
			$("#cardBtnChange").hide();
		}else{
			$("#cardBtnLive").show();
			$("#cardBtnHidden").hide();
			$("#cardBtnDel").show();
			$("#cardBtnChange").hide();
		}
		backFlag = 'N';
		var sendUrl = "/best/cafe/PageLayoutItemList";

		var param = {
			"channel_no" : parseInt($("#search_page .form-key").val()),
			"group_no" : parseInt($("#search_menu_no .form-key").val()),
			"status" : searchFilter.liveYn,
			"page" : currentPage,
			"size" : parseInt(searchFilter.pageRowCount)
		};
		
		// 조회 된 결과로 파라메터 SET한 후, 보드타입 리스트 조회
		boardGetData = card.fnGetJson('N');
		boardGetData.search_menu_no = $("#search_menu_no .form-key").val();
		delete boardGetData.menu_no;

		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(param), card.fnTableChange);

	},

	fnGetListByBoardKey : function (page) {
		if(!card.fnValidation()) return;

		if (page) {
			currentPage = page;
		} else {
			currentPage = 1;
		}


		if(searchFilter.liveYn == 'Y'){
			$("#cardBtnLive").hide();
			$("#cardBtnHidden").show();
			$("#cardBtnDel").hide();
			$("#cardBtnChange").hide();
		}else{
			$("#cardBtnLive").show();
			$("#cardBtnHidden").hide();
			$("#cardBtnDel").show();
			$("#cardBtnChange").hide();
		}
		backFlag = 'N';
		var sendUrl = "/best/cafe/BoardList";
		var postData = {
				"channel_no" : parseInt($("#search_page .form-key").val())
				, "page" : 1
				, "size" : 10
		}

		sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function (res) {
			
			var sendUrl = "/best/cafe/BoardList";
			var postData = {
					"channel_no" : parseInt($("#search_page .form-key").val())
					, "page" : 1
					, "size" : res.context.total_count
			}
			
			sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(postData), function (res) {
				
				var boardKey = '';
				switch ($('#search_menu_no').find('.form-value').val()) {
					case i18nUt.get().t('page\\cc\\best:best_type_layout_select1') :
						boardKey = 'crossfire_notice';
						break;
					case i18nUt.get().t('page\\cc\\best:best_type_layout_select2') : 
						boardKey = 'pf-usermode';
						break;
					case i18nUt.get().t('page\\cc\\best:best_type_layout_select3') :
						boardKey = 'pf-homeland';
						break;
				}
				
				var objBoard = _.filter(res.context.board_list, function (o) {
					return o.board_key == boardKey;
				})
				$('#search_menu_no').find('.form-key').val(objBoard[0].board_no);
	
				var param = {
					"channel_no" : parseInt($("#search_page .form-key").val()),
					"board_no" : parseInt($('#search_menu_no').find('.form-key').val()),
					"use_yn" : searchFilter.liveYn,
					"size" : parseInt(searchFilter.pageRowCount),
					"page" : currentPage
				};
				var sendUrl = "/best/cafe/BestCardList";

				// 조회 된 결과로 파라메터 SET한 후, 보드타입 리스트 조회
				boardGetData = card.fnGetJson('N');
				boardGetData.search_menu_no = $("#search_menu_no .form-key").val();
				delete boardGetData.menu_no;
				
				sendAjaxJsonAsync('POST', sendUrl, JSON.stringify(param), card.fnTableChange);
			})
			
			

		});

	},
	fnTableChange : function(res){
		
		if(res === undefined || res.return_code != 0){
            res = new Object();
            res.return_count = 0;
            res.context = null;
		}
		
        totalCount = res.context == null ? '0' : res.context.total_count;
        var tableData = res.context != null ? res.context.best_cards : null;
        pfontUrl = res.context != null ? res.frontUrl : '';
        
		if($('#div_select6').css('display') == 'block' && $('#search_type').find('.form-key').val() == 'layout') {
			tableData = res.context != null ? res.context.recommend_list : null;
		}
        
        if(isEmpty(tableData) !== ''){
        	
        	popCafeNo = $("#search_community .form-key").val();
        	popChannelNo = $("#search_page .form-key").val();
        	popCommunityNo = $("#search_menu_no .form-key").val();
        	
            $(tableData).each(function (key,val) {

            	val.user_id = setEmailMasking(isEmpty(val.user_id));
            	
//             	val.detail_url = pfontUrl + '/' +  val.cafe_key + '/' + val.channel_key +'/view?cardNo='+ val.card_no + '&communityNo='+ val.community_no;
				val.detail_url = pfontUrl;
				if (!val.claim_yn) {
					val.claim_yn = 'N';
				}
				if(!val.best_nickname) {
					val.best_nickname = '-';
				}
				if(!val.character_nickname) {
					val.character_nickname = '-';
				}
				if(!val.admin_user_id) {
					val.admin_user_id = '-';
				}
				
                if (val.claim_yn.toLowerCase() === 'n') {
                    val.claim_yn_lang = i18nUt.get().t('common:show');
                } else if (val.claim_yn.toLowerCase() === 'd') {
                	val.claim_yn_lang = i18nUt.get().t('common:user_delete');
                } else {
                    val.claim_yn_lang = i18nUt.get().t('common:hide');
                }
                
                if (val.use_yn.toLowerCase() === 'n') {
                    val.use_yn_lang = i18nUt.get().t('common:hide');
                } else {
                    val.use_yn_lang = i18nUt.get().t('common:show');
                }                
                
                val.use_yn_del = i18nUt.get().t('common:delete');//삭제
                val.game_no = $("#search_game_id .form-key").val();
                
                var best_type_cd_nm = '-';
                
                if(val.best_type_cd == 1){
                	val.best_type_cd_nm = 'BEST';
                }
				if(val.best_type_cd == 2){
					val.best_type_cd_nm = t('page\\cc\\best:add.best_type_cd_nm_2');//'공지';
                }

                if(gFnIsEmpty(val.best_title)) val.best_title = '-';
                if(gFnIsEmpty(val.title)) val.title = '-';

				var regUpdDate = "";
				regUpdDate = setDateByLongNoCalc("", val.reg_dt, 1);
				if(!(val.upd_dt === 'null' || val.upd_dt === null || val.upd_dt === undefined || val.upd_dt.length === 0)) {
					regUpdDate += "<br><font style='color:#c9c9c9'>(" + setDateByLongNoCalc("", val.upd_dt, 1) + ")</font>";
				}
				val.reg_upd_date = regUpdDate;
				
				var card_type_nm = '-';
                if(!gFnIsEmpty(val.card_type)){
                    if(val.card_type == 'CARD'){
                    	card_type_nm = t('page\\cc\\cafesetting:page_130');
                    }
                    if(val.card_type == 'BOARD'){
                    	card_type_nm = t('page\\cc\\cafesetting:page_80');
                    }
                }
                val.card_type_nm = card_type_nm;

//     			var gradeCnt = gradeList.length;
//     			for (var i=0;j<gradeCnt;i++){
//     				if(val.grade_cd == popGradeList[i].code_id){
//     					gradeTxt = popGradeList[i].code_nm;
//     					continue;
//     				}
//     			}
            })
        }
		
		$("#totalCnt").text(totalCount);
		
		var divId = 'tableList';
		var gameKey = $('#search_game_id input.form-key').val();
		var platform = $('#search_game_id .option-body li[data-value="'+gameKey+'"]').attr('data-platform');
		
		var columns = [];
		if(searchFilter.liveYn == 'Y'){
		
			if($('#search_type').find('.form-key').val() == 'best') {
				columns = [ 
					{colgroup: '80px'  , headertext: 'allCheck'   , datafield: 'best_no', datafunc: card.fnSetExhibitCheckBox, datafunckey: checkName},
					{colgroup: '85px', headertext : i18nUt.get().t('page\\cc\\best:best_list.best_type_cd'), datafield : 'best_type_cd_nm', datafunc: setClickListButton, clickfunc: 'card.updateBestType', datafunckey: 'channel_no,best_no,use_yn,best_type_cd,board_no,card_no' },
					{colgroup: '5%', headertext : i18nUt.get().t('page\\cc\\best:best_list.no'), datafield : 'card_no'},
	                {colgroup: '70px', headertext : i18nUt.get().t('page\\cc\\best:best_list.board_type'), datafield : 'card_type_nm', datafunc: card.setClickBoardType, datafunckey: 'card_no'},
					{colgroup: '5%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_yn_lang'), datafield : 'claim_yn_lang'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.like_cnt'), datafield : 'like_cnt', datafunc: setClickTextZeroToUnlink, clickfunc: 'card.likeUserPopupOpen',datafunckey: 'card_no,like_cnt'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_cnt'), datafield : 'claim_cnt', datafunc: card.setClickCnt, clickfunc: 'card.claimPopupOpen',datafunckey: 'card_no'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.read_cnt'), datafield : 'read_cnt'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.best_title'), datafield : 'best_title' , datatype:'elipse'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.title'), datafield : 'title' , datatype:'elipse', datafunc: changeBoardContentText, clickfunc: 'card.cardDetailPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,best_no,member_no,board_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.use_yn_lang'), datafield : 'use_yn_lang', datafunc: setClickListButton, clickfunc:'card.cpContentsListIndividual',datafunckey: 'channel_no,card_no,use_yn,best_type_cd,game_no,best_no', viewResourceId : 'SBC5016', paramResources : '${resourceList}'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_no'), datafield : 'member_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_info'), datafield : 'nickname', datatype:'elipse', datafunc: setClickText, clickfunc: 'card.userNicknamePopupOpen',datafunckey: 'member_no,game_no,cafe_no,channel_no,country_cd'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.game_character'), 	datafield : 'character_nickname'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.reply_cnt'), datafield : 'reply_cnt', datafunc: card.setReplyCntClick, clickfunc: 'card.replyPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,member_no'},
// 					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.character_no'), 	datafield : 'character_id'},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:add.best_reg_dt'), 	datafield : 'best_reg_dt' , datafunc: setDateByLongNoCalc, datafunckey:1000},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:add.reg_upd_dt'), 	datafield : 'reg_upd_date'},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:best_list.admin_user_id'), 	datafield : 'admin_user_id'}];
				//PC일때 게임캐릭터 번호 칼럼제거(index 번호로 제거하기때문에 추후 칼럼 추가시 수정 필요)
// 				if(platform && platform.toLowerCase() == 'online') columns.splice(13, 1); //splice(colums-index, number)
			} else {
				columns = [ 
					{colgroup: '80px'  , headertext: 'allCheck'   , datafield: 'best_no', datafunc: card.fnSetExhibitCheckBox, datafunckey: checkName},
					{colgroup: '5%', headertext : i18nUt.get().t('page\\cc\\best:best_list.no'), datafield : 'card_no'},
					{colgroup: '70px', headertext : i18nUt.get().t('page\\cc\\best:best_list.board_type'), datafield : 'card_type_nm', datafunc: card.setClickBoardType, datafunckey: 'card_no'},
					{colgroup: '5%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_yn_lang'), datafield : 'claim_yn_lang'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.like_cnt'), datafield : 'like_cnt', datafunc: card.setClickCnt, clickfunc: 'card.claimPopupOpen',datafunckey: 'card_no'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_cnt'), datafield : 'claim_cnt', datafunc: card.setClickCnt, clickfunc: 'card.claimPopupOpen',datafunckey: 'card_no'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.read_cnt'), datafield : 'read_cnt'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.title'), datafield : 'title', datatype:'elipse'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.content'), datafield : 'content', datatype:'elipse', datafunc: changeBoardContentTextLocal, clickfunc: 'card.cardDetailPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,best_no,member_no,board_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.use_yn_lang'), datafield : 'use_yn_lang', datafunc: setClickListButton, clickfunc:'card.cpContentsListIndividual',datafunckey: 'channel_no,card_no,use_yn,best_type_cd,game_no,best_no', viewResourceId : 'SBC5016', paramResources : '${resourceList}'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_no'), datafield : 'member_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_info'), datafield : 'nickname', datatype:'elipse', datafunc: setClickText, clickfunc: 'card.userNicknamePopupOpen',datafunckey: 'member_no,game_no,cafe_no,channel_no,country_cd'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.game_character'), 	datafield : 'character_nickname'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.reply_cnt'), datafield : 'reply_cnt', datafunc: card.setReplyCntClick, clickfunc: 'card.replyPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,member_no'},
// 					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.character_no'), 	datafield : 'character_id'},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:add.best_reg_dt'), 	datafield : 'best_reg_dt' , datafunc: setDateByLongNoCalc, datafunckey:1000},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:add.reg_upd_dt'), 	datafield : 'reg_upd_date'},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:best_list.admin_user_id'), 	datafield : 'admin_user_id'}];
				//PC일때 게임캐릭터 번호 칼럼제거(index 번호로 제거하기때문에 추후 칼럼 추가시 수정 필요)
// 				if(platform && platform.toLowerCase() == 'online') columns.splice(10, 1); //splice(colums-index, number)
			}
			
		}else{
			
			if($('#search_type').find('.form-key').val() == 'best') {
				columns = [ 
					{colgroup: '80px'  , headertext: 'allCheck'   , datafield: 'best_no', datafunc: card.fnSetExhibitCheckBox, datafunckey: checkName},
					{colgroup: '80px', headertext : i18nUt.get().t('page\\cc\\best:best_list.no'), datafield : 'card_no'},
	                {colgroup: '70px', headertext : i18nUt.get().t('page\\cc\\best:best_list.board_type'), datafield : 'card_type_nm', datafunc: card.setClickBoardType, datafunckey: 'card_no'},
					{colgroup: '5%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_yn_lang'), datafield : 'claim_yn_lang'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.like_cnt'), datafield : 'like_cnt', datafunc: setClickTextZeroToUnlink, clickfunc: 'card.likeUserPopupOpen',datafunckey: 'card_no,like_cnt'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_cnt'), datafield : 'claim_cnt', datafunc: card.setClickCnt, clickfunc: 'card.claimPopupOpen',datafunckey: 'card_no'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.read_cnt'), datafield : 'read_cnt'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.best_title'), datafield : 'best_title' , datatype:'elipse'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.title'), datafield : 'title' , datatype:'elipse', datafunc: changeBoardContentText, clickfunc: 'card.cardDetailPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,best_no,member_no,board_no'},
					{colgroup: '8%', headertext : i18nUt.get().t('page\\cc\\best:best_list.use_yn_lang'), datafield : 'use_yn_lang', datafunc: setClickListButton, clickfunc:'card.cpContentsListIndividual',datafunckey: 'channel_no,card_no,use_yn,best_type_cd,game_no,best_no', viewResourceId : 'SBC5016', paramResources : '${resourceList}'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_no'), datafield : 'member_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_info'), datafield : 'nickname', datatype:'elipse', datafunc: setClickText, clickfunc: 'card.userNicknamePopupOpen',datafunckey: 'member_no,game_no,cafe_no,channel_no,country_cd'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.game_character'), 	datafield : 'character_nickname'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.reply_cnt'), datafield : 'reply_cnt', datafunc: card.setReplyCntClick, clickfunc: 'card.replyPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,member_no'},
					{colgroup: '100px', headertext : i18nUt.get().t('page\\cc\\best:add.best_reg_dt'), 	datafield : 'best_reg_dt' , datafunc: setDateByLongNoCalc, datafunckey:1000},
					{colgroup: '100px', headertext : i18nUt.get().t('page\\cc\\best:add.reg_upd_dt'), 	datafield : 'reg_upd_date'},
					{colgroup: '100px', headertext : i18nUt.get().t('page\\cc\\best:best_list.admin_user_id'), 	datafield : 'admin_user_id'},
					{colgroup: '80px', headertext: i18nUt.get().t('common:delete'), datafield: 'use_yn_del', datafunc: setClickListButton, clickfunc: 'card.delMain', datafunckey:'best_no', viewResourceId : 'SBD5017', paramResources :"${resourceList}"}];
				
				//PC일때 게임캐릭터 번호 칼럼제거(index 번호로 제거하기때문에 추후 칼럼 추가시 수정 필요)
// 				if(platform && platform.toLowerCase() == 'online') columns.splice(12, 1); //splice(colums-index, number)
				
			} else {
				
				columns = [
					{colgroup: '80px'  , headertext: 'allCheck'   , datafield: 'best_no', datafunc: card.fnSetExhibitCheckBox, datafunckey: checkName},
					{colgroup: '80px', headertext : i18nUt.get().t('page\\cc\\best:best_list.no'), datafield : 'card_no'},
					{colgroup: '70px', headertext : i18nUt.get().t('page\\cc\\best:best_list.board_type'), datafield : 'card_type_nm', datafunc: card.setClickBoardType, datafunckey: 'card_no'},
					{colgroup: '5%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_yn_lang'), datafield : 'claim_yn_lang'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.like_cnt'), datafield : 'like_cnt', datafunc: card.setClickCnt, clickfunc: 'card.claimPopupOpen',datafunckey: 'card_no'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.claim_cnt'), datafield : 'claim_cnt', datafunc: card.setClickCnt, clickfunc: 'card.claimPopupOpen',datafunckey: 'card_no'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.read_cnt'), datafield : 'read_cnt'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.title'), datafield : 'title', datatype:'elipse'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.content'), datafield : 'content', datatype:'elipse',datafunc: changeBoardContentTextLocal, clickfunc: 'card.cardDetailPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,best_no,member_no,board_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.use_yn_lang'), datafield : 'use_yn_lang', datafunc: setClickListButton, clickfunc:'card.cpContentsListIndividual',datafunckey: 'channel_no,card_no,use_yn,best_type_cd,game_no,best_no', viewResourceId : 'SBC5016', paramResources : '${resourceList}'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_no'), datafield : 'member_no'},
					{colgroup: '7%', headertext : i18nUt.get().t('page\\cc\\best:best_list.member_info'), datafield : 'nickname', datatype:'elipse', datafunc: setClickText, clickfunc: 'card.userNicknamePopupOpen',datafunckey: 'member_no,game_no,cafe_no,channel_no,country_cd'},
					{colgroup: '10%', headertext : i18nUt.get().t('page\\cc\\best:best_list.game_character'), 	datafield : 'character_nickname'},
					{colgroup: '3%', headertext : i18nUt.get().t('page\\cc\\best:best_list.reply_cnt'), datafield : 'reply_cnt', datafunc: card.setReplyCntClick, clickfunc: 'card.replyPopupOpen',datafunckey: 'card_no,game_no,claim_yn,detail_url,member_no'},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:add.best_reg_dt'), 	datafield : 'best_reg_dt' , datafunc: setDateByLongNoCalc, datafunckey:1000},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:add.reg_upd_dt'), 	datafield : 'reg_upd_date'},
					{colgroup: '120px', headertext : i18nUt.get().t('page\\cc\\best:best_list.admin_user_id'), 	datafield : 'admin_user_id'},
					{colgroup: '80px', headertext: i18nUt.get().t('common:delete'), datafield: 'use_yn_del', datafunc: setClickListButton, clickfunc: 'card.delMain', datafunckey:'best_no', viewResourceId : 'SBD5017', paramResources :"${resourceList}"}];
				
				//PC일때 게임캐릭터 번호 칼럼제거(index 번호로 제거하기때문에 추후 칼럼 추가시 수정 필요)
// 				if(platform && platform.toLowerCase() == 'online') columns.splice(11, 1); //splice(colums-index, number)
				
			}
			
		}
			
		var noneData = i18nUt.get().t('page\\cc\\best:best_list_empty'); //검색된 BEST 게시물이 없습니다.
		newTableScrollHTML(columns, tableData, noneData, divId);
		makePageNavigationBar(totalCount, currentPage, searchFilter.pageRowCount, 10, 'getList', 'pageList');
		if(searchFilter.liveYn == 'Y'){
			$("#pageList").hide();
		}else{
			$("#pageList").show();
		}
		new backoffice();
        new tableClamp();
	},
	
	updateBestType : function(channel_no,best_no,use_yn,best_type_cd,board_no,card_no) {
		
		var sendUrl = '/best/cafe/UpdateOnBestCard';
		var cardNogArray = new Array();
		cardNogArray.push(parseInt(best_no));
		
		var postData = {
			'best_no_list' : cardNogArray,
			'channel_no' : parseInt(channel_no),
			'board_no' : parseInt($('#search_menu_no .form-key').val())
		};
		
		var alertStr;
		
		/* 공지로 등록 */
		if(best_type_cd == '1') {
			alertStr = i18nUt.get().t('page\\cc\\best:add.best_list_alert8');
			postData.best_type_cd = 2;
		/* BEST로 등록 */
		} else {
			alertStr = i18nUt.get().t('page\\cc\\best:add2.change_type_to_best');
			postData.best_type_cd = 1;
		}
		
		gFnShowConfirmAlert2(alertStr, function() {
			sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
				if(res.return_code == "10002"){
					gFnAlertMessage(res.return_message);
				}
				else if(res.return_code != "891"){
					if($('#search_type').find('.form-key').val() == 'board') {
                		getBoardSubmenuList(currentPage);
                	} else {
						getList(currentPage);
                	}
				}
			});
		 },function(){});
	},
	
    setClickMemo : function(data,content,clickfunc,key){
        var result = '';
        if(content != 'N'){
            var str = key.split(',');
            var arrKey = '';
            for(var i=0; i<str.length;i++){
                arrKey += '\''+data[str[i]]+'\',';
            }
            arrKey = arrKey.substr(0,arrKey.length-1);

            result = '<a href="javascript:void(0);" onclick="'+clickfunc+'('+arrKey+',\'CARD\')" tabindex="-1">' + content + '</a>';
		}else{
            result = content;
		}
        return result;
    },
    
    delMain : function(best_no, target){
    	
		var seqArray = new Array();
		seqArray.push(parseInt(best_no));
		
		if($('#search_type').find('.form-key').val() == 'layout') {
			//pagelayout item delete
	        gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:delete_message'), function(){
				var sendUrl =  '/best/cafe/DeletePageLayoutItemList';
				var postData = { 
						"page_layout_item_nos" : seqArray,
						"status" : 'D'
				};
			    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
			    	if(res.return_code == 0){
				    	gFnShowSuccessAlert(i18nUt.get().t('page\\cc\\best:delete_ok'),function(){
				    		getPageLayoutItem(currentPage);
						});
			    	}
    			});
			});
		} else if($('#search_type').find('.form-key').val() == 'board') { 
			//bestcard delete
			gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:delete_message'), function(){
				var sendUrl =  '/best/cafe/DeleteBestCard';
				var postData = { "best_card_list" : seqArray };
			    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(param){
			    	if(param.return_code == 0){
				    	gFnShowSuccessAlert(i18nUt.get().t('page\\cc\\best:delete_ok'),function(){
				    		getBoardSubmenuList(currentPage);
						});
			    	}
	   			});
			});
		} else {
			//bestcard delete
			gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:delete_message'), function(){
				var sendUrl =  '/best/cafe/DeleteBestCard';
				var postData = { "best_card_list" : seqArray };
			    sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(param){
			    	if(param.return_code == 0){
				    	gFnShowSuccessAlert(i18nUt.get().t('page\\cc\\best:delete_ok'),function(){
							   getList(currentPage);
						});
			    	}
	   			});
			});
		}
    	
       

	},
    
    setParenthesis : function(data,content,key){
        var str = key.split(',');
        var contNm = '-';
        var contCd = '-';
        var returnData;
        
        if(data[str[0]] !== null){
        	contNm = data[str[0]];
        }
        
        if(data[str[1]] !== null){
        	contCd = data[str[1]];
        }
        
        returnData = contNm+'('+contCd+')';
        return returnData;
    },
	
	memoPopupOpen : function(gameNo,cardNo,claimYn){
        memoPopup = new modal({
            content : '#memoPopup',
            backdrop:true
        });
        memePopupSetData(gameNo,cardNo,claimYn,'CARD');
	},
	
    setClickCnt : function(data,content,clickfunc,key){
        var result = '';
        
        if(content !== 0){
            var str = key.split(',');
            var arrKey = '';
            for(var i=0; i<str.length;i++){
                arrKey += '\''+data[str[i]]+'\',';
            }
            arrKey = arrKey.substr(0,arrKey.length-1);

            result = '<a href="javascript:void(0);" onclick="'+clickfunc+'('+arrKey+',this)" tabindex="-1">' + content + '</a>';
		}else{
            result = content;
		}
        return result;
    },
    
	setReplyCntClick : function(data,content,clickfunc,key){
		
	    var str = key.split(',');
	    var arrKey = '';
	    for(var i=0; i<str.length;i++){
	        arrKey += '\''+data[str[i]]+'\',';
	    }
	    arrKey = arrKey.substr(0,arrKey.length-1);
		
	    var result = ''
	    if(data.reply_cnt > 0){
	    	
	    	result = '<a href="javascript:void(0);" onclick="'+clickfunc+'('+arrKey+',this)" tabindex="-1">' + content + '</a>';
	    	
	    }else{
	    	result = data.reply_cnt;
	    }
	    return result;
	},
	
    likeUserPopupOpen : function(card_no, like_cnt){
        var likeUserPopup = new modal({
            content : '#likeUserPopup',
            backdrop:true,
            close : function(){likeUserPopup.close()}
        });
        likeUserPopupSetDate(card_no);
    },
	
    //신고자정보
    claimPopupOpen : function(card_no){
        claimPopup = new modal({
            content : '#claimPopup',
            backdrop:true,
            close : function(){claimPopup.close()}
        });
        claimPopupSetDate(card_no);
    },
    
    //카드상세
    cardDetailPopupOpen : function(card_no,game_no,claim_yn, detail_url,best_no,member_no,board_no) {
    	
    	if($('#search_type').find('.form-key').val() == 'best') {
    		bestDetailPopup = new modal({
	            content : '#cardDetailPopup',
	            backdrop:true,
	            close : function(){bestDetailPopup.close()}
	        });
	    	cardDetailPopupObject.member_no = member_no;
	    	cardDetailPopupSetDate(card_no,game_no,claim_yn, detail_url,"BEST",board_no,best_no);
    	} else {
    		cardDetailPopup = new modal({
                content : '#cardDetailPopup',
                backdrop:true,
                close: function(){
                	cardDetailPopup.close();
                }
            });
    		cardDetailPopupObject.member_no = member_no;
            cardDetailPopupSetDate(card_no,game_no,claim_yn, detail_url,"CARD");
    	}
    	
    	
    },
    
  	//댓글상세
    replyPopupOpen : function(card_no,game_no,claim_yn, detail_url,member_no) {
        var replyPopup = new modal({
            content : '#cardDetailPopup',
            backdrop:true,
            close: function(){
            	replyPopup.close();
            }
        });
        
        cardDetailPopupObject.member_no = member_no;
        cardDetailPopupSetDate(card_no,game_no,claim_yn, detail_url,"REPLY");
    },
    
	//신규등록
    bestFormPopupOpen : function(){
    	bestFormPopupReset();
    	bestFormPopup = new modal({
            content : '#bestFormPopup',
            backdrop:true,
            close : function(){bestFormPopup.close()}
        });
    },
    
// 	//회원 정보
//     userPopupOpen : function(member_no,game_no){
//         userPopup = new modal({
//             content : '#userPopup',
//             backdrop:true,
//             close : function(){userPopup.close()}
//         });
//         userNicknamePopupSetDate(member_no,game_no,cafe_no,channel_no);

//         //제재버튼 무조건 숨김
//         $("#sanction_btn_div").hide();
//     },
    
    // 유저등급
    gradePopupOpen : function(){
        gradePopup = new modal({
            content : '#gradePopup',
            backdrop:true,
            close : function(){gradePopup.close()}
        });
        gradePopupGetList();
    },
    
//     //닉네임
//     nicknamePopupOpen : function(member_no){
//         nicknamePopup = new modal({
//             content : '#nicknamePopup',
//             backdrop:true,
//             close : function(){nicknamePopup.close()}
//         });
//         nicknamePopupSetDate(member_no);
//     },
    userNicknamePopupOpen : function(member_no,game_no,cafe_no,channel_no,country_cd){
        userNicknamePopup = new modal({
            content : '#userNicknamePopup',
            backdrop:true,
            close : function(){userNicknamePopup.close()}
        });
        
        userNicknamePopupSetDate(member_no,game_no,cafe_no,channel_no,country_cd);
        $("#sanction_btn_div").hide();
    },
    
    /*공통 테이블 checkbox 생성*/
    fnSetExhibitCheckBox : function(data,content,key){

        //유저삭제는 checkbox 미표시.
        if(data.claim_yn.toLowerCase() == 'd'){
            return '-';
        }

        var result = '';
        result += '<label class="checkbox">';
       	result += '<input type="checkbox" class="check-input" cardno="'+data.card_no+'" gameno="'+data.game_no+'" channelno="'+data.channel_no+'" besttypecd="'+data.best_type_cd+'" name="'+key+'" value="'+content+'">';	
   		result += '<span class="check-effect">';
        result += '<span class="check-roundbox"></span>';
        result += '</span>';
        result += '</label>';
        return result;
    },
	
	fnRollOverPop : function (url,target){
    	//팝업 내 상세 호출
    	dialImgInfo(url);
    	//dialog 팝업 호출
		dialog01212002Preview = new dialog({
			btn     : target,
			content :'#dialog-01212002'
		})	
    },
    
    fnRollOut : function(){
		if(dialog01212002Preview){
			dialog01212002Preview.close()			
		}	
    },
    
    // 이미지 CELL
    fnSetImgInfo : function(data,content,key){
    	var result = '';
    	if(content != "-"){
    		result =  '<div class="cell-image"><div class="thumbnail default"><a href="'+content+'" target="_blank"><span class="img default" style="background:url('+content+') no-repeat;"  onmouseover="card.fnRollOverPop(\''+content+'\',this)" onmouseleave="card.fnRollOut()"></span></a></div></div>';
    	}else{
    		result = '-';	
    	}
    	
    	return result;
    },
    
    // 게시물 이동 팝업
    cardMovePopupOpen : function(){
        var cardNogArray = new Array();
        $(':checkbox[name='+checkName+']:checked').each(function(pi,po){
            cardNogArray.push(parseInt(po.value));
        });
        if(isEmpty(cardNogArray) == '' && cardNogArray.length == 0){
        	//선택된 게시물이 없습니다.
        	alertMessage(i18nUt.get().t('page\\cc\\best:select_list_empty'));
        	return;
        }
        
        popCardArr = cardNogArray;
        
        
    	
//         guestTagPopupOpen = new modal({
//             content : '#cardMovePopup',
//             backdrop:true
//         });
//     	cardMovePopupOpenSet();
    },
    
	fnRollOverPop : function (url,target){
    	//팝업 내 상세 호출
    	dialImgInfo(url);
    	//dialog 팝업 호출
		dialog01212002Preview = new dialog({
			btn     : target,
			content :'#dialog-01212002'
		})	
    },
    
    fnRollOut : function(){
		if(dialog01212002Preview){
			dialog01212002Preview.close()			
		}	
    },
    
    // 노출/미노출 클릭(개별)
    cpContentsListIndividual : function(channelNo, cardNo, useYn, best_type_cd, game_no, best_no){
    	
    	var logArray = new Array();
        var bestNogArray = new Array();
        bestNogArray.push(parseInt(best_no));
        
        if(useYn === 'Y'){
        	
        	if($('#search_type').find('.form-key').val() == 'layout') {
        		
        		var logData = {
     				'log_type_cd' : 'BESTCARD_HIDE',
     				'game_no' : parseInt(game_no),
     				'reference_no' : parseInt(cardNo),
     				'params' : parseInt(cardNo),
     				'memo' : ''
     			}
        		logArray.push(logData);
        		gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_1'),function () {
	            	card.fnLayoutListUpdate('N', bestNogArray, logArray);
	            });  
        		
        	} else {
	        	//게시물을 BEST 게시물 목록에서 미노출 하시겠습니까? 
	            gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_1'),function () {
	            	card.cpContentsListUpdate( 'N', bestNogArray, channelNo, best_type_cd, logArray);
	            });        	
        	}
        	
        }else{
        	
        	if(best_type_cd == "-"){
        		//유저가 삭제하여 노출 상태로 변경이 불가합니다.
        		alertMessage(i18nUt.get().t('page\\cc\\best:best_list_alert2'))
        		return;
        	}
        	
        	var logData = {
    				'log_type_cd' : 'BESTCARD_SHOW',
    				'game_no' : parseInt(game_no),
    				'reference_no' : parseInt(cardNo),
    				'params' : parseInt(cardNo),
    				'memo' : ''
   			}
    		logArray.push(logData);
        	
        	if($('#search_type').find('.form-key').val() == 'layout') {
        		
           		gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_1'),function () {
   	            	card.fnLayoutListUpdate('Y', bestNogArray, logArray);
   	            });  
        		
        	} else {
	        	//게시물을 BEST 게시물 목록에서 노출 하시겠습니까?
	            gFnShowConfirmAlert2(i18nUt.get().t('page\\cc\\best:add2.best_list_alert_2'), function () {
	        		card.cpContentsListUpdate('Y', bestNogArray, channelNo, best_type_cd, logArray);                
	            });        	
        	}
        }
    },
    
    fnLayoutListUpdate: function (status, cardNogArray, logArray) {
    	
    	var reqData = {
   	    	'status' : status,
   			'page_layout_item_nos' : cardNogArray,
       	}
   		var sendUrl =  '/best/cafe/UpdatePageLayoutItemList';
   		var postData = {
   			'reqData' : reqData,
   			'logData' : logArray
   		}
   		sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
   			if(res.return_code == 0) {
	    		getPageLayoutItem(currentPage);
   			}
    	})
    	
    },
    // 노출/미노출 버튼 클릭(array)
    cpContentsListUpdate : function( status, bestNogArray, channelNo, bestTypeCd, logArray)  {
        var sendUrl = '';
        if(status == 'Y'){
        	
        	var sendUrl = "/best/cafe/BestCardList";		
            var postData = {
    				'channel_no':$('#search_page .form-key').val(),
    				'board_no':$('#search_menu_no .form-key').val(),
               		'use_yn':'Y',
               		'size':10,
               		'page':1
                };
            sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){ 
            	if(res.return_code == 0){
            		var totalCnt = res.context.total_count + bestNogArray.length;
            		if(totalCnt > 10){
            			// Live ON 상태의 BEST 게시물은 공지 포함 최대 10개까지 등록 가능합니다.
            			alertMessage(i18nUt.get().t('page\\cc\\best:best_list_alert4'));
            			return;
            		}else{
            			var sendUrl = '/best/cafe/UpdateOnBestCard';	
                        var reqData = {
                                'best_no_list' : bestNogArray,
                                'channel_no' : parseInt($('#search_page .form-key').val()),
                                'board_no' : parseInt($('#search_menu_no .form-key').val()),
                                'best_type_cd' : bestTypeCd || '1'
                            };
                        
                        var postData = {
                        		'reqData' : reqData, 
                        		'logData' : logArray
                        }
                        
                        //버튼일경우 best_type_cd를 안보낸다.
                        if(bestTypeCd == -1){
                        	delete postData.best_type_cd;	
                        }
                        
                        sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
                            if(res.return_code != "891"){
                            	
                            	if($('#search_type').find('.form-key').val() == 'board') {
                            		getBoardSubmenuList(currentPage);
                            	} else {
	                                getList(currentPage);
                            	}
                			}
                        });
            		}
            	}
            });

        	
        	
        }else{
        	var sendUrl = '/best/cafe/UpdateOffBestCard';
            var reqData = {
                    "best_no_list" : bestNogArray
                };
            //버튼일경우 best_type_cd를 안보낸다.
            if(bestTypeCd == -1){
            	delete reqData.best_type_cd;	
            }
            
            var postData = {
            		'reqData' : reqData,
            		'logData' : logArray
            }
            
            sendAjaxJsonSync('POST', sendUrl, JSON.stringify(postData), function(res){
                if(res.return_code != "891"){
                	if($('#search_type').find('.form-key').val() == 'board') {
                		getBoardSubmenuList(currentPage);
                	} else {
                    	getList(currentPage);
                	}
    			}
            });
        }
    },

	setClickBoardType : function(data, content, key) {
 		var str = key.split(',');
		var arrKey = '';
		for (var i = 0; i < str.length; i++) {
			arrKey += data[str[i]] + ',';
		}
		arrKey = arrKey.substr(0, arrKey.length-1);

		var result = '';

		if (data.card_type == 'CARD') {
			result = content;
		} else {
			var goAddr = card.getGoBoardTypeListAddr(arrKey);
			var result = '<a href=\"' + goAddr + '\" target=\"_blank\">' + content + '</a>';
		}
		return result;
	},

	getGoBoardTypeListAddr : function(cardNo) {
		boardGetData.search_type = "parent_card_no";
		boardGetData.search_text = cardNo;

		// 새창에서 화면 진입 시, 1페이지로 SET
		boardGetData.current_page = 1;

		// 페이지당 표시할 수 있는 게시물 개수 10개 고정
		boardGetData.list_view = 10;
		boardGetData.list_size = boardGetData.list_view;

		var sendUrl = "/cc/card/boardTypeList/page";
		var sendParam = "";
		$.each(boardGetData, function(key, value) {
			if (!value) {
			} else {
				sendParam += "&" + key + "=" + value;
			}
		});

		return sendUrl + gFnGetUrlParamAll(boardGetData);
	}

}
</script>

</body>
</html>