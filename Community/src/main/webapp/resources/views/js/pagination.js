/**
 *  페이징 모듈
 * @param totalCount    총 리스트 갯수
 * @param currentPage   현재 페이지
 * @param pageSize      한페이지 보여질 목록 갯수
 * @param listSize      한번에 보여질 페이징 갯수
 * @param linkFunction  클릭 function
 * @param targetDiv     만들어징 페이징이 적용될 div ID
 * @returns {*}
 */

function makePageNavigationBar(totalCount, currentPage, pageSize, listSize, linkFunction, targetDiv, pageBarOnOff) {
    var DEFAULT_LIST_SIZE = 10;
    var DEFAULT_PAGE_SIZE = 10;
    var DEFAULT_CURRENT_PAGE = 1;
    var linkFunctionName = 'javascript: '+linkFunction;
    
    console.log(linkFunctionName);
    
    if(!totalCount || totalCount < 1){
        targetDiv = typeof targetDiv == "string" ? document.getElementById(targetDiv) : targetDiv;
        if (targetDiv) {
            var tagStr = "";
            if(!pageBarOnOff) {
                tagStr += '<nav><ul class="pagination">';
                tagStr += '<li><button type="button" class="first" aria-label="Frist" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
                tagStr += '<li><button type="button"class="prev" aria-label="Previous" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
                tagStr += '<li class="active"><a href="#">1</a></li>';
                tagStr += '<li><button type="button"class="next btn btn-default" aria-label="Next" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
                tagStr += '<li><button type="button" class="end btn btn-default" aria-label="End" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
                tagStr += '</ul></nav>';
            }

            targetDiv.innerHTML = tagStr;
            return true;
        }
        else{
            return '';
        }
    }
    if( !pageSize ){      pageSize = DEFAULT_PAGE_SIZE;}
    if( !listSize ){      listSize = DEFAULT_LIST_SIZE;}
    if( !currentPage ){      currentPage = DEFAULT_CURRENT_PAGE;}
    var totalPageCount = 0;
    if(pageSize >= totalCount) {
        totalPageCount = 1;
    } else {
        totalPageCount = Math.ceil( totalCount/pageSize ) ;
    }
    var startPage = currentPage - Math.floor((currentPage-1)%listSize);
    var endPage = startPage + listSize -1;
    if(endPage > totalPageCount){
        endPage = totalPageCount;
    }

    var tagStr = '';
    if(totalPageCount > 0) {
        tagStr += '<nav><ul class="pagination">';
        if( currentPage > 1 ){
            tagStr += '<li><a href="#" onclick="'+linkFunctionName+'(1)" class="first" aria-label="Frist"><span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="first btn btn-default" aria-label="Frist" disabled="disabled"><span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span></button></li>';
        }

        if(currentPage > 10){
            var newPage = 1;
            if(currentPage*1 >10){
                newPage = currentPage*1 - 10;
            }else{
                newPage = 1
            }
            tagStr += '<li><a href="javascript:void(0);" class="prev" aria-label="Previous" onclick="'+linkFunctionName+'('+newPage*1+')"><span aria-hidden="true"><i class="fas fa-angle-left"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="prev btn btn-default" aria-label="Previous" disabled="disabled"><span aria-hidden="true"><i class="fas fa-angle-left"></i></span></button></li>';
        }

        for(var i = startPage; i <= endPage ; i++){
            if(i == currentPage){
                tagStr += '<li class="active"><a href="#">'+i+'</a></li>';
            }else{
                tagStr += '<li><a href="#" onclick="'+linkFunctionName+'('+i+')">'+i+'</a></li>';
            }
        }

        if(currentPage*1+10 <= totalPageCount*1){
            var newPage = 1;
            if(totalPageCount > currentPage*1 + 10  ){
                newPage = currentPage*1 + 10;
            }else{
                newPage = totalPageCount;
            }
            tagStr += '<li><a href="javascript:void(0);" class="next" aria-label="Next"  onclick="'+linkFunctionName+'('+newPage*1+')"><span aria-hidden="true"><i class="fas fa-angle-right"></i></span></a></li>';
        }else{
            if(totalPageCount > endPage){
                tagStr += '<li><a href="javascript:void(0);" class="next" aria-label="Next"  onclick="'+linkFunctionName+'('+totalPageCount*1+')"><span aria-hidden="true"><i class="fas fa-angle-right"></i></span></a></li>';
            }else{
                tagStr += '<li><button type="button" class="next btn btn-default" aria-label="Next" disabled="disabled"><span aria-hidden="true"><i class="fas fa-angle-right"></i></span></button></li>';
            }
        }

        if(currentPage < totalPageCount ){
            tagStr += '<li><a href="#" class="end" aria-label="End" onclick="'+linkFunctionName+'('+(totalPageCount)+')"><span aria-hidden="true"><i class="fas fa-angle-double-right"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="end btn btn-default" aria-label="End" disabled="disabled"><span aria-hidden="true"><i class="fas fa-angle-double-right"></i></span></button></li>';
        }
        tagStr += '</ul></nav>';
    }
    targetDiv = typeof targetDiv == "string" ? document.getElementById(targetDiv) : targetDiv;

    if (targetDiv) {
        targetDiv.innerHTML = tagStr;
        return true;
    }
    else{
        return tagStr;
    }
}