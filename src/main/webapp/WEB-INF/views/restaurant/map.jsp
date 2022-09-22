<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>


	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=9rc7grmbqo&submodules=geocoder"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link rel="shortcut icon"
		href="${pageContext.request.contextPath }/resources/image/favicon.ico">
	
	<!-- <div id="map" style="width: 1000px; height: 400px;"></div> -->
	<div class="search">
		<input id="address" type="text"  placeholder="검색할 주소">
		<input id="submit" type="button" value="주소검색">
	</div>
	<div id="map" style="width:1000px;height:800px; margin: 0 auto;"></div>
	
	<script>
	/* $(function() {
		
		initMap();
		
	});

	function initMap() {
		
		const markers = new Array();
		const infoWindows = new Array();
		
		var map = new naver.maps.Map('map', {
	        center: new naver.maps.LatLng(lng, lat),
	        zoom: 15
	    });
		
	    var marker = new naver.maps.Marker({
	        map: map,
	        title: "남산서울타워",
	        position: new naver.maps.LatLng(lng, lat),
	        icon : {
	        	content: '<img src="<c:url value="/resources/image/mark.png"/>" alt="" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; max-width: none; max-height: none; -webkit-user-select: none; position: absolute; width: 32px; height: 32px; left: 0px; top: 0px;">',
	        	size : new naver.maps.Size(32, 32),
	        	anchor : new naver.maps.Point(16, 32)
	        }
	    });
	
	
		var infoWindow = new naver.maps.InfoWindow({
	        content: '<div style="width:200px;text-align:center;padding:10px;"><b>서울남산타워</b><br> - 네이버 지도 - </div>'
	 	}); 
		
		markers.push(marker);
		infoWindows.push(infoWindow);
		
		function getClickHandler(seq){
			
			return function(){
				var marker = markers[seq],
					infoWindow = infoWindows[seq];
				
				if (infoWindow.getMap()){
					infoWindow.close();
				} else {
					infoWindow.open(map, marker);
				}
			}
		}
		
		for(var i = 0 ; i < markers.length ; i++){
			console.log(markers[i], getClickHandler(i));
			naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
		}
	
	
		selectMapList();
		
		function searchAddressToCoordinate(address) {
		    naver.maps.Service.geocode({
		        query: address
		    }, function(status, response) {
		        if (status === naver.maps.Service.Status.ERROR) {
		            return alert('Something Wrong!');
		        }
		        if (response.v2.meta.totalCount === 0) {
		            return alert('올바른 주소를 입력해주세요.');
		        }
		        var htmlAddresses = [],
		            item = response.v2.addresses[0],
		            point = new naver.maps.Point(item.x, item.y);
		        if (item.roadAddress) {
		            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		        }
		        if (item.jibunAddress) {
		            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
		        }
		        if (item.englishAddress) {
		            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
		        }
	
		        insertAddress(item.roadAddress, item.x, item.y);
		        
		    });
		}
		
		$('#address').on('keydown', function(e) {
		    var keyCode = e.which;
		    if (keyCode === 13) { // Enter Key
		        searchAddressToCoordinate($('#address').val());
		    }
		});
		$('#submit').on('click', function(e) {
		    e.preventDefault();
		    searchAddressToCoordinate($('#address').val());
		});
		var lat;
		var lng;
		function initGeocoder() {
		    var latlng = map.getCenter();
		    var utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng); // 위/경도 -> UTMK
		    var tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk);   // UTMK -> TM128
		    var naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128); // TM128 -> NAVER
	
		    infoWindow = new naver.maps.InfoWindow({
		        content: ''
		    });
	
		    map.addListener('click', function(e) {
		        var latlng = e.coord,
		            utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng),
		            tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk),
		            naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128);
	
		        utmk.x = parseFloat(utmk.x.toFixed(1));
		        utmk.y = parseFloat(utmk.y.toFixed(1));
	
		        infoWindow.setContent([
		            '<div style="padding:10px;width:380px;font-size:14px;line-height:20px;">',
		            '<strong>LatLng</strong> : '+ '좌 클릭 지점 위/경도 좌표' +'<br />',
		            '<strong>UTMK</strong> : '+ '위/경도 좌표를 UTMK 좌표로 변환한 값' +'<br />',
		            '<strong>TM128</strong> : '+ '변환된 UTMK 좌표를 TM128 좌표로 변환한 값' +'<br />',
		            '<strong>NAVER</strong> : '+ '변환된 TM128 좌표를 NAVER 좌표로 변환한 값' +'<br />',
		            '</div>'
		        ].join(''));
	
		        infoWindow.open(map, latlng);
		        console.log('LatLng: ' + latlng.toString());
		        console.log('UTMK: ' + utmk.toString());
		        console.log('TM128: ' + tm128.toString());
		        console.log('NAVER: ' + naverCoord.toString());
		        
		        lat = latlng.y;
	            lng = latlng.x;
		    });
		}
	
		naver.maps.onJSContentLoaded = initGeocoder;
		
		
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
		
		function insertAddress(address, lat, lng) {
			var mapList = "";
			mapList += "<tr>"
			mapList += "	<td>" + address + "</td>"
			mapList += "	<td>" + latitude + "</td>"
			mapList += "	<td>" + longitude + "</td>"
			mapList += "</tr>"
	
			$('#mapList').append(mapList);	
	
			var map = new naver.maps.Map('map', {
			    center: new naver.maps.LatLng(lng, lat),
			    zoom: 15
			});
		    var marker = new naver.maps.Marker({
		        map: map,
		        position: new naver.maps.LatLng(lng, lat),
		    });
		}
		
		function selectMapList() {
			var map = new naver.maps.Map('map', {
			    center: new naver.maps.LatLng(lng, lat),
			    zoom: 15
			});
		}
		
		function moveMap(len, lat) {
			var mapOptions = {
				    center: new naver.maps.LatLng(lng, lat),
				    zoom: 15,
				    mapTypeControl: true
				};
		    var map = new naver.maps.Map('map', mapOptions);
		    var marker = new naver.maps.Marker({
		        position: new naver.maps.LatLng(lng, lat),
		        map: map
		    });
		}
	} */
	
	
	/* function initMap(){
		var pointX;
		var pointY;
		var changeXY = naver.maps.Service.geocode({
			//query : '${restaurant.address}'
			address : '${restaurant.address}'
		}, function(status, response){
			console.log(response);
			if(status != naver.maps.Service.Status.OK){
				return alert('WRONG!');
			}
			
			var result = response.result;
			var items = result.items;
			var point = items[0].point;
			pointX = point.x;
			pointY = point.y;
			
		});
		
		var addr = '${restaurant.address}';
		console.log("가게 주소는 ", addr);
		
		var map = new naver.maps.Map('map', {
//			center : new naver.maps.LatLng(37.55, 126.98),
			center : new naver.maps.LatLng(pointX, pointY),
			zoom : 15
		});
		console.log(map);
		var marker = new naver.maps.Marker({
			map : map,
//			position : new naver.maps.LatLng(37.55, 126.98)
			position : new naver.maps.LatLng(pointX, pointY)
		});
	}
	var marker = new naver.maps.Marker('map', initMap()); */
	
	// 지도 좌표 나옴 console 출력
    /*var map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(37.5666103, 126.9783882),
        zoom: 15
    });
    var infoWindow = null;
    
   	var lat;
   	var lng;
    function initGeocoder() {
    	var latlng = map.getCenter;
    	var utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng);
    	var tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk);
    	var naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128);
    	
    	infoWindow = new naver.maps.InfoWindow({
    		content : ''
    	});
    	
    	map.addListener('click', (e) => {
    		var latlng = e.coord;
    		var utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng);
    		var tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk);
        	var naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128);
        	
        	utmk.x = parseFloat(utmk.x.toFixed(1));
        	utmk.y = parseFloat(utmk.y.toFixed(1));
        	
        	infoWindow.setContent([
                '<div style="padding:10px;width:380px;font-size:14px;line-height:20px;">',
                '<strong>LatLng</strong> : '+ '좌 클릭 지점 위/경도 좌표' +'<br />',
                '<strong>UTMK</strong> : '+ '위/경도 좌표를 UTMK 좌표로 변환한 값' +'<br />',
                '<strong>TM128</strong> : '+ '변환된 UTMK 좌표를 TM128 좌표로 변환한 값' +'<br />',
                '<strong>NAVER</strong> : '+ '변환된 TM128 좌표를 NAVER 좌표로 변환한 값' +'<br />',
                '</div>'
            ].join(''));
        	
        	infoWindow.open(map, latlng);
        	// console.log('LatLng: ' + latlng.toString());
            //console.log('UTMK: ' + utmk.toString());
            //console.log('TM128: ' + tm128.toString());
            //console.log('NAVER: ' + naverCoord.toString()); 
            
            lat = latlng.y;
            lng = latlng.x;
        	console.log('map: ' + map + ', lat ' + lat + ', lng: ' + lng);
            
            
    	});
    }
    
    naver.maps.onJSContentLoaded = initGeocoder;*/
    
    
    
    
    
    
    
    
    
    
    
    var map = new naver.maps.Map("map", {
   	  center: new naver.maps.LatLng(37.3595316, 127.1052133),
   	  zoom: 15,
   	  mapTypeControl: true
   	});

   	var infoWindow = new naver.maps.InfoWindow({
   	  anchorSkew: false
   	});

   	map.setCursor('pointer');

   	/* function searchCoordinateToAddress(latlng) {

   	  infoWindow.close();

   	  naver.maps.Service.reverseGeocode({
   	    coords: latlng,
   	    orders: [
   	      naver.maps.Service.OrderType.ADDR,
   	      naver.maps.Service.OrderType.ROAD_ADDR
   	    ].join(',')
   	  }, function(status, response) {
   	    if (status === naver.maps.Service.Status.ERROR) {
   	      if (!latlng) {
   	        return alert('ReverseGeocode Error, Please check latlng');
   	      }
   	      if (latlng.toString) {
   	        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
   	      }
   	      if (latlng.x && latlng.y) {
   	        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
   	      }
   	      return alert('ReverseGeocode Error, Please check latlng');
   	    }

   	    var address = response.v2.address,
   	        htmlAddresses = [];

   	    if (address.jibunAddress !== '') {
   	        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
   	    }

   	    if (address.roadAddress !== '') {
   	        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
   	    }

   	    infoWindow.setContent([
   	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
   	      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
   	      htmlAddresses.join('<br />'),
   	      '</div>'
   	    ].join('\n'));

   	    infoWindow.open(map, latlng);
   	  });
   	} */

   	//const address = ${restaurant.address};
   var map = new naver.maps.Map("map", {
	  center: new naver.maps.LatLng(37.3595316, 127.1052133),
	  zoom: 15,
	  mapTypeControl: true
	});
	
	var infoWindow = new naver.maps.InfoWindow({
	  anchorSkew: true
	});
	
	map.setCursor('pointer');
	
	function searchCoordinateToAddress(latlng) {
	
	  infoWindow.close();
	
	  naver.maps.Service.reverseGeocode({
	    coords: latlng,
	    orders: [
	      naver.maps.Service.OrderType.ADDR,
	      naver.maps.Service.OrderType.ROAD_ADDR
	    ].join(',')
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!latlng) {
	        return alert('ReverseGeocode Error, Please check latlng');
	      }
	      if (latlng.toString) {
	        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
	      }
	      if (latlng.x && latlng.y) {
	        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
	      }
	      return alert('ReverseGeocode Error, Please check latlng');
	    }
	
	    var address = response.v2.address,
	        htmlAddresses = [];
	
	    if (address.jibunAddress !== '') {
	        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
	    }
	
	    if (address.roadAddress !== '') {
	        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
	    }
	
	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
	      htmlAddresses.join('<br />'),
	      '</div>'
	    ].join('\n'));
	
	    infoWindow.open(map, latlng);
	  });
	}
	
	function searchAddressToCoordinate(address) {
	  naver.maps.Service.geocode({
	    query: address
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!address) {
	        return alert('Geocode Error, Please check address');
	      }
	      return alert('Geocode Error, address:' + address);
	    }
	
	    if (response.v2.meta.totalCount === 0) {
	      return alert('No result.');
	    }
	
	    var htmlAddresses = [],
	      item = response.v2.addresses[0],
	      point = new naver.maps.Point(item.x, item.y);
	
	    if (item.roadAddress) {
	      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	    }
	
	    if (item.jibunAddress) {
	      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	    }
	
	    if (item.englishAddress) {
	      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	    }
	
	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
	      htmlAddresses.join('<br />'),
	      '</div>'
	    ].join('\n'));
	
	    map.setCenter(point);
	    infoWindow.open(map, point);
	  });
	}
	
	function initGeocoder() {
	  map.addListener('click', function(e) {
	    searchCoordinateToAddress(e.coord);
	  });
	
	  $('#address').on('keydown', function(e) {
	    var keyCode = e.which;
	
	    if (keyCode === 13) { // Enter Key
	      searchAddressToCoordinate($('#address').val());
	    }
	  });
	
	  $('#submit').on('click', function(e) {
	    e.preventDefault();
	
	    searchAddressToCoordinate($('#address').val());
	  });
	
	  searchAddressToCoordinate('${restaurant.address}');
	}
	
	naver.maps.onJSContentLoaded = initGeocoder;
    
    
	</script>
