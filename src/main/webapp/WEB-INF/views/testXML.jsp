<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script type="text/javascript"
	src="/json/resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/json/resources/js/xml2json.js"></script>
<script type="text/javascript"
	src="/json/resources/js/jquery.xdomainajax.js"></script>
<link href="https://vjs.zencdn.net/5.16.0/video-js.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="https://s3.amazonaws.com/videojs-test/videojs.vast.vpaid.min.css" />
<script src="https://vjs.zencdn.net/5.16.0/video.js"></script>
<script src="/test/resources/ad/videojs-contrib-ads.js"></script>
<script type="text/javascript" src="/json/resources/js/c5.js"></script>

<script type="text/javascript">
	//<![CDATA[
	var tag;
	$.ajax({
		url : "http://175.125.132.121:8080/test/server/data",
		type : 'GET',
		dataType : 'xml',
		success : function(res) {
			tag = res.responseText;
			//tag = res.documentElement.outerHTML;
			alert(tag);
			console.log(tag);
		}
	});

	$(document).ready(function() {

		var videoPlayer = videojs("my-video", {
			controls : true,
			controlBar : {
				muteToggle : false,
			},
			preload : 'auto'
		});

		setTimeout(function() {
			videoPlayer.src("/test/resources/sample.mp4");
			videoPlayer.vastClient({
				//adTagUrl : getAdsUrl,
				adTagXML : requestVASTXML,
				postroll : true,
				adsEnabled : true,
				playAdAlways : true,
				adCancelTimeout : 5000,
				verbosity : 4
			});

		}, 100);

		videoPlayer.on('reset', function() {
			if (videoPlayer.vast.isEnabled()) {
				console.log("hel");
				videoPlayer.vast.enable();
			} else {
				console.log("hel2");
				videoPlayer.vast.disable();
			}

		});

		function requestVASTXML(callback) {
			//The setTimeout below is to simulate asynchrony
			setTimeout(function() {
				console.log("tag : = " + tag);
				callback(null, tag);
			}, 0);
		}

	});

	//]]>
</script>
</head>
<body>
	<video id="my-video" class="video-js vjs-default-skin" controls
		width="640" height="264"></video>


</body>
</html>