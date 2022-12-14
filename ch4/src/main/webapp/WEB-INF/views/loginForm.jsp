<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>

<%@ page import="java.net.URLDecoder" %>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>YOUR TREE</title>
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
  <link rel="stylesheet" href="<c:url value='/css/login.css'/>">
</head>
<body>
<div id="menu">
		<ul>
			<li id="logo"><img src="http://localhost:8080/ch4/image/peach.png" alt="이미지" width="50px">
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
<form action="<c:url value="/login/login"/>" method="post" onsubmit="return formCheck(this);">
  <h3 id="title">Login</h3>
  <div id="msg">
    <c:if test="${not empty param.msg}">
      <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
    </c:if>
  </div>
  <input type="text" name="id" value="${cookie.id.value}" placeholder="아이디" autofocus>
  <input type="password" name="pwd" placeholder="비밀번호">
  <input type="hidden" name="toURL" value="${param.toURL}">
  <button>로그인</button>
  <div>
    <label><input type="checkbox" name="rememberId" value="on" ${empty cookie.id.value ? "":"checked"}> 아이디 기억</label> |
    <a href="">비밀번호 찾기</a> |
    <a href="<c:url value='/register/add'/>">회원가입</a>
  </div>
  <script>
    function formCheck(frm) {
      let msg ='';
      if(frm.id.value.length==0) {
        setMessage('id를 입력해주세요.', frm.id);
        return false;
      }
      if(frm.pwd.value.length==0) {
        setMessage('password를 입력해주세요.', frm.pwd);
        return false;
      }
      return true;
    }
    function setMessage(msg, element){
      document.getElementById("msg").innerHTML = ` ${'${msg}'}`;
      if(element) {
        element.select();
      }
    }
  </script>
</form>
</body>
</html>