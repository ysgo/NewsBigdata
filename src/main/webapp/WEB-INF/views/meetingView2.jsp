<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.NewsVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<style>
td {
	border-bottom: 2px dotted green;
}

tr:hover {
	background-color: pink;
	font-weight: bold;
}

td:nth-child(3) {
	width: 400px;
}
</style>
<body>
	<%
		ArrayList<NewsVO> list = (ArrayList<NewsVO>) request.getAttribute("list");
		if (list != null) {
	%>
	<h2>미팅 스케쥴(2)</h2>
	<hr>
	<table>
		<%
			for (NewsVO vo : list) {
		%>
		<tr>
			<td class='<%=vo.getTitle()%>'><%=vo.getTitle()%></td>
			<td class='<%=vo.getDate()%>'><%=vo.getDate()%></td>
			<td class='<%=vo.getContents()%>'><%=vo.getContents()%></td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		}
		if (request.getAttribute("msg") != null) {
	%>
	<script>
		alert('${ msg }');
	</script>

	<%
		}
	%>
	<hr>
	<button onclick="displayDiv(1);">미팅 정보 작성</button>
	<button onclick="displayDiv(2);">미팅 정보 검색</button>
	<script>
		function displayDiv(type) {
			if (type == 1) {
				document.getElementById("search").style.display = 'none';
				document.getElementById("write").style.display = 'block';
			} else if (type == 2) {
				document.getElementById("write").style.display = 'none';
				document.getElementById("search").style.display = 'block';
			}
		}
		function displayUpdateForm(cv) {
			var doms = document.getElementsByClassName(cv)
			document.getElementById("write").style.display = 'block';
			document.getElementById("m_name").value = doms[0].textContent;
			document.getElementById("m_title").value = doms[1].textContent;
			var str = doms[2].textContent;
			var ary = str.split(/\D+/g)
			var meeting_dt = ary[0] + "-" + ary[1] + "-" + ary[2] + "T"
					+ ary[3] + ":" + ary[4];
			document.getElementById("m_dt").value = meeting_dt;
			document.getElementById("divT").textContent = "미팅정보 수정";
			document.querySelector("#write [type=submit]").value = "수정";
			document.querySelector("#write [type=hidden]").value = cv;
		}
	</script>
	<div id="write" style="display: none">
		<hr>
		<h2 id="divT">미팅정보 작성</h2>
		<form method="post" action="/NewsBigdata/meeting">
			<input type="hidden" name="action" value="insert"> 미팅 대상 이름 :
			<input id="m_name" type="text" name="name"> <br> 미팅 목적 :
			<br>
			<textarea id="m_title" rows="3" cols="30" name="title"></textarea>
			<br> 날짜와 시간 : <input id="m_dt" type="datetime-local"
				name="meetingDate"> <br> <input type="submit"
				value="등록"> <input type="reset" value="재작성">
		</form>
	</div>
	<div id="search" style="display: none">
		<form method="get" action="/NewsBigdata/meeting">
			검색어 : <input type="search" name="keyword"> <input
				type="submit" value="검색">
			<hr>
			<button type="button" onclick="location.href='/springedu/meeting' ">미팅
				스케쥴 보기</button>
		</form>
	</div>
	<%
		out.print("<a href='" + request.getHeader("referer") + "'>" + "뒤로 가기</a>");
	%>
</body>
</html>





