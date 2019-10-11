<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Spring Framework - Ajax</title>
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-kernel/master/dist/ax5ui.all.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-kernel/master/dist/ax5ui.all.min.js"></script>
</head>

<body>
<h3>Spring Framework - Ajax</h3>
<div style="margin-bottom:10px;">
	<form id="SearchForm" name="SearchForm" method="GET" style="display:inline;">
	    <input type="hidden" id="page" name="page" value="" />
		<label for="type">구분:</label>
		<select id="type" name="type">
			<option value="" >전체</option>
			<option value="R">정비</option>
			<option value="O">주유</option>
		</select>
		<label for="complete">완료:</label>
		<select id="complete" name="complete">
			<option value="" >전체</option>
			<option value="Y">yes</option>
			<option value="N">no</option>
		</select>
	</form>
	<button onclick="searchType('POST');">조회 POST</button>
	<button onclick="searchType('GET');">조회 GET</button>
</div>

<div data-ax5grid="first-grid" data-ax5grid-config="{}" style="width:100%; height:316px;"></div>
</body>
<script type="text/javascript">
//<![CDATA
var firstGrid = null;

$(function () {
    /* 그리드 객체 생성 */
    firstGrid = new ax5.ui.grid();

    /* 그리드 설정 지정 */
    firstGrid.setConfig({
        target: $('[data-ax5grid="first-grid"]'),

        showLineNumber: false,
        showRowSelector: true,
        multipleSelect: false,
        lineNumberColumnWidth: 40,
        rowSelectorColumnWidth: 27,

        columns: [
            {key: "date", label: "날짜", align: "center", editor: {type: "date"}},
            {key: "type", label: "구분", align: "center", 
             editor: {
                type: "select", config: {
                    columnKeys: {
                        optionValue: "CD", optionText: "NM"
                    },
                    options: [
                        {CD: "O", NM: "O: 주유"},
                        {CD: "R", NM: "R: 정비"}
                    ]
                },
                disabled: function () {
                    return this.item.complete == "true";
                }
             }
            },
            {key: "amount", label: "<strong>주유량</strong>", align: "center", editor: {type: "number"}},
            {key: "mileage", label: "주행거리(km)", align: "center", editor: {type:"number"}},
            {key: "price", label: "금액(원)", formatter: "money", align: "center", editor: {type:"money"}},
            {key: "repair", label: "정비내역", align: "center", editor:{type: "text"}},
            {key: "complete", label: "완료", align: "center", editor:{type: "checkbox"}},
            {key: "note", label: "비고", align: "center", editor:{type: "textarea"}}
        ],
        page: {
            navigationItemCount: 9,
            height: 30,
            display: true,
            firstIcon: '|<',
            prevIcon: '<',
            nextIcon: '>',
            lastIcon: '>|',
            onChange: function () {
                search(this.page.selectPage);
            }
        },
    });
});

function search(_pageNo) {
	if($('#SearchForm').attr("method") == "POST") {
		searchPost(_pageNo);
	} else {
		searchGet(_pageNo);
	}
}

function searchGet(_pageNo) {
	$('#page').val(_pageNo||0);
	
	//var sendData = {"type":$('#type').val(), "complete":$('#complete').val(), page:$('#page').val()};
	var sendData = $('#SearchForm').serialize();
	console.log(sendData);
	
    $.ajax({
        type: "GET",
        url : "<c:url value='/searchGet.do' />",
        data: sendData,
        async: true,
        success : function(data, status, xhr) {
            console.log(data);
            firstGrid.setData({
                list: data.list,
                page: {
                    currentPage: _pageNo,
                    pageSize: 10,
                    totalElements: data.total,
                    totalPages: data.totalPages
                }
            });         
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
    });
}

function searchType(method) {
	$('#SearchForm').attr("method", method)
	console.log($('#SearchForm').attr("method"));
	search(0);
}
//]]>
</script>
</html>
