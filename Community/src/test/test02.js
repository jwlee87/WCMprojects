/**
 *  TableList Add Data
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function newTableHTML(columns, data, noDataMsg, divId){

    //column 디폴트값
    var defaultColumns = {
        colgroup : ''                   // 세로 크기 % 정의
        , headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true (datafunckey 값이 있으면 해당 값 name 설정)
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'  				// 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , rowNumber : false             //row number컬럼 (datafunckey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , datavalue : ''                // 데이터 내 value값 추가
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text클래스 div 제거
        , otherDataCell : false			// image 나 다른 형식의 데이터를 사용할경우 cell-data, cell-text클래스 div 제거
        , viewResourceId : null
        , paramResources : null
    };
    //noneData 디폴트값
    var defaultNoneData = {
        string: ''              // 데이터가 없을 때 string
        , addAttr: ''           // add attr
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //noneData 값 재셋팅
    var setNonData = new Object();
    if(noneData) {
        setNonData = $.extend({}, defaultNoneData, noneData);
    }else{
        setNonData = defaultNoneData;
    }

    //테이블 html 생성성
    var result = '';
    var resultCol = '';
    result += '<div class="table table-default table-striped">';
    result += '<div class="table-group rows-collapse';
    //group 생성
    resultCol += '<div class="colgroup">';
    $(setColumns).each(function (key, value) {

        /*if (!this.ishidden) {*/
    		resultCol += '<div class="col" style="width:'+this.colgroup+';"></div>';
        /*}*/
            if (this.ishidden) {
            	result += ' rows-' + (key+1);
            }
    });
    result += '">';
    result += resultCol;

    result += '</div>';
    //thead 생성
    result += '<div class="cell-group cell-group-header">';
    $(setColumns).each(function (key, value) {
       /* if (!this.ishidden) {*/
            if(this.headertext == 'allCheck'){
                result +='<div class="cell">';
                result +='<div class="cell-data">';
                result +='<div class="cell-form">';
                result +='<label class="checkbox">';
                result +='<input type="checkbox" class="check-input" name="all_'+this.datafunckey+'">';
                result +='<span class="check-effect">';
                result +='<span class="check-roundbox"></span>';
                result +='</span>';
                result +='</label>';
                result +='</div>';
                result +='</div>';
                result +='</div>';
            }else{
                result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                result += this.headertext;
                result += '</div></div></div>';
            }
       /* }*/
    });
    result += '</div>';
    //tbody 생성
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            result += '<div class="cell-group cell-group-body" '+value.addAttr+'>';
            $(setColumns).each(function () {
                if (this.datatype === 'count') {
                    result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                    result += index+1;
                    result += '</div></div></div>';
                /*}else if (value.hasOwnProperty(this.datafield)) {*/
                }else {
                   /* if (!this.ishidden) {*/
                    if (this.datatype === 'elipse') {
                        result += '<div class="cell clamp"><div class="cell-data">';
                    }else{
                        result += '<div class="cell">';
                        if(!this.otherDataCell){
                        	result += '<div class="cell-data">';
                        }
                    }
                    
                        if(!this.othercell && !this.otherDataCell){
	                        result += '<div class="cell-text"';
	                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
	                        	result += ' data-value="'+value[this.datavalue]+'"';
	                        }
                        }
                        
                        if(this.otherDataCell) {
                        	result += '<div class="cell-text"';
	                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
	                        	result += ' data-value="'+value[this.datavalue]+'"';
	                        }
                        }

                        if(!this.rowNumber){
	                        var content = value[this.datafield];
	                        //content가 없을 경우
	                        if(content === null){
	                            content = this.datanone;
	                        } else if(content === undefined){
	                        	content = this.datanone;
	                        }

	                        //function이 있을 경우(가공)
	                        if (this.datafunc  !== null) {
	                        	if(this.viewResourceId != null){
	                        		if(checkAuth(this.viewResourceId, this.paramResources)){
	                        		      if (this.clickfunc  !== null) {
	                        		    	  if(this.datafunckey !== null){
	      	                                    	content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	      	                                	}else{
	      	                                		content = this.datafunc(value,content,this.clickfunc);
	      	                                	}
		      	                           	}else{
		      	                                if(this.datafunckey !== null){
		      	                                	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
		      	                                		content = this.datafunc(value,content,this.datafunckey,gTzOffset);
		      	                                	} else {
		      	                                		content = this.datafunc(value,content,this.datafunckey);
		      	                                	}
		      	                                }else{
		      	                                    content = this.datafunc(value,content);
		      	                                }
		      	                            }
	                        		}else{
	                        			content = '';
	                        		}
	                      
	                        	}else{
	                        		 if (this.clickfunc  !== null) {
	 	                                if(this.datafunckey !== null){

	 	                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	 	                                }else{
	 	                                    content = this.datafunc(value,content,this.clickfunc);
	 	                                }
	 	                            }else{
	 	                                if(this.datafunckey !== null){
	 	                                	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
	 	                                		content = this.datafunc(value,content,this.datafunckey,gTzOffset);
	 	                                	} else {
	 	                                		content = this.datafunc(value,content,this.datafunckey);
	 	                                	}
	 	                                }else{
	 	                                    content = this.datafunc(value,content);
	 	                                }
	 	                            }
	                        	}
	                        }//

	                        if(this.ishidden && this.datafunckey !== null){
	                        	result += ' name="'+this.datafunckey+'"';
	                        }
	                        if(!this.othercell){
	                        	result +='>';
	                        }
	                        result += content;
                        } else {
                        	result +='">';
                        	var rowSet = this.datafunckey.split(',');
                        	if(rowSet[2] == 'A'){
                        		result += ((rowSet[0]-1) * rowSet[1]) + (index+1);
                        	}else{
                        		result += rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                        	}
                        }
                        if(!this.othercell){
                        	result += '</div>';
                        }
                    	result += '</div>';
	                	 if(!this.otherDataCell){
	                     	result += '</div>';
	                     }
                  /*  }*/
                }
            });
            result += '</div>';
        });

        result += '</div>';
        result += '</div>';
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.
    	if(typeof text== "object"){
    		text = noDataMsg.string;
    	}
    	result += '</div>';

    	result += '<div class="table-group">';
    	result += '		<div class="cell-group cell-empty">';
    	result += '			<div class="cell cell-data">';
    	result += '				<span class="cell-text">'+text+'</span>';
    	result += '			</div>';
    	result += '		</div>';
    	result += '	</div>';

    }

    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}

/**
 *  TableList Add Data
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function newPopTableHTML(columns, data, noDataMsg, divId){

    //column 디폴트값
    var defaultColumns = {
        colgroup : ''                   // 세로 크기 % 정의
        , headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true (datafunckey 값이 있으면 해당 값 name 설정)
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'  				// 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , rowNumber : false             //row number컬럼 (datafunckey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , datavalue : ''                // 데이터 내 value값 추가
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text클래스 div 제거
        , otherDataCell : false			// image 나 다른 형식의 데이터를 사용할경우 cell-data, cell-text클래스 div 제거
        , viewResourceId : null
        , paramResources : null
    };
    //noneData 디폴트값
    var defaultNoneData = {
        string: ''              // 데이터가 없을 때 string
        , addAttr: ''           // add attr
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //noneData 값 재셋팅
    var setNonData = new Object();
    if(noneData) {
        setNonData = $.extend({}, defaultNoneData, noneData);
    }else{
        setNonData = defaultNoneData;
    }

    //테이블 html 생성성
    var result = '';
    var resultCol = '';
    result += '<div class="table table-default table-striped">';
    result += '<div style="min-width:1400px" class="table-group rows-collapse';
    //group 생성
    resultCol += '<div class="colgroup">';
    $(setColumns).each(function (key, value) {

        /*if (!this.ishidden) {*/
    		resultCol += '<div class="col" style="width:'+this.colgroup+';"></div>';
        /*}*/
            if (this.ishidden) {
            	result += ' rows-' + (key+1);
            }
    });
    result += '">';
    result += resultCol;

    result += '</div>';
    //thead 생성
    result += '<div class="cell-group cell-group-header">';
    $(setColumns).each(function (key, value) {
       /* if (!this.ishidden) {*/
            if(this.headertext == 'allCheck'){
                result +='<div class="cell">';
                result +='<div class="cell-data">';
                result +='<div class="cell-form">';
                result +='<label class="checkbox">';
                result +='<input type="checkbox" class="check-input" name="all_'+this.datafunckey+'">';
                result +='<span class="check-effect">';
                result +='<span class="check-roundbox"></span>';
                result +='</span>';
                result +='</label>';
                result +='</div>';
                result +='</div>';
                result +='</div>';
            }else{
                result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                result += this.headertext;
                result += '</div></div></div>';
            }
       /* }*/
    });
    result += '</div>';
    //tbody 생성
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            result += '<div class="cell-group cell-group-body" '+value.addAttr+'>';
            $(setColumns).each(function () {
                if (this.datatype === 'count') {
                    result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                    result += index+1;
                    result += '</div></div></div>';
                /*}else if (value.hasOwnProperty(this.datafield)) {*/
                }else {
                   /* if (!this.ishidden) {*/
                    if (this.datatype === 'elipse') {
                        result += '<div class="cell clamp"><div class="cell-data">';
                    }else{
                        result += '<div class="cell">';
                        if(!this.otherDataCell){
                        	result += '<div class="cell-data">';
                        }
                    }
                    
                        if(!this.othercell && !this.otherDataCell){
	                        result += '<div class="cell-text"';
	                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
	                        	result += ' data-value="'+value[this.datavalue]+'"';
	                        }
                        }
                        
                        if(this.otherDataCell) {
                        	result += '<div class="cell-text"';
	                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
	                        	result += ' data-value="'+value[this.datavalue]+'"';
	                        }
                        }

                        if(!this.rowNumber){
	                        var content = value[this.datafield];
	                        //content가 없을 경우
	                        if(content === null){
	                            content = this.datanone;
	                        } else if(content === undefined){
	                        	content = this.datanone;
	                        }

	                        //function이 있을 경우(가공)
	                        if (this.datafunc  !== null) {
	                        	if(this.viewResourceId != null){
	                        		if(checkAuth(this.viewResourceId, this.paramResources)){
	                        		      if (this.clickfunc  !== null) {
	                        		    	  if(this.datafunckey !== null){
	      	                                    	content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	      	                                	}else{
	      	                                		content = this.datafunc(value,content,this.clickfunc);
	      	                                	}
		      	                           	}else{
		      	                                if(this.datafunckey !== null){
		      	                                	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
		      	                                		content = this.datafunc(value,content,this.datafunckey,gTzOffset);
		      	                                	} else {
		      	                                		content = this.datafunc(value,content,this.datafunckey);
		      	                                	}
		      	                                }else{
		      	                                    content = this.datafunc(value,content);
		      	                                }
		      	                            }
	                        		}else{
	                        			content = '';
	                        		}
	                      
	                        	}else{
	                        		 if (this.clickfunc  !== null) {
	 	                                if(this.datafunckey !== null){

	 	                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	 	                                }else{
	 	                                    content = this.datafunc(value,content,this.clickfunc);
	 	                                }
	 	                            }else{
	 	                                if(this.datafunckey !== null){
	 	                                	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
	 	                                		content = this.datafunc(value,content,this.datafunckey,gTzOffset);
	 	                                	} else {
	 	                                		content = this.datafunc(value,content,this.datafunckey);
	 	                                	}
	 	                                }else{
	 	                                    content = this.datafunc(value,content);
	 	                                }
	 	                            }
	                        	}
	                        }//

	                        if(this.ishidden && this.datafunckey !== null){
	                        	result += ' name="'+this.datafunckey+'"';
	                        }
	                        if(!this.othercell){
	                        	result +='>';
	                        }
	                        result += content;
                        } else {
                        	result +='">';
                        	var rowSet = this.datafunckey.split(',');
                        	if(rowSet[2] == 'A'){
                        		result += ((rowSet[0]-1) * rowSet[1]) + (index+1);
                        	}else{
                        		result += rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                        	}
                        }
                        if(!this.othercell){
                        	result += '</div>';
                        }
                    	result += '</div>';
	                	 if(!this.otherDataCell){
	                     	result += '</div>';
	                     }
                  /*  }*/
                }
            });
            result += '</div>';
        });

        result += '</div>';
        result += '</div>';
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.
    	if(typeof text== "object"){
    		text = noDataMsg.string;
    	}
    	result += '</div>';

    	result += '<div class="table-group" style="min-width:1400px">';
    	result += '		<div class="cell-group cell-empty">';
    	result += '			<div class="cell cell-data">';
    	result += '				<span class="cell-text">'+text+'</span>';
    	result += '			</div>';
    	result += '		</div>';
    	result += '	</div>';

    }

    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}

function newTableScrollHTML_X(columns, data, noDataMsg, divId){

    //column 디폴트값
    var defaultColumns = {
        colgroup : ''                   // 세로 크기 % 정의
        , headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true (datafunckey 값이 있으면 해당 값 name 설정)
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'  				// 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , rowNumber : false             //row number컬럼 (datafunckey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , datavalue : ''                // 데이터 내 value값 추가
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text클래스 div 제거
    };
    //noneData 디폴트값
    var defaultNoneData = {
        string: ''              // 데이터가 없을 때 string
        , addAttr: ''           // add attr
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //noneData 값 재셋팅
    var setNonData = new Object();
    if(noneData) {
        setNonData = $.extend({}, defaultNoneData, noneData);
    }else{
        setNonData = defaultNoneData;
    }

    //테이블 html 생성성
    var result = '';
    var resultCol = '';
    result += '<div class="table table-default table-striped">';
    result += '<div class="table-scroll scroll-x" area-scroll="true"  area-scroll-x="true" area-scroll-y="false"  area-scroll-addclass="content-scroll" ';
    //group 생성
    resultCol += '<div class="table-group" style="min-width:3500px"><div class="colgroup">';
    $(setColumns).each(function (key, value) {

        /*if (!this.ishidden) {*/
    		resultCol += '<div class="col" style="width:'+this.colgroup+';"></div>';
        /*}*/
            if (this.ishidden) {
            	result += ' rows-' + (key+1);
            }
    });
    result += '">';
    result += resultCol;

    result += '</div>';
    //thead 생성
    result += '<div class="cell-group cell-group-header">';
    $(setColumns).each(function (key, value) {
       /* if (!this.ishidden) {*/
            if(this.headertext == 'allCheck'){
                result +='<div class="cell">';
                result +='<div class="cell-data">';
                result +='<div class="cell-form">';
                result +='<label class="checkbox">';
                result +='<input type="checkbox" class="check-input" name="all_'+this.datafunckey+'">';
                result +='<span class="check-effect">';
                result +='<span class="check-roundbox"></span>';
                result +='</span>';
                result +='</label>';
                result +='</div>';
                result +='</div>';
                result +='</div>';
            }else{
                result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                result += this.headertext;
                result += '</div></div></div>';
            }
       /* }*/
    });
    result += '</div>';
    //tbody 생성
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            result += '<div class="cell-group cell-group-body" '+value.addAttr+'>';
            $(setColumns).each(function () {
                if (this.datatype === 'count') {
                    result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                    result += index+1;
                    result += '</div></div></div>';
                /*}else if (value.hasOwnProperty(this.datafield)) {*/
                }else {
                   /* if (!this.ishidden) {*/
                    if (this.datatype === 'elipse') {
                        result += '<div class="cell clamp"><div class="cell-data">';
                    }else{
                        result += '<div class="cell"><div class="cell-data">';
                    }
                        if(!this.othercell){
	                        result += '<div class="cell-text"';
	                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
	                        	result += ' data-value="'+value[this.datavalue]+'"';
	                        }
                        }

                        if(!this.rowNumber){
	                        var content = value[this.datafield];
	                        //content가 없을 경우
	                        if(content === null){
	                            content = this.datanone;
	                        } else if(content === undefined){
	                        	content = this.datanone;
	                        }

	                        //function이 있을 경우(가공)
	                        if (this.datafunc  !== null) {
	                            if (this.clickfunc  !== null) {
	                                if(this.datafunckey !== null){

	                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	                                }else{
	                                    content = this.datafunc(value,content,this.clickfunc);
	                                }
	                            }else{
	                                if(this.datafunckey !== null){
	                                	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
	                                		content = this.datafunc(value,content,this.datafunckey,gTzOffset);
	                                	} else {
	                                		content = this.datafunc(value,content,this.datafunckey);
	                                	}
	                                }else{
	                                    content = this.datafunc(value,content);
	                                }
	                            }
	                        }

	                        if(this.ishidden && this.datafunckey !== null){
	                        	result += ' name="'+this.datafunckey+'"';
	                        }
	                        if(!this.othercell){
	                        	result +='>';
	                        }
	                        result += content;
                        } else {
                        	result +='">';
                        	var rowSet = this.datafunckey.split(',');
                        	if(rowSet[2] == 'A'){
                        		result += ((rowSet[0]-1) * rowSet[1]) + (index+1);
                        	}else{
                        		result += rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                        	}
                        }
                        if(!this.othercell){
                        	result += '</div>';
                        }
                    	result += '</div></div>';
                  /*  }*/
                }
            });
            result += '</div>';
        });

        result += '</div></div>';
        result += '</div>';
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.
    	if(typeof text== "object"){
    		text = noDataMsg.string;
    	}

    	result += '</div>';

    	result += '<div class="table-group">';
    	result += '		<div class="cell-group cell-empty">';
    	result += '			<div class="cell cell-data">';
    	result += '				<span class="cell-text">'+text+'</span>';
    	result += '			</div>';
    	result += '		</div>';
    	result += '	</div>';

    }

    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }

    new backoffice();    
}

/**
 *  TableList Add Data
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function addTableHTML(columns, data, noDataMsg, divId){
    //column 디폴트값
    var defaultColumns = {
        colgroup : ''                   // 세로 크기 % 정의
        , headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true (datafunckey 값이 있으면 해당 값 name 설정)
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'  // 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , rowNumber : false             //row number컬럼 (datafunckey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , datavalue : ''                // 데이터 내 value값 추가
    };
    //noneData 디폴트값
    var defaultNoneData = {
        string: ''              // 데이터가 없을 때 string
        , addAttr: ''           // add attr
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //noneData 값 재셋팅
    var setNonData = new Object();
    if(noneData) {
        setNonData = $.extend({}, defaultNoneData, noneData);
    }else{
        setNonData = defaultNoneData;
    }

    var result = '';
    //tbody 생성
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            result += '<div class="cell-group cell-group-body" '+value.addAttr+'>';
            $(setColumns).each(function () {
                if (this.datatype === 'count') {
                    result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                    result += index+1;
                    result += '</div></div></div>';
                /*}else if (value.hasOwnProperty(this.datafield)) {*/
                } else {
                   /* if (!this.ishidden) {*/
                        result += '<div class="cell"><div class="cell-data"><div class="cell-text"';
                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
                        	result += ' data-value="'+value[this.datavalue]+'"';
                        }

                        if(!this.rowNumber){
	                        var content = value[this.datafield];
	                        //content가 없을 경우
	                        if(content === null){
	                            content = this.datanone;
	                        } else if(content === undefined){
	                        	content = '';
	                        }

	                        //function이 있을 경우(가공)
	                        if (this.datafunc  !== null) {
                                if (this.clickfunc  !== null) {
	                                if(this.datafunckey !== null){
	                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	                                }else{
	                                    content = this.datafunc(value,content,this.clickfunc);
	                                }
	                            }else{
	                                if(this.datafunckey !== null){
	                                    content = this.datafunc(value,content,this.datafunckey);
	                                }else{
	                                    content = this.datafunc(value,content);
	                                }
	                            }
	                        }

	                        if(this.ishidden && this.datafunckey !== null){
	                        	result += ' name="'+this.datafunckey+'"';
	                        }
	                        result +='>';
	                        result += content;
                        } else {
                        	result +='">';
                        	var rowSet = this.datafunckey.split(',');
                        	if(rowSet[2] == 'A'){
                        		result += ((rowSet[0]-1) * rowSet[1]) + (index+1);
                        	}else{
                        		result += rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                        	}
                        }
                        result += '</div></div></div>';
                  /*  }*/
                }
            });
            result += '</div>';
        });


	    if(divId !== undefined && divId !== null && divId !== ""){
	        $('#'+divId).find(".table-group").append(result);
	    }else{
	        return result;
	    }
    }
}

/**
 *  TableList Add Data (스크롤생성)
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function newTableScrollHTML(columns, data, noDataMsg, divId, size){
    //column 디폴트값
    var defaultColumns = {
        colgroup : ''                   // 세로 크기 % 정의
        , headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true (datafunckey 값이 있으면 해당 값 name 설정)
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'  // 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , rowNumber : false             //row number컬럼 (datafunckey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , datavalue : ''                // 데이터 내 value값 추가
    	, viewResourceId : null
        , paramResources : null
    };
    
    //noneData 디폴트값
    var defaultNoneData = {
        string: ''              // 데이터가 없을 때 string
        , addAttr: ''           // add attr
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //noneData 값 재셋팅
    var setNonData = new Object();
    if(noneData) {
        setNonData = $.extend({}, defaultNoneData, noneData);
    }else{
        setNonData = defaultNoneData;
    }

    //테이블 html 생성성
    var result = '';
    var resultCol = '';
    result += '<div class="table table-default table-striped">';
    result += '<div class="table-group rows-collapse';
    //group 생성
    resultCol += '<div class="colgroup">';
    $(setColumns).each(function (key, value) {

        /*if (!this.ishidden) {*/
    		resultCol += '<div class="col" style="width:'+this.colgroup+';"></div>';
        /*}*/
            if (this.ishidden) {
            	result += ' rows-' + (key+1);
            }
    });
    result += '">';
    result += resultCol;

    result += '</div>';
    //thead 생성
    result += '<div class="cell-group cell-group-header">';
    $(setColumns).each(function (key, value) {
       /* if (!this.ishidden) {*/
            if(this.headertext == 'allCheck'){
                result +='<div class="cell">';
                result +='<div class="cell-data">';
                result +='<div class="cell-form">';
                result +='<label class="checkbox">';
                result +='<input type="checkbox" class="check-input" name="all_'+this.datafunckey+'">';
                result +='<span class="check-effect">';
                result +='<span class="check-roundbox"></span>';
                result +='</span>';
                result +='</label>';
                result +='</div>';
                result +='</div>';
                result +='</div>';
            }else{
                result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                result += this.headertext;
                result += '</div></div></div>';
            }
       /* }*/
    });
    result += '</div>';
    result += '</div>';

    if(size == null || size == undefined || size == ''){
    	size = 450;
    }
    result += '<div class="table-scroll scroll-y" area-scroll="true" area-scroll-addclass="content-scroll" style="height:'+size+'px;">';
    result += '<div class="table-group rows-collapse';
    //group 생성
    resultCol = '';
    resultCol += '<div class="colgroup">';
    $(setColumns).each(function (key, value) {

        /*if (!this.ishidden) {*/
    		resultCol += '<div class="col" style="width:'+this.colgroup+';"></div>';
        /*}*/
            if (this.ishidden) {
            	result += ' rows-' + (key+1);
            }
    });
    result += '">';
    result += resultCol;

    result += '</div>';

    //tbody 생성
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            result += '<div class="cell-group cell-group-body" '+value.addAttr+'>';
            $(setColumns).each(function () {
                if (this.datatype === 'count') {
                    result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                    result += index+1;
                    result += '</div></div></div>';
                /*}else if (value.hasOwnProperty(this.datafield)) {*/
                }else {
                   /* if (!this.ishidden) {*/
	                    if (this.datatype === 'elipse') {
	                        result += '<div class="cell clamp"><div class="cell-data">';
	                    }else{
	                        result += '<div class="cell"><div class="cell-data">';
	                    }                	
                        result += '<div class="cell-text"';
                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
                        	result += ' data-value="'+value[this.datavalue]+'"';
                        }

                        if(!this.rowNumber){
	                        var content = value[this.datafield];
	                        //content가 없을 경우
	                        if(content === null){
	                            content = this.datanone;
	                        } else if(content === undefined){
	                        	content = '';
	                        }

	                        //function이 있을 경우(가공)
	                        if (this.datafunc  !== null) {
	                            if (this.clickfunc  !== null) {
	                            	if(this.viewResourceId != null){
	                            		if(checkAuth(this.viewResourceId, this.paramResources)){
	                            			if(this.datafunckey !== null){
	       	                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	       	                                }else{
	       	                                    content = this.datafunc(value,content,this.clickfunc);
	       	                                }
	                            		}
	                            	}else{
	                            		if(this.datafunckey !== null){
	   	                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
	   	                                }else{
	   	                                    content = this.datafunc(value,content,this.clickfunc);
	   	                                }
	                            	}
	                             
	                            }else{
	                                if(this.datafunckey !== null){
	                                    content = this.datafunc(value,content,this.datafunckey);
	                                }else{
	                                    content = this.datafunc(value,content);
	                                }
	                            }
	                        }

	                        if(this.ishidden && this.datafunckey !== null){
	                        	result += ' name="'+this.datafunckey+'"';
	                        }
	                        result +='>';
	                        result += content;
                        } else {
                        	result +='">';
                        	var rowSet = this.datafunckey.split(',');
                        	if(rowSet[2] == 'A'){
                        		result += ((rowSet[0]-1) * rowSet[1]) + (index+1);
                        	}else{
                        		result += rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                        	}
                        }
                        result += '</div></div></div>';
                  /*  }*/
                }
            });
            result += '</div>';
        });

        result += '</div>';
        result += '</div>';
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.
    	if(typeof text== "object"){
    		text = noDataMsg.string;
    	}

    	result += '</div>';

    	result += '<div class="table-group">';
    	result += '		<div class="cell-group cell-empty">';
    	result += '			<div class="cell cell-data">';
    	result += '				<span class="cell-text">'+text+'</span>';
    	result += '			</div>';
    	result += '		</div>';
    	result += '	</div>';

    }


    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}



/**
 *  TableList Add Data2 (스크롤생성)
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function newTableScrollHTML2(columns, data, noDataMsg, divId, modalHeight){
    //column 디폴트값
    var defaultColumns = {
        colgroup : ''                   // 세로 크기 % 정의
        , headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true (datafunckey 값이 있으면 해당 값 name 설정)
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'  // 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , rowNumber : false             //row number컬럼 (datafunckey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , datavalue : ''                // 데이터 내 value값 추가
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text클래스 div 제거
    };
    //noneData 디폴트값
    var defaultNoneData = {
        string: ''              // 데이터가 없을 때 string
        , addAttr: ''           // add attr
    };
    //modalHeight 디폴트값
    var defaultHeight = 500;
    if(modalHeight){
        defaultHeight = modalHeight;
    }

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //noneData 값 재셋팅
    var setNonData = new Object();
    if(noneData) {
        setNonData = $.extend({}, defaultNoneData, noneData);
    }else{
        setNonData = defaultNoneData;
    }

    //테이블 html 생성성
    var result = '';
    result += '<div class="table table-default table-striped">';
    result += '<div class="table-group">';
    //group 생성
    result += '<div class="colgroup">';
    $(setColumns).each(function (key, value) {
        result += '<div class="col" style="width:'+this.colgroup+';"></div>';
    });
    result += '</div>';
    //thead 생성
    result += '<div class="cell-group cell-group-header">';
    $(setColumns).each(function (key, value) {
        if(this.headertext == 'allCheck'){
            result +='<div class="cell">';
            result +='<div class="cell-data">';
            result +='<div class="cell-form">';
            result +='<label class="checkbox">';
            result +='<input type="checkbox" class="check-input" name="all_'+this.datafunckey+'">';
            result +='<span class="check-effect">';
            result +='<span class="check-roundbox"></span>';
            result +='</span>';
            result +='</label>';
            result +='</div>';
            result +='</div>';
            result +='</div>';
        }else{
            result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
            result += this.headertext;
            result += '</div></div></div>';
        }
    });
    result += '</div>';
    result += '</div>';
    result += '<div class="table-scroll dialog-scroll" area-scroll="true" area-resize="true" area-scroll-addclass="content-scroll"  area-scroll-multi="false" area-height="'+defaultHeight+'" style="height:'+defaultHeight+'px;">';
    result += '<div class="table-group">';
    //group 생성
    result += '<div class="colgroup">';
    $(setColumns).each(function (key, value) {
        result += '<div class="col" style="width:'+this.colgroup+';"></div>';
    });
    result += '</div>';
    //tbody 생성
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            result += '<div class="cell-group cell-group-body" '+value.addAttr+'>';
            $(setColumns).each(function () {
                if (this.datatype === 'count') {
                    result += '<div class="cell"><div class="cell-data"><div class="cell-text">';
                    result += index+1;
                    result += '</div></div></div>';
                    /*}else if (value.hasOwnProperty(this.datafield)) {*/
                }else {
                    /* if (!this.ishidden) {*/
                    result += '<div class="cell"><div class="cell-data">';
                    if(!this.othercell){
                        result += '<div class="cell-text"';
                        if(value[this.datavalue] !== null && value[this.datavalue] !== undefined){
                            result += ' data-value="'+value[this.datavalue]+'"';
                        }
                    }

                    if(!this.rowNumber){
                        var content = value[this.datafield];
                        //content가 없을 경우
                        if(content === null){
                            content = this.datanone;
                        } else if(content === undefined){
                            content = '';
                        }

                        //function이 있을 경우(가공)
                        if (this.datafunc  !== null) {
                            if (this.clickfunc  !== null) {
                                if(this.datafunckey !== null){
                                    content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                                }else{
                                    content = this.datafunc(value,content,this.clickfunc);
                                }
                            }else{
                                if(this.datafunckey !== null){
                                    content = this.datafunc(value,content,this.datafunckey);
                                }else{
                                    content = this.datafunc(value,content);
                                }
                            }
                        }

                        if(this.ishidden && this.datafunckey !== null){
                            result += ' name="'+this.datafunckey+'"';
                        }
                        if(!this.othercell){
                            result +='>';
                        }
                        result += content;
                    } else {
                        result +='">';
                        var rowSet = this.datafunckey.split(',');
                        if(rowSet[2] == 'A'){
                            result += ((rowSet[0]-1) * rowSet[1]) + (index+1);
                        }else{
                            result += rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                        }
                    }
                    if(!this.othercell){
                        result += '</div>';
                    }
                    result += '</div></div>';
                    /*  }*/
                }
            });
            result += '</div>';
        });

        result += '</div>';
        result += '</div>';
    }else{

        result += '</div>';

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.
    	if(typeof text== "object"){
    		text = noDataMsg.string;
    	}

        result += '<div class="table-group">';
        result += '		<div class="cell-group cell-empty">';
        result += '			<div class="cell cell-data">';
        result += '				<span class="cell-text">'+text+'</span>';
        result += '			</div>';
        result += '		</div>';
        result += '	</div>';

    }
    result += '</div>';

    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}

/**
 *  TableList Add Data
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function newPanelHTML(columns, data, headLine, divId, noDataMsg){
    //column 디폴트값
    var defaultColumns = {
        headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-' // 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , onedata : false				// 테이블 중간 ROW 에 한 데이터만 있을경우 사용
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text클래스 div 제거
        , statusfunc : null             // 이벤트가 발생할 function
        , statusfunckey : null           // 데이터 key
    };
    //headLine
    var deafaultHeadLine = {
        headline : ''					// row number컬럼 사용안하고 시퀀스넘 별도로 사용할 경우
        , rowNumber : false				// row number컬럼
        , headlinekey : null			// row number컬럼 사용시 (headlinekey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , title : ''
        , titlefunc : null
        , titlekey : null
        , liveflag : null				// live_yn 데이터가 들어올 경우에만 버튼 생성
        , deletetitle : ''				// title이 있을 경우 버튼 생성 String
        , deletefunc : null				// function 있을 경우 활성화
        , deletekey : null
        , whiteLabel : null				// 화이트라벨 y로 구분
        , deleteOpt : null				// live_yn에 따라 삭제버튼 활성화
        , viewResourceId : null
        , paramResources : null
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //headline 값 재셋팅
    var setHeadLine = new Object();
    if(headLine) {
        setHeadLine = $.extend({}, deafaultHeadLine, headLine);
    }else{
        setHeadLine = deafaultHeadLine;
    }

    //페널 html 생성성
    var result = '';
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
        	 result += '<div class="row in-panel-form"><div class="panel panel-form">';
            $(setHeadLine).each(function () {
                result += '<div class="panel-heading">';

                result += '<h3 class="panel-title">';

                if(this.titlefunc){

                	var key = this.titlekey.split(',');
                	var titleData = "";
                	for(var i = 0; i < key.length;i++){
                		titleData += '\''+value[key[i]] + '\',';
                	}
                	titleData = titleData.substring(0,titleData.length-1);

                	result += '<a href="javascript:void(0);" onclick="'+this.titlefunc+'('+titleData+')'+'">';
                }

                if(this.rowNumber){
                	var rowSet = this.headlinekey.split(',');
                	var cont = "";
                	if(rowSet[2] == 'A'){
                		cont = ((rowSet[0]-1) * rowSet[1]) + (index+1);
                	}else{
                		cont = rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                	}
                	result += '['+cont+'] '+value[this.title]+'</a></h3>';
                }else{
                    if(this.headline != null && this.headline != undefined && this.headline != ''){
                    	result += '['+value[this.headline]+']'+value[this.title]+'</a></h3>';
                    }else{
                    	result += value[this.title]+'</a></h3>';
                    }
                }

                if(this.whiteLabel != null){
                	if(value[this.whiteLabel].toLowerCase() === 'y'){
                		result += '<div class="panel-label">';
                		result += '	<span class="tag tag-coolgrey"><span class="tag-text">W/L</span></span>';
                		result += '</div>';
                	}
                }

                if(this.liveflag != null || this.deletetitle){
                	result += '<div class="tools">';
                	// 라이브 버튼
                	if(this.liveflag == null) {

                	} else if(value[this.liveflag].toLowerCase() === 'y'){
	                    result += '     <div class="state">';
	                    result += '         <div class="lazbel label-state active">';
	                    result += '             <div class="label-text">LIVE ON</div>';
	                    result += '             <i class="icon icon-onoff"></i>';
	                    result += '         </div>';
	                    result += '     </div>';
	                } else if(value[this.liveflag].toLowerCase() === 'n'){
	                    result += '     <div class="state">';
	                    result += '         <div class="label label-state">';
	                    result += '             <div class="label-text">LIVE OFF</div>';
	                    result += '             <i class="icon icon-onoff"></i>';
	                    result += '         </div>';
	                    result += '     </div>';
	                } else if(value[this.liveflag].toLowerCase() === 's'){// EXPIRED 버튼
	                	result += '     <div class="state">';
	                	result += '         <div class="label label-state">';
	                	result += '             <div class="label-text">EXPIRED</div>';
	                	result += '             <i class="icon icon-onoff"></i>';
	                	result += '         </div>';
	                	result += '     </div>';
	                }
	                //삭제버튼
                	if(this.viewResourceId != null && checkAuth(this.viewResourceId, this.paramResources)){
                    	if(this.deletetitle != '' && this.deletefunc) {
            			var deletekeyTxt = "";
            			if(this.deletekey.match(',')){
            				var deleteArry = this.deletekey.split(',');
            				deleteArry.forEach(function (item){
            					deletekeyTxt += value[item] + '\',\'';
            				});
            				deletekeyTxt = deletekeyTxt.substring(0, deletekeyTxt.length -3);

            			}else{
            				deletekeyTxt = value[this.deletekey];
            			}

            			result += '     <div class="button">';

            			if(this.deleteOpt){
                    		if(value[this.deleteOpt].toLowerCase() === 'y'){
                    			result += '         <button class="btn btn-sm btn-default btn-min" disabled>';
                    		} else {
                    			result += '         <button class="btn btn-sm btn-default btn-min" onclick="'+this.deletefunc+'(\''+deletekeyTxt+'\',this)'+'">';
                    		}
                    	} else{
                    		result += '         <button class="btn btn-sm btn-default btn-min" onclick="'+this.deletefunc+'(\''+deletekeyTxt+'\',this)'+'">';
                    	}

            			result += '             <span class="btn-text">'+this.deletetitle+'</span>';
            			result += '         </button>';
            			result += '     </div>';

            		} else if (this.deletetitle != '') {
            			result += '     <div class="button">';
            			result += '         <button class="btn btn-sm btn-default btn-min" disabled>';
            			result += '             <span class="btn-text">'+this.deletetitle+'</span>';
            			result += '         </button>';
            			result += '     </div>';
            		}

                }
	                result += '</div>';
                }

                //push관리용 버튼 생성
                if(this.statusfunckey != null){
                	var statusKey = this.statusfunckey.split(',');
                	var returnKey = "";

                	$.each(statusKey,function(i,o){
                		returnKey += "'" +value[o] + "',";
                	});
                	returnKey = returnKey.substring(0,returnKey.length-1);
                	var txt = i18nUt.get().t('common:delete');//"삭제"
                	
                	result += '<div class="tools">';
					result += '		<div class="state">';
					if(value[statusKey[0]] == 'REGIST'){
						result += '			<div class="label label-state danger">';
						result += '				<div class="label-text">RESERVED</div>';
						result += '			</div>';

						txt = i18nUt.get().t('common:add_0629.cancel_send');//'발송취소'
					} else if(value[statusKey[0]] == 'CANCEL'){
						result += '			<div class="label label-state default">';
						result += '				<div class="label-text">CANCELED</div>';
						result += '			</div>';
					} else if(value[statusKey[0]] == 'COMPLETE'){
						result += '			<div class="label label-state success">';
						result += '				<div class="label-text">COMPLETE</div>';
						result += '			</div>';
					}
                
					
					result += '		</div>';
					result += '		<div class="button">';
					
					if(this.viewResourceId != null && checkAuth(this.viewResourceId, this.paramResources)){
    					result += '			<button type="button" class="btn btn-sm btn-default btn-min" onclick="'+this.statusfunc+'('+returnKey+')">';
    					result += '				<span class="btn-text">'+ txt +'</span>';
    					result += '			</button>';
                	}
					/*result += '			<button type="button" class="btn btn-sm btn-default btn-min" onclick="'+this.statusfunc+'('+returnKey+')">';
					result += '				<span class="btn-text">'+ txt +'</span>';
					result += '			</button>';*/
					
					result += '		</div>';
					result += '</div>';
                }




                result += '</div>';
            });
            result += '<div class="panel-body">';
            result += '     <div class="table table-form table-horizontal">';
            result += '         <div class="table-group">';
            result += '             <div class="colgroup">';
            result += '                 <div class="col" style="width:16.3%"></div>';
            result += '                 <div class="col" style="width:33.6%"></div>';
            result += '                 <div class="col" style="width:16.1%"></div>';
            result += '                 <div class="col" style="width:34.0%"></div>';
            result += '             </div>';
            var cnt = 0;
            $(setColumns).each(function () {
            	if(!this.onedata){
                    if(cnt % 2 === 0) result += '<div class="cell-group cell-group-body">';
                    result += '<div class="cell cell-header"><div class="cell-data"><div class="cell-text">'+this.headertext+'</div></div></div>';
                    result += '<div class="cell cell-body"><div class="cell-data">';
                    if(!this.othercell){
            			result += '<div class="cell-text">';
            		}

                    var content = value[this.datafield];
                    //content가 없을 경우
                    if(content === null || content === undefined){
                        content = this.datanone;
                    }
                    //function이 있을 경우(가공)
                    if (this.datafunc  !== null) {
                        if (this.clickfunc  !== null) {
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content,this.clickfunc);
                            }
                        }else{
                            if(this.datafunckey !== null){
                            	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
                            		content = this.datafunc(value,content,this.datafunckey, gTzOffset);
                            	} else {
                            		content = this.datafunc(value,content,this.datafunckey);
                            	}
                            }else{
                                content = this.datafunc(value,content);
                            }
                        }
                    }
                    result += content;
                    if(!this.othercell){
                    	result += '</div>';
                    }

                    result +='</div></div>';
                    if(cnt % 2 !== 0) result += '</div>';
                    cnt++;
            	}else{
            		result += '	</div>';
            		result += '	<div class="table-group">';
            		result += '		<div class="colgroup">';
            		result += '			<div class="col" style="width:16.3%"></div>';
            		result += '			<div class="col"></div>';
            		result += '		</div>';
            		result += '		<div class="cell-group cell-group-body">';
            		result += '			<div class="cell cell-header"><div class="cell-data"><div class="cell-text" >'+this.headertext+'</div></div></div>';
            		result += '			<div class="cell cell-body"><div class="cell-data">';
            		if(!this.othercell){
            			result += '<div class="cell-text">';
            		}

                    var content = value[this.datafield];
                    //content가 없을 경우
                    if(content === null){
                        content = this.datanone;
                    }
                    //function이 있을 경우(가공)
                    if (this.datafunc  !== null) {
                        if (this.clickfunc  !== null) {
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content,this.clickfunc);
                            }
                        }else{
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content);
                            }
                        }
                    }
                    result += content;
                    if(!this.othercell){
                    	result += '</div>';
                    }

            		result += '		</div></div></div>';
            		result += '	</div>';
            		result += '	<div class="table-group">';
            		result += '		<div class="colgroup">';
            		result += '			<div class="col" style="width:16.3%"></div>';
            		result += '			<div class="col" style="width:33.6%"></div>';
            		result += '			<div class="col" style="width:16.1%"></div>';
            		result += '			<div class="col" style="width:34.0%"></div>';
            		result += '		</div>';
            	}

            });
            result += '         </div>';
            result += '     </div>';
            result += '</div>';
            result += '</div></div>';
        });
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.

    	result += '<div class="table table-default table-striped">';
    	result += '		<div class="table-group">';
    	result += '			<div class="cell-group cell-empty">';
    	result += '				<div class="cell cell-data">';
    	result += '					<span class="cell-text">'+text+'</span>';
    	result += '				</div>';
    	result += '			</div>';
    	result += '		</div>';
    	result += '</div>';

    }

    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}

/**
 *  TableList Add Data2
 * @param colums        col별 thead 데이터
 * @param data          select 데이터
 * @param noDataString  데이터가 없을시 문구
 * @param divId         추가될 div
 * @param classAdd      table에 추가될 공통 class 및 css (table, thead, tbody, tfoot, tr)
 */
function newPanelHTML2(columns, data, headLine, divId, tzOffset, noDataMsg){
    //column 디폴트값
    var defaultColumns = {
        headertext : 'thead'            // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-'                // 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , databtw : ' '                 // 데이터 사이 str
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , onedata : false				// 한 ROW 에 한 데이터만 있을경우 사용
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text 있는 div 제거
    };
    //headLine
    var deafaultHeadLine = {
        headline : ''
        , title : ''
        , titlefunc : null
        , tiltekey : false
        , text : ''
        , livebtn : ''
        , rightbtntitle : ''
        , rightbtnfunc : null
        , rightbtnkey : null
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //headline 값 재셋팅
    var setHeadLine = new Object();
    if(headLine) {
        setHeadLine = $.extend({}, deafaultHeadLine, headLine);
    }else{
        setHeadLine = deafaultHeadLine;
    }
    //페널 html 생성성
    var result = '';
    if(data && data.length > 0) {
        $(data).each(function (index, value) {
            var headlineFlag = false;
            result += '<div class="row in-panel-form"><div class="panel panel-form">';
            $(setHeadLine).each(function () {
                if(this.headline !== '' || this.title !== '' || value[this.headline] !== undefined || value[this.title] !== undefined ) {
                    headlineFlag= true;
                    result += '<div class="panel-heading"><h3 class="panel-title">';
                    if(this.titlefunc !== null && value[this.titlefunc] !== undefined){
                        result += '<a href="javascript:void(0);" onclick="' + this.titlefunc + '(' + value[this.titlekey] + ')' + '">';
                    }
                    if (this.headline !== '') {
                        result += '[' + value[this.headline] + ']';
                    }
                    result += value[this.title];
                    if (this.text !== '') {
                        if (value[this.text] !== undefined) {
                            result += value[this.text];
                        } else {
                            result += this.text;
                        }
                    }
                    if(this.titlefunc !== null && value[this.titlefunc] !== undefined){
                        result += '</a>';
                    }
                    result += '</h3>';
                    result += '<div class="tools">';
                    if (this.livebtn !== '' && value[this.liveflag] !== undefined) {
                        if (value[this.liveflag].toLowerCase() === 'y') {
                            result += '     <div class="state">';
                            result += '         <div class="label label-state active">';
                            result += '             <div class="label-text">LIVE ON</div>';
                            result += '             <i class="icon icon-onoff"></i>';
                            result += '         </div>';
                            result += '     </div>';
                            result += '     <div class="button">';
                            result += '         <button class="btn btn-sm btn-default btn-min" disabled>';
                            result += '             <span class="btn-text">' + this.rightbtntitle + '</span>';
                            result += '         </button>';
                            result += '     </div>';
                        } else {
                            result += '     <div class="state">';
                            result += '         <div class="label label-state">';
                            result += '             <div class="label-text">LIVE OFF</div>';
                            result += '             <i class="icon icon-onoff"></i>';
                            result += '         </div>';
                            result += '     </div>';
                            result += '     <div class="button">';
                            result += '         <button class="btn btn-sm btn-default btn-min" onclick="' + this.rightbtnfunc + '(' + value[this.rightbtnkey] + ',this)' + '">';
                            result += '             <span class="btn-text">' + this.rightbtntitle + '</span>';
                            result += '         </button>';
                            result += '     </div>';
                        }
                    } else {
                        if (this.rightbtntitle !== '' || value[this.rightbtntitle] !== undefined) {
                            result += '     <div class="button">';
                            result += '         <button class="btn btn-sm btn-default btn-min" onclick="' + this.rightbtnfunc + '(' + value[this.rightbtnkey] + ',this)' + '">';
                            result += '             <span class="btn-text">' + this.rightbtntitle + '</span>';
                            result += '         </button>';
                            result += '     </div>';
                        }
                    }
                    result += '</div>';
                    result += '</div>';
                }
            });
            if(headlineFlag){
                result += '<div class="panel-body">';
            }
            result += '     <div class="table table-form table-horizontal">';
            result += '         <div class="table-group">';
            result += '             <div class="colgroup">';
            result += '                 <div class="col" style="width:16.3%"></div>';
            result += '                 <div class="col" style="width:33.6%"></div>';
            result += '                 <div class="col" style="width:16.1%"></div>';
            result += '                 <div class="col" style="width:34.0%"></div>';
            result += '             </div>';
            var cnt = 0;
            $(setColumns).each(function () {
                if(!this.onedata){
                    if(cnt % 2 === 0) result += '<div class="cell-group cell-group-body">';
                    result += '<div class="cell cell-header"><div class="cell-data"><div class="cell-text">'+this.headertext+'</div></div></div>';
                    result += '<div class="cell cell-body"><div class="cell-data"><div class="cell-text">';

                    var content = '';
                    var str = this.datafield.split(',');
                    for(var i=0; i<str.length;i++){
                        content += ''+value[str[i]] + this.databtw;
                    }
                    content = content.substr(0,content.length-this.databtw.length);
                    //content가 없을 경우
                    if(content === null || content === undefined || content === ''){
                        content = this.datanone;
                    }
                    //function이 있을 경우(가공)
                    if (this.datafunc  !== null) {
                        if (this.clickfunc  !== null) {
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content,this.clickfunc);
                            }
                        }else{
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content);
                            }
                        }
                    }
                    result += content;
                    result +='</div></div></div>';
                    if(cnt % 2 !== 0) result += '</div>';
                    cnt++;
                }else{
                    result += '	</div>';
                    result += '	<div class="table-group">';
                    result += '		<div class="colgroup">';
                    result += '			<div class="col" style="width:16.3%"></div>';
                    result += '			<div class="col"></div>';
                    result += '		</div>';
                    result += '		<div class="cell-group cell-group-body">';
                    result += '			<div class="cell cell-header"><div class="cell-data"><div class="cell-text" >'+this.headertext+'</div></div></div>';
                    result += '			<div class="cell cell-body"><div class="cell-data">';
                    if(!this.othercell){
                        result += '<div class="cell-text">';
                    }

                    var content = '';
                    var str = this.datafield.split(',');
                    for(var i=0; i<str.length;i++){
                        content += ''+value[str[i]] + this.databtw;
                    }
                    content = content.substr(0,content.length-this.databtw.length);
                    //function이 있을 경우(가공)
                    if (this.datafunc  !== null) {
                        if (this.clickfunc  !== null) {
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content,this.clickfunc);
                            }
                        }else{
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content);
                            }
                        }
                    }
                    result += content;
                    if(!this.othercell){
                        result += '</div>';
                    }

                    result += '		</div></div></div>';
                    result += '	</div>';
                    result += '	<div class="table-group">';
                    result += '		<div class="colgroup">';
                    result += '			<div class="col" style="width:16.3%"></div>';
                    result += '			<div class="col" style="width:33.6%"></div>';
                    result += '			<div class="col" style="width:16.1%"></div>';
                    result += '			<div class="col" style="width:34.0%"></div>';
                    result += '		</div>';
                }

            });
            result += '         </div>';
            result += '     </div>';
            if(headlineFlag){
                result += '</div>';
            }
            result += '</div></div>';
        });
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.

        result += '<div class="table table-default table-striped">';
        result += '		<div class="table-group">';
        result += '			<div class="cell-group cell-empty">';
        result += '				<div class="cell cell-data">';
        result += '					<span class="cell-text">'+text+'</span>';
        result += '				</div>';
        result += '			</div>';
        result += '		</div>';
        result += '</div>';

    }

    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}

function newPanelScrollHTML(columns, data, headLine, divId, size, noDataMsg){
    //column 디폴트값
    var defaultColumns = {
        headertext : 'thead'          // thead에 들어갈 값 (*)
        , datafield : 'string'          // thead와 매칭 될 data 컬럼 값 (*)
        , ishidden : false             // 해당 컬럼을 숨길 꺼면 true
        , datatype : 'string'           // 데이터 타입(string, count : 순번)
        , datanone : '-' // 데이터가 없을 경우 string
        , datafunc : null              // 데이터를 가공할 function
        , clickfunc : null             // 이벤트가 발생할 function
        , datafunckey : null           // 데이터 key
        , addAttr : ''                  // td add attr
        , onedata : false				// 테이블 중간 ROW 에 한 데이터만 있을경우 사용
        , othercell : false				// image 나 다른 형식의 데이터를 사용할경우 cell-text클래스 div 제거
    };
    //headLine
    var deafaultHeadLine = {
        headline : ''					// row number컬럼 사용안하고 시퀀스넘 별도로 사용할 경우
        , rowNumber : false				// row number컬럼
        , headlinekey : null			// row number컬럼 사용시 (headlinekey : currentPage값, pageRowCount값 , totalCnt값) (ex: datafunckey : '2,10,100')
        , title : ''
        , titlefunc : null
        , titlekey : null
        , liveflag : null				// live_yn 데이터가 들어올 경우에만 버튼 생성
        , deletetitle : ''				// title이 있을 경우 버튼 생성 String
        , deletefunc : null				// function 있을 경우 활성화
        , deletekey : null
        , whiteLabel : null				// 화이트라벨 y로 구분
        , deleteOpt : null				// live_yn에 따라 삭제버튼 활성화
    };

    //columns 값 재셋팅
    var setColumns = new Array();
    if(columns.length > 0){
        $(columns).each(function (key, value) {
            setColumns.push($.extend({}, defaultColumns, this));
        });
    }else{
        setColumns = new Array();
    }

    //headline 값 재셋팅
    var setHeadLine = new Object();
    if(headLine) {
        setHeadLine = $.extend({}, deafaultHeadLine, headLine);
    }else{
        setHeadLine = deafaultHeadLine;
    }

    if(size == null || size == undefined || size == ''){
    	size = 218;
    }

    //페널 html 생성성
    var result = '';
    if(data && data.length > 0) {
    	result += '<div class="dialog-scroll" area-scroll="true" area-scroll-addclass="content-scroll"  area-scroll-multi="true" area-height="'+size+'" style="height:'+size+'px;">';
        $(data).each(function (index, value) {
        	 result += '<div class="row in-panel-form"><div class="panel panel-form">';
            $(setHeadLine).each(function () {
                result += '<div class="panel-heading">';

                result += '<h3 class="panel-title">';

                if(this.titlefunc){
                	result += '<a href="javascript:void(0);" onclick="'+this.titlefunc+'(\''+value[this.titlekey]+'\')'+'">';
                }

                if(this.rowNumber){
                	var rowSet = this.headlinekey.split(',');
                	var cont = "";
                	if(rowSet[2] == 'A'){
                		cont = ((rowSet[0]-1) * rowSet[1]) + (index+1);
                	}else{
                		cont = rowSet[2] - ((rowSet[0] -1) * rowSet[1]) -index;
                	}
                	result += '['+cont+'] '+value[this.title]+'</a></h3>';
                }else{
                    if(this.headline != null && this.headline != undefined && this.headline != ''){
                    	result += '['+value[this.headline]+']'+value[this.title]+'</a></h3>';
                    }else{
                    	result += value[this.title]+'</a></h3>';
                    }
                }

                if(this.whiteLabel != null){
                	if(value[this.whiteLabel].toLowerCase() === 'y'){
                		result += '<div class="panel-label">';
                		result += '	<span class="tag tag-coolgrey"><span class="tag-text">W/L</span></span>';
                		result += '</div>';
                	}
                }

                if(this.liveflag != null || this.deletetitle){
                	result += '<div class="tools">';
                	// 라이브 버튼
                	if(this.liveflag == null) {

                	} else if(value[this.liveflag].toLowerCase() === 'y'){
	                    result += '     <div class="state">';
	                    result += '         <div class="lazbel label-state active">';
	                    result += '             <div class="label-text">LIVE ON</div>';
	                    result += '             <i class="icon icon-onoff"></i>';
	                    result += '         </div>';
	                    result += '     </div>';
	                } else if(value[this.liveflag].toLowerCase() === 'n'){
	                    result += '     <div class="state">';
	                    result += '         <div class="label label-state">';
	                    result += '             <div class="label-text">LIVE OFF</div>';
	                    result += '             <i class="icon icon-onoff"></i>';
	                    result += '         </div>';
	                    result += '     </div>';
	                } else if(value[this.liveflag].toLowerCase() === 's'){// EXPIRED 버튼
	                	result += '     <div class="state">';
	                	result += '         <div class="label label-state">';
	                	result += '             <div class="label-text">EXPIRED</div>';
	                	result += '             <i class="icon icon-onoff"></i>';
	                	result += '         </div>';
	                	result += '     </div>';
	                }
	                //삭제버튼
            		if(this.deletetitle != '' && this.deletefunc) {
            			var deletekeyTxt = "";
            			if(this.deletekey.match(',')){
            				var deleteArry = this.deletekey.split(',');
            				deleteArry.forEach(function (item){
            					deletekeyTxt += value[item] + '\',\'';
            				});
            				deletekeyTxt = deletekeyTxt.substring(0, deletekeyTxt.length -3);

            			}else{
            				deletekeyTxt = value[this.deletekey];
            			}

            			result += '     <div class="button">';

            			if(this.deleteOpt){
                    		if(value[this.deleteOpt].toLowerCase() === 'y'){
                    			result += '         <button class="btn btn-sm btn-default btn-min" disabled>';
                    		} else {
                    			result += '         <button class="btn btn-sm btn-default btn-min" onclick="'+this.deletefunc+'(\''+deletekeyTxt+'\',this)'+'">';
                    		}
                    	}

            			result += '             <span class="btn-text">'+this.deletetitle+'</span>';
            			result += '         </button>';
            			result += '     </div>';

            		} else if (this.deletetitle != '') {
            			result += '     <div class="button">';
            			result += '         <button class="btn btn-sm btn-default btn-min" disabled>';
            			result += '             <span class="btn-text">'+this.deletetitle+'</span>';
            			result += '         </button>';
            			result += '     </div>';
            		}


	                result += '</div>';
                }
                result += '</div>';
            });
            result += '<div class="panel-body">';
            result += '     <div class="table table-horizontal">';
            result += '         <div class="table-group">';
            result += '             <div class="colgroup">';
            result += '                 <div class="col" style="width:16.3%"></div>';
            result += '                 <div class="col" style="width:33.6%"></div>';
            result += '                 <div class="col" style="width:16.1%"></div>';
            result += '                 <div class="col" style="width:34.0%"></div>';
            result += '             </div>';
            var cnt = 0;
            $(setColumns).each(function () {
            	if(!this.onedata){
                    if(cnt % 2 === 0) result += '<div class="cell-group cell-group-body">';
                    result += '<div class="cell cell-header"><div class="cell-data"><div class="cell-text">'+this.headertext+'</div></div></div>';
                    result += '<div class="cell cell-body"><div class="cell-data">';
                    if(!this.othercell){
            			result += '<div class="cell-text">';
            		}

                    var content = value[this.datafield];
                    //content가 없을 경우
                    if(content === null || content === undefined){
                        content = this.datanone;
                    }
                    //function이 있을 경우(가공)
                    if (this.datafunc  !== null) {
                        if (this.clickfunc  !== null) {
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content,this.clickfunc);
                            }
                        }else{
                            if(this.datafunckey !== null){
                            	if(gTzOffset != null && gTzOffset != "" && gTzOffset != undefined) {
                            		content = this.datafunc(value,content,this.datafunckey, gTzOffset);
                            	} else {
                            		content = this.datafunc(value,content,this.datafunckey);
                            	}
                            }else{
                                content = this.datafunc(value,content);
                            }
                        }
                    }
                    result += content;
                    if(!this.othercell){
                    	result += '</div>';
                    }

                    result +='</div></div>';
                    if(cnt % 2 !== 0) result += '</div>';
                    cnt++;
            	}else{
            		result += '	</div>';
            		result += '	<div class="table-group">';
            		result += '		<div class="colgroup">';
            		result += '			<div class="col" style="width:16.3%"></div>';
            		result += '			<div class="col"></div>';
            		result += '		</div>';
            		result += '		<div class="cell-group cell-group-body">';
            		result += '			<div class="cell cell-header"><div class="cell-data"><div class="cell-text" >'+this.headertext+'</div></div></div>';
            		result += '			<div class="cell cell-body"><div class="cell-data">';
            		if(!this.othercell){
            			result += '<div class="cell-text">';
            		}

                    var content = value[this.datafield];
                    //content가 없을 경우
                    if(content === null){
                        content = this.datanone;
                    }
                    //function이 있을 경우(가공)
                    if (this.datafunc  !== null) {
                        if (this.clickfunc  !== null) {
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.clickfunc,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content,this.clickfunc);
                            }
                        }else{
                            if(this.datafunckey !== null){
                                content = this.datafunc(value,content,this.datafunckey);
                            }else{
                                content = this.datafunc(value,content);
                            }
                        }
                    }
                    result += content;
                    if(!this.othercell){
                    	result += '</div>';
                    }

            		result += '		</div></div></div>';
            		result += '	</div>';
            		result += '	<div class="table-group">';
            		result += '		<div class="colgroup">';
            		result += '			<div class="col" style="width:16.3%"></div>';
            		result += '			<div class="col" style="width:33.6%"></div>';
            		result += '			<div class="col" style="width:16.1%"></div>';
            		result += '			<div class="col" style="width:34.0%"></div>';
            		result += '		</div>';
            	}

            });
            result += '         </div>';
            result += '     </div>';
            result += '</div>';
            result += '</div></div>';
        });
    }else{

    	var text = noDataMsg != null && noDataMsg != "" && noDataMsg != undefined ? noDataMsg : noneData; //검색 결과가 없습니다.

    	result += '<div class="table table-default table-striped">';
    	result += '		<div class="table-group">';
    	result += '			<div class="cell-group cell-empty">';
    	result += '				<div class="cell cell-data">';
    	result += '					<span class="cell-text">'+text+'</span>';
    	result += '				</div>';
    	result += '			</div>';
    	result += '		</div>';
    	result += '</div>';

    }
    result += '</div>';
    if(divId !== undefined && divId !== null && divId !== ""){
        $('#'+divId).html(result);
    }else{
        return result;
    }
}

var ajax_yn = true;
/**
 * AJAX 호출1
 * @param Method
 * @param Url
 * @param Data
 * @param callback
 */
function sendAjaxJson(Method, Url, Data, callback){
    if(ajax_yn){
        ajax_yn = false;
        $.ajax({
            type: Method
            , url: Url
            , data: Data
            , contentType: "application/json"
            , success: function (res) {
                ajax_yn = true;
                if(res.result === 200 || res.return_code == '0'){
                    callback(res);
                }else{

                	/*
                    new alerts({
            			type :'warning',
            			auto : true,
            			modal:true,
            			text : res.return_message
            		}).topbar()
            		*/

            		callback(res);
                }
            }
        });
    }
}

function sendAjaxJsonHtml(Method, Url, Data, callback){
    if(ajax_yn){
        ajax_yn = false;
        $.ajax({
            type: Method
            , url: Url
            , data: Data
            , dataType: "html"
            , contentType: "application/json"
            , success: function (res) {
                ajax_yn = true;
                callback(res);
            }
        });
    }
}

/**
 * AJAX 호출2
 * @param Method
 * @param Url
 * @param Data
 * @param callback
 */
function sendAjaxJsonNosync(Method, Url, Data, callback){

    $.ajax({
        type: Method
        , url: Url
        , data: Data
        , contentType: "application/json"
        , success: function (res) {
            ajax_yn = true;

            if(res.return_code != 0 && res.return_code != 10003 && res.resultCode != 0 ){

            	var msg = (typeof res.return_message == 'undefined') ?
            			"[ "+Url+" ] "+"오류가 발생했습니다." : res.return_message;

            	new alerts({
        			type :'warning',
        			auto : true,
        			modal:true,
        			text : msg
        		}).topbar()

            }else{

            	callback(res);
            }

        }
    });
}

function sendAjaxJsonSync(Method, Url, Data, callback){
    $.ajax({
        type: Method
        , url: Url
        , async:false
        , data: Data
        , contentType: "application/json"
        , success: function (res) {
            callback(res);
        }
    });
}

function sendAjaxJsonAsync(Method, Url, Data, callback){
    $.ajax({
        type: Method
        , url: Url
        , async:true
        , data: Data
        , contentType: "application/json"
        , success: function (res) {
            callback(res);
        }
    });
}

/**
 * 현재 날짜
 * @param data
 * @param formet
 * @returns {string}
 */
function nowDate(data,formet){
    var nowDate = new Date();
    var returnDate = '';
    if(data.indexOf('Y') > -1){
        returnDate += nowDate.getFullYear() + formet;
    }
    if(data.indexOf('M') > -1){
        returnDate += addzero(eval( nowDate.getMonth()+1 )) + formet;
    }
    if(data.indexOf('D') > -1){
        returnDate += addzero(nowDate.getDate()) + formet;
    }
    if(formet.length > 0){
        returnDate = returnDate.substr(0,returnDate.length-1);
    }
    return returnDate;
}

/**
 * 현재 시간
 * @param data
 * @param formet
 * @returns {string}
 */
function nowTime(data,formet){
    var nowDate = new Date();
    var returnTime = '';
    if(data.indexOf('H') > -1){
        returnTime += nowDate.getHours() + formet;
    }
    if(data.indexOf('M') > -1){
        returnTime += addzero(nowDate.getMinutes()) + formet;
    }
    if(data.indexOf('S') > -1){
        returnTime += addzero(nowDate.getSeconds()) + formet;
    }
    if(formet.length > 0){
        returnTime = returnTime.substr(0,returnTime.length-1);
    }
    return returnTime;
}

function addzero(n) {
    return n < 10 ? '0' + n : n;
}

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
    var linkFunctionName = 'javascript:'+linkFunction;
    
    if(!totalCount || totalCount < 1){
    	
    	$(".num").text(0);
        targetDiv = typeof targetDiv == "string" ? document.getElementById(targetDiv) : targetDiv;
        if (targetDiv) {

        	var tagStr = "";
        	
        	if(!pageBarOnOff) {
        		tagStr += '<nav><ul class="pagination">';
        		tagStr += '<li><button type="button" class="first" aria-label="Frist" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        		tagStr += '<li><button type="button"class="prev" aria-label="Previous" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        		tagStr += '<li class="active"><a href="#">1</a></li>';
        		tagStr += '<li><button type="button"class="next" aria-label="Next" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        		tagStr += '<li><button type="button" class="end" aria-label="End" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
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
            tagStr += '<li><a href="#" onclick="'+linkFunctionName+'(1)" class="first" aria-label="Frist"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="first" aria-label="Frist" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        }

        if(currentPage > 10){
            var newPage = 1;
            if(currentPage*1 >10){
                newPage = currentPage*1 - 10;
            }else{
                newPage = 1
            }
            tagStr += '<li><a href="javascript:void(0);" class="prev" aria-label="Previous" onclick="'+linkFunctionName+'('+newPage*1+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="prev" aria-label="Previous" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
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
            tagStr += '<li><a href="javascript:void(0);" class="next" aria-label="Next"  onclick="'+linkFunctionName+'('+newPage*1+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
        	if(totalPageCount > endPage){
        		tagStr += '<li><a href="javascript:void(0);" class="next" aria-label="Next"  onclick="'+linkFunctionName+'('+totalPageCount*1+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
			}else{
				tagStr += '<li><button type="button" class="next" aria-label="Next" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
			}
        }

        if(currentPage < totalPageCount ){
            tagStr += '<li><a href="#" class="end" aria-label="End" onclick="'+linkFunctionName+'('+(totalPageCount)+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="end" aria-label="End" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
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

/**
 *  페이징 모듈 (갯수가 0개일때 화면의 모든 카운터를 0으로 만드는 이슈로 추가)
 * @param totalCount    총 리스트 갯수
 * @param currentPage   현재 페이지
 * @param pageSize      한페이지 보여질 목록 갯수
 * @param listSize      한번에 보여질 페이징 갯수
 * @param linkFunction  클릭 function
 * @param targetDiv     만들어징 페이징이 적용될 div ID
 * @returns {*}
 */
function makePageNavigationBar2(totalCount, currentPage, pageSize, listSize, linkFunction, targetDiv, pageBarOnOff) {
    var DEFAULT_LIST_SIZE = 10;
    var DEFAULT_PAGE_SIZE = 10;
    var DEFAULT_CURRENT_PAGE = 1;
    var linkFunctionName = 'javascript:'+linkFunction;
    
    if(!totalCount || totalCount < 1){
    	
        targetDiv = typeof targetDiv == "string" ? document.getElementById(targetDiv) : targetDiv;
        if (targetDiv) {

        	var tagStr = "";
        	
        	if(!pageBarOnOff) {
        		tagStr += '<nav><ul class="pagination">';
        		tagStr += '<li><button type="button" class="first" aria-label="Frist" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        		tagStr += '<li><button type="button"class="prev" aria-label="Previous" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        		tagStr += '<li class="active"><a href="#">1</a></li>';
        		tagStr += '<li><button type="button"class="next" aria-label="Next" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        		tagStr += '<li><button type="button" class="end" aria-label="End" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
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
            tagStr += '<li><a href="#" onclick="'+linkFunctionName+'(1)" class="first" aria-label="Frist"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="first" aria-label="Frist" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
        }

        if(currentPage > 10){
            var newPage = 1;
            if(currentPage*1 >10){
                newPage = currentPage*1 - 10;
            }else{
                newPage = 1
            }
            tagStr += '<li><a href="javascript:void(0);" class="prev" aria-label="Previous" onclick="'+linkFunctionName+'('+newPage*1+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="prev" aria-label="Previous" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
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
            tagStr += '<li><a href="javascript:void(0);" class="next" aria-label="Next"  onclick="'+linkFunctionName+'('+newPage*1+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
        	if(totalPageCount > endPage){
        		tagStr += '<li><a href="javascript:void(0);" class="next" aria-label="Next"  onclick="'+linkFunctionName+'('+totalPageCount*1+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
			}else{
				tagStr += '<li><button type="button" class="next" aria-label="Next" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
			}
        }

        if(currentPage < totalPageCount ){
            tagStr += '<li><a href="#" class="end" aria-label="End" onclick="'+linkFunctionName+'('+(totalPageCount)+')"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></a></li>';
        }else{
            tagStr += '<li><button type="button" class="end" aria-label="End" disabled="disabled"><span aria-hidden="true"><i class="icon icon-arrow"></i></span></button></li>';
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

function isEmpty(str){
    if(str === 'null' || str === null || str === undefined || str.length === 0 ){
        return '';
    }
    return str;
}

function checkAuth(resourceId, paramResources) {
    var paramDate = (paramResources).toString();
    paramDate = paramDate.replace("[","");
    paramDate = paramDate.replace("]","");
    paramDate = paramDate.split(",");
    var result = false;
    _.forEach(paramDate, function(value) {
        if(_.isEqual(resourceId, $.trim(value))) {
            result = true;
            return false;
        }
    });
    
    return result;
}