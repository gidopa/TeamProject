<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3c29da2f6671b03a9a59ab781530365d&libraries=services,clusterer,drawing"></script>
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
	font-family: 'Roboto', sans-serif;
}

.content-wrapper {
	display: flex;
	justify-content: space-between;
}

.container {
	width: 45%;
	margin: 20px;
}

.evt-map {
	height: 300px;
	border: solid 1px #eee;
}

.text-content {
	padding: 20px;
	background-color: #f9f9f9;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	margin: 20px;
	font-size: 16px;
	line-height: 1.6;
}
</style>
</head>
<body>

<div class="content-wrapper">
	<div class="container evt-map" id="map"></div>
	<div class="container text-content">
		<h1>찾아오시는 길</h1>
		<p class="address">부산광역시 부산진구 신천대로50번길 79</p>
		<p>안녕하세요. 오늘은 어떤 하루를 보내고 계신가요? 예전에, 문득 게임을 하다가 '나도 이런 게임을 만들고
		싶다'라는 생각을 했고, 게임 개발을 배우기 위해 이곳 저곳을 알아보았으나, 비싼 교육비와 참여하기 힘든 국비교육으로 마음을
		접어야 했습니다. 하지만 이런 불편함을 겪는 사람은 저 뿐만이 아니었고, 배우고 싶은 것을 마음대로 배울 수 없는 현실을
		극복하고 싶었습니다...</p>
	</div>
</div>

<script>
var map = {
	item : {},
	load : function(id, options) {
		var thisObj = this;
		if (typeof id == 'undefined') {
			return false;
		}
		if (typeof options == 'undefined') {
			options = {};
		}
		if (typeof options.lat == 'undefined') {
			options.lat = 35.15425;
		}
		if (typeof options.lng == 'undefined') {
			options.lng = 129.0598;
		}
		if (typeof options.level == 'undefined') {
			options.level = 3;
		}

		var mapOptions = {
			center : new kakao.maps.LatLng(options.lat, options.lng),
			level : options.level
		}

		thisObj.item[id] = new kakao.maps.Map(document.getElementById(id), mapOptions);

		var marker = new kakao.maps.Marker({
			position : new kakao.maps.LatLng(options.lat, options.lng)
		});

		marker.setMap(thisObj.item[id]);
	},
};
$(document).ready(function(e) {
	map.load('map', {});
});
</script>
</body>
</html>
