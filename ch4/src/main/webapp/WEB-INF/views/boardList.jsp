<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>YOURTREE</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        a {
            text-decoration: none;
            color: black;
        }
        button,
        input {
            border: none;
            outline: none;
        }
        .board-container {
            width: 60%;
            height: 1200px;
            margin: 0 auto;
            /* border: 1px solid black; */
        }
        .search-container {
            background-color: rgb(253, 253, 250);
            width: 100%;
            height: 110px;
            border: 1px solid #ddd;
            margin-top : 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .search-form {
            height: 37px;
            display: flex;
        }
        .search-option {
            width: 100px;
            height: 100%;
            outline: none;
            margin-right: 5px;
            border: 1px solid #ccc;
            color: gray;
        }
        .search-option > option {
            text-align: center;
        }
        .search-input {
            color: gray;
            background-color: white;
            border: 1px solid #ccc;
            height: 100%;
            width: 300px;
            font-size: 15px;
            padding: 5px 7px;
        }
        .search-input::placeholder {
            color: gray;
        }
        .search-button {
            /* ???????????? ?????? ?????? ?????????  */
            width: 20%;
            height: 100%;
            background-color: rgb(22, 22, 22);
            color: rgb(209, 209, 209);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
        }
        .search-button:hover {
            color: rgb(165, 165, 165);
        }
        table {
            border-collapse: collapse;
            width: 100%;
            border-top: 2px solid rgb(39, 39, 39);
        }
        tr:nth-child(even) {
            background-color: #f0f0f070;
        }
        th,
        td {
            width:300px;
            text-align: center;
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        td {
            color: rgb(53, 53, 53);
        }
        .no      { width:150px;}
        .title   { width:50%;  }
        td.title   { text-align: left;  }
        td.writer  { text-align: left;  }
        td.viewcnt { text-align: right; }
        td.title:hover {
            text-decoration: underline;
        }
        .paging {
            color: black;
            width: 100%;
            align-items: center;
        }
        .page {
            color: black;
            padding: 6px;
            margin-right: 10px;
        }
        .paging-active {
            background-color: rgb(216, 216, 216);
            border-radius: 5px;
            color: rgb(24, 24, 24);
        }
        .paging-container {
            width:100%;
            height: 70px;
            display: flex;
            margin-top: 50px;
            margin : auto;
        }
        .btn-write {
            background-color: rgb(236, 236, 236); /* Blue background */
            border: none; /* Remove borders */
            color: black; /* White text */
            padding: 6px 12px; /* Some padding */
            font-size: 16px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
            border-radius: 5px;
            margin-left: 30px;
        }
        .btn-write:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div id="menu">
		<ul>
			<li id="logo"><img src="http://localhost:8080/ch4/image/peach.png" alt="?????????" width="50px">
			</li>
			<li id="logo">YOUR TREE</li>
			<li><a href="<c:url value='/'/>">Home</a></li>
			<li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
			<li><a href="<c:url value='/register/add'/>">Sign in</a></li>
			<li><a href="<c:url value='/register/update'/>">update</a></li>
			<li><a href="<c:url value='/register/select'/>">select</a></li>
			<li><a href="<c:url value='/register/Allselect'/>">Allselect</a></li>
			<li><a href="<c:url value='/new_Info/new'/>">NEW</a></li>
			<li><a href="<c:url value='/board/list'/>">Board</a></li>
			<li><a href="<c:url value='/login/mypage'/>">MYPAGE</a></li>
			<li><a href=""><i class="fa fa-search"></i></a></li>
		</ul>
	</div>
<script>
	//${document}.ready(function() {
	//	${"#selectremove"}.click(function() {
	//	var lists = $("input[name='RowCheck']");
	//		alert("??????????????? ??????");
	//		fn_delete(list);
	//	});
	//})
	
	//function fn_delete(valueArr) {
	//	var comajax = new ComAjax(??? ??????);
	//	comajax.setUrl("<c:url value="/board/selectremove"/>");
	//	comajax.addParam("valueArr", valueArr);
	//	comajax.ajax();}
	
	$(".heart-click").click(function() {

	    // ????????? ??????(no)??? idx??? ???????????? ???????????????.
	    let no = $(this).attr('idx');
	    console.log("heart-click");

	    // ???????????? ????????????
	    if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
	        console.log("????????? ??????" + no);

	        $.ajax({
	            url : 'saveHeart.do',
	            type : 'get',
	            data : {
	                no : no,
	            },
	            success : function(pto) {
	                //????????? ????????????
	                //document.location.reload(true);

	                let heart = pto.heart;

	                // ?????????, ???????????? ????????? ??????
	                $('#m_heart'+no).text(heart);
	                $('#heart'+no).text(heart);

	                console.log("???????????? ??????");
	            },
	            error : function() {
	                alert('?????? ??????');
	            }
	        });
	        console.log("??????????????? ?????????!");

	        // ??????????????? ?????????
	        $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
	        $('.heart_icon'+no).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

	    // ?????? ????????? ????????? ???
	    }else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
	        console.log("???????????? ??????" + no);

	        $.ajax({
	            url : 'removeHeart.do',
	            type : 'get',
	            data : {
	                no : no,
	            },
	            success : function(pto) {
	                //????????? ????????????
	                //document.location.reload(true);

	                let heart = pto.heart;
	                // ?????????, ???????????? ????????? ??????
	                $('#m_heart'+no).text(heart);
	                $('#heart'+no).text(heart);

	                console.log("???????????? ??????");
	            },
	            error : function() {
	                alert('?????? ??????');
	            }
	        });
	        console.log("???????????? ?????????!");

	        // ???????????? ?????????
	        $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');

	        $('.heart_icon'+no).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
	    }
	});
	
	function ComAjax(opt_formId){
		this.url = "";		
		this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
		this.param = "";
		
		if(this.formId == "commonForm"){
	        var frm = $("#commonForm");
	        if(frm.length > 0){
		        frm.remove();
	        }
	        var str = "<form id='commonForm' name='commonForm'></form>";
	        $('body').append(str);
		}
		
		this.setUrl = function setUrl(url){
			this.url = url;
		};
		
		this.setCallback = function setCallback(callBack){
			fv_ajaxCallback = callBack;
		};
	
		this.addParam = function addParam(key,value){ 
			this.param = this.param + "&" + key + "=" + value; 
		};
		
		this.ajax = function ajax(){
			if(this.formId != "commonForm"){
				this.param += "&" + $("#" + this.formId).serialize();
			}
			$.ajax({
			    url : url,                    // ?????? URL
			    type : 'POST',                // POST ??????
			    traditional : true,
			    data : {
			    	valueArr : valueArr        // ???????????? ?????? data ?????? ??????
			    },
	            success: function(jdata){
	                if(jdata = 1) {
	                    alert("?????? ??????");
	                    location.replace("list") //list ??? ????????? ????????????
	                }
	                else{
	                    alert("?????? ??????");
	                }
	            }
			});
		};
	}
	//??????: https://addio3305.tistory.com/91 [?????? ???????????? ?????? ??????:????????????]
	
    let msg = "${msg}";
    if(msg=="LIST_ERR")  alert("????????? ????????? ??????????????? ??????????????????. ?????? ????????? ?????????.");
    if(msg=="READ_ERR")  alert("?????????????????? ?????? ??????????????????.");
    if(msg=="DEL_ERR")   alert("?????????????????? ?????? ??????????????????.");
    if(msg=="DEL_OK")    alert("??????????????? ?????????????????????.");
    if(msg=="WRT_OK")    alert("??????????????? ?????????????????????.");
    if(msg=="MOD_OK")    alert("??????????????? ?????????????????????.");
    
    
    // ?????? ?????? ??????
	$(function(){
		var chkObj = document.getElementsByName("RowCheck");
		var rowCnt = chkObj.length;
		
		$("input[name='allCheck']").click(function(){
			var chk_listArr = $("input[name='RowCheck']");
			for (var i=0; i<chk_listArr.length; i++){
				chk_listArr[i].checked = this.checked;
			}
		});
		$("input[name='RowCheck']").click(function(){
			if($("input[name='RowCheck']:checked").length == rowCnt){
				$("input[name='allCheck']")[0].checked = true;
			}
			else{
				$("input[name='allCheck']")[0].checked = false;
			}
		});
	});
	
    
    // ?????? ?????? ??????
	function deleteValue(){
		var url = "selectremove";    // Controller??? ???????????? ?????? URL
		var valueArr = new Array();
	    var list = $("input[name='RowCheck']");
	    for(var i = 0; i < list.length; i++){
	        if(list[i].checked){ //???????????? ????????? ????????? ?????? ?????????
	            valueArr.push(list[i].value);
	        }
	    }
	    if (valueArr.length == 0){
	    	alert("????????? ?????? ????????????.");
	    }
	    else{
			var chk = confirm("?????? ?????????????????????????");				 
			$.ajax({
			    url : url,                    // ?????? URL
			    type : 'POST',                // POST ??????
			    traditional : true,
			    data : {
			    	valueArr : valueArr        // ???????????? ?????? data ?????? ??????
			    },
                success: function(jdata){
                    if(jdata = 1) {
                        alert("?????? ??????");
                        location.replace("list") //list ??? ????????? ????????????
                    }
                    else{
                        alert("?????? ??????");
                    }
                }
			});
		}
	}
</script>
<div style="text-align:center">
    <div class="board-container">
        <div class="search-container">
            <form action="<c:url value="/board/list"/>" class="search-form" method="get">
                <select class="search-option" name="option">
                    <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>??????+??????</option>
                    <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>?????????</option>
                    <option value="W" ${ph.sc.option=='W' ? "selected" : ""}>?????????</option>
                </select>

                <input type="text" name="keyword" class="search-input" type="text" value="${ph.sc.keyword}" placeholder="???????????? ??????????????????">
                <input type="submit" class="search-button" value="??????">
            </form>
            <button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/board/write"/>'"><i class="fa fa-pencil"></i> ?????????</button>
            <input type = "button" value = "?????? ??????" class = "btn-write" id = "delete"  onclick = "deleteValue();">
        </div>

        <table>
            <tr>
            	<th scope = "col"><input id = "allCheck" type = "checkbox" name = "allCheck"></th>
                <th class="no">??????</th>
                <th class="title">??????</th>
                <th class="writer">??????</th>
                <th class="regdate">?????????</th>
                <th class="viewcnt">?????????</th>
                <th class="favo">?????????</th>
            </tr>
            <c:forEach var="boardDto" items="${list}">
                <tr>
                	<td class="text_ct"><input name = "RowCheck" type = "checkbox" value = "${boardDto.bno}"/></td>
                    <td class="no">${boardDto.bno}</td>
                    <td class="title"><a href="<c:url value="/board/read${ph.sc.queryString}&bno=${boardDto.bno}"/>"><c:out value='${boardDto.title}'/></a></td>`
                    <td class="writer">${boardDto.writer}</td>
                    <c:choose>
                        <c:when test="${boardDto.reg_date.time >= startOfToday}">
                            <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="HH:mm" type="time"/></td>
                        </c:when>
                        <c:otherwise>
                            <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy-MM-dd" type="date"/></td>
                        </c:otherwise>
                    </c:choose>
                    <td class="viewcnt"><c:out value="${boardDto.view_cnt}"/></td>
                    <c:choose>
						            <c:when test="${empty boardDto.bno}">
						                <%-- ??? ???????????? --%>
						                <td><a idx="${boardDto.bno}" href="javascript:"
						                    class="heart-click heart_icon${boardDto.bno }"><svg
						                        xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						                        fill="currentColor" class="bi bi-suit-heart"
						                        viewBox="0 0 16 16">
						                          <path
						                            d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
						                        </svg></a></td>
						
						            </c:when>
						            <c:otherwise>
						                <%-- ?????? ???????????? --%>
						                <td>
						                <a idx="${boardDto.bno}" href="javascript:"
						                    class="heart-click heart_icon${boardDto.bno }"><svg
						                        xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						                        fill="currentColor" class="bi bi-suit-heart-fill"
						                        viewBox="0 0 16 16">
						                          <path
						                            d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z" />
						                        </svg></a></td>
						            </c:otherwise>
						        </c:choose>
                </tr>
            </c:forEach>
        </table>
        <br>
        <div class="paging-container">
            <div class="paging">
                <c:if test="${totalCnt==null || totalCnt==0}">
                    <div> ???????????? ????????????. </div>
                </c:if>
                <c:if test="${totalCnt!=null && totalCnt!=0}">
                    <c:if test="${ph.showPrev}">
                        <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>