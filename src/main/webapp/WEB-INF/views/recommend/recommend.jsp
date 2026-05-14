<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickEat - 추천</title>

<style>
* {
	box-sizing: border-box;
	font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
}

body {
	margin: 0;
	background: #fff7ed;
	color: #111827;
}

.container {
	padding: 40px;
}

.recommend-wrap {
	display: grid;
	grid-template-columns: 280px 1fr 280px;
	gap: 30px;
	align-items: start;
}

.panel {
	background: #fff;
	border-radius: 20px;
	padding: 24px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
}

.title h1 {
	font-size: 36px;
	margin: 0 0 10px;
}

.title p {
	color: #6b7280;
	font-weight: 600;
}

.weather-recommend-box {
	margin-top: 18px;
	padding: 14px;
	border-radius: 16px;
	background: #fff7ed;
	border: 1px solid #ffe0c2;
}

.weather-recommend-box strong {
	display: block;
	font-size: 14px;
	margin-bottom: 10px;
	color: #111827;
}

.weather-recommend-chips {
	display: flex;
	flex-wrap: wrap;
	gap: 7px;
	color: #6b7280;
	font-size: 13px;
	font-weight: 700;
}

.weather-food-chip {
	background: #fff;
	border: 1px solid #ffd1a3;
	color: #ff6500;
	border-radius: 999px;
	padding: 6px 10px;
	font-size: 13px;
	font-weight: 900;
}

.input-row {
	display: flex;
	gap: 8px;
	margin-top: 20px;
}

.input-row input {
	flex: 1;
	height: 44px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 12px;
}

.input-row button {
	width: 44px;
	border: none;
	border-radius: 12px;
	background: #ff6500;
	color: #fff;
	font-size: 24px;
	cursor: pointer;
}

.chips {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	margin-top: 16px;
}

.chip {
	background: #f3f4f6;
	border-radius: 999px;
	padding: 8px 12px;
	font-size: 14px;
	font-weight: 700;
}

.chip button {
	border: none;
	background: none;
	margin-left: 6px;
	cursor: pointer;
	color: #999;
}

.count {
	margin-top: 24px;
	color: #999;
	font-weight: 700;
}

.clear-btn {
	width: 100%;
	height: 44px;
	margin-top: 16px;
	border: 1px solid #ddd;
	border-radius: 12px;
	background: white;
	font-weight: 800;
	cursor: pointer;
}

.wheel-area {
	text-align: center;
}

.wheel-box {
	position: relative;
	width: 420px;
	height: 420px;
	margin: 0 auto;
}

.pointer {
	position: absolute;
	top: -18px;
	left: 50%;
	transform: translateX(-50%);
	font-size: 44px;
	color: #ff6500;
	z-index: 20;
}

.wheel {
	position: relative;
	overflow: hidden;
	width: 420px;
	height: 420px;
	border-radius: 50%;
	border: 10px solid #ff9500;
	background: #fff3df;
	transition: transform 3s cubic-bezier(0.17, 0.67, 0.12, 0.99);
}

#wheelLabels {
	position: absolute;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0;
}

.wheel-label {
	position: absolute;
	left: 50%;
	top: 50%;
	width: 120px;
	margin-left: -60px;
	text-align: center;
	transform-origin: 60px 0;
	font-weight: 900;
	font-size: 17px;
	color: #111827;
	white-space: nowrap;
}

.center {
	position: absolute;
	z-index: 5;
	width: 130px;
	height: 130px;
	background: #fff;
	border-radius: 50%;
	box-shadow: 0 5px 18px rgba(0, 0, 0, 0.18);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 28px;
	font-weight: 900;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
}

.spin-btn {
	margin-top: 28px;
	width: 260px;
	height: 58px;
	border: none;
	border-radius: 18px;
	background: #ff6500;
	color: #fff;
	font-size: 20px;
	font-weight: 900;
	cursor: pointer;
}

.result-box {
	margin-top: 34px;
	background: #fff;
	border: 1px solid #ffe0c2;
	border-radius: 20px;
	padding: 28px;
	text-align: center;
}

.result-food {
	font-size: 42px;
	color: #ff6500;
	font-weight: 900;
}

.result-btn {
	display: inline-block;
	margin-top: 18px;
	background: #ff6500;
	color: white;
	padding: 12px 20px;
	border-radius: 12px;
	text-decoration: none;
	font-weight: 900;
}

.condition-card {
	border: 1px solid #eee;
	border-radius: 16px;
	padding: 18px;
	margin-bottom: 14px;
	background: #fff;
}

.condition-card strong {
	display: block;
	margin-bottom: 6px;
}

.condition-card span {
	color: #6b7280;
}

.condition-card select {
	width: 100%;
	height: 38px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 0 10px;
	font-weight: 800;
	color: #374151;
	background: #fff;
	outline: none;
}

.map-card {
	border: 1px solid #eee;
	border-radius: 16px;
	padding: 18px;
	background: #fff;
	margin-top: 10px;
}

.map-card strong {
	display: block;
	margin-bottom: 10px;
}

.location-search {
	display: flex;
	gap: 8px;
	margin-bottom: 12px;
}

.location-search input {
	flex: 1;
	height: 38px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 0 10px;
	font-size: 13px;
	font-weight: 700;
	outline: none;
}

.location-search input:focus {
	border-color: #ff6500;
}

.location-search button {
	width: 54px;
	border: none;
	border-radius: 10px;
	background: #ff6500;
	color: white;
	font-weight: 900;
	cursor: pointer;
}

#locationMap {
	width: 100%;
	height: 210px;
	border-radius: 14px;
	overflow: hidden;
	background: #f3f4f6;
}

.location-text {
	margin-top: 10px;
	font-size: 13px;
	color: #6b7280;
	font-weight: 700;
	line-height: 1.5;
}

.probability-guide {
	margin-top: 12px;
	font-size: 14px;
	font-weight: 700;
	color: #ff6500;
	text-align: center;
}
</style>
</head>

<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<main class="container">

		<section class="recommend-wrap">

			<aside class="panel">
				<div class="title">
					<h1>오늘 뭐 먹지? 🤔</h1>
					<p>먹고 싶은 후보를 입력하고 픽잇이 골라드릴게요!</p>

					<div class="weather-recommend-box">
						<strong id="weatherRecommendTitle">날씨별 추천 음식</strong>
						<div id="weatherRecommendChips" class="weather-recommend-chips">
							날씨 정보를 불러오는 중...
						</div>
					</div>
				</div>

				<h3>먹고 싶은 후보 입력</h3>

				<div class="input-row">
					<input id="foodInput" type="text" placeholder="예) 국밥, 짬뽕, 파스타">
					<button type="button" onclick="addFood()">+</button>
				</div>

				<div id="chips" class="chips"></div>

				<div class="count">
					등록된 후보 <span id="foodCount">0</span>/10
				</div>

				<button class="clear-btn" type="button" onclick="clearFoods()">
					🗑 전체 삭제
				</button>
			</aside>

			<section class="wheel-area">
				<div class="wheel-box">
					<div class="pointer">📍</div>

					<div id="wheel" class="wheel">
						<div id="wheelLabels"></div>
						<div class="center">
							PICK<br>IT!
						</div>
					</div>
				</div>

				<button class="spin-btn" type="button" onclick="spinWheel()">
					돌림판 돌리기! 🎡
				</button>

				<div class="probability-guide">
					✨ 설정한 조건과 가까운 메뉴일수록 추천 확률이 높아져요!
				</div>

				<div class="result-box">
					<h2>오늘의 선택은?</h2>
					<div id="resultFood" class="result-food">아직 없음</div>
					<p id="resultText">후보를 입력하고 돌림판을 돌려보세요.</p>
					<a id="resultLink" class="result-btn" href="#" style="display: none;">
						추천 결과 보기
					</a>
				</div>
			</section>

			<aside class="panel">
				<h3>추천 조건 설정</h3>

				<div class="condition-card">
					<strong>☁ 오늘 날씨</strong>
					<span id="weatherText">날씨 불러오는 중...</span>
				</div>

				<div class="condition-card">
					<strong>👤 상황</strong>
					<select id="situation">
						<option value="혼밥">혼밥</option>
						<option value="데이트">데이트</option>
						<option value="친구">친구</option>
						<option value="가족">가족</option>
						<option value="회식">회식</option>
					</select>
				</div>

				<div class="condition-card">
					<strong>🪙 가격대</strong>
					<select id="priceRange">
						<option value="가성비">가성비</option>
						<option value="보통">보통</option>
						<option value="고급">고급</option>
					</select>
				</div>

				<div class="condition-card">
					<strong>🌶 매운맛</strong>
					<select id="spicyLevel">
						<option value="안 매움">안 매움</option>
						<option value="보통">보통</option>
						<option value="매움">매움</option>
					</select>
				</div>

				<div class="condition-card">
					<strong>♡ 내 취향 불러오기</strong>
					<span>저장된 취향으로 빠르게 추천받기</span>
				</div>

				<div class="map-card">
					<strong>📍 내 위치</strong>

					<div class="location-search">
						<input id="locationKeyword" type="text"
							placeholder="예: 경남대, 창원시청, 마산합포구">
						<button type="button" onclick="searchLocation()">검색</button>
					</div>

					<div id="locationMap"></div>

					<div id="locationText" class="location-text">
						현재 위치를 불러오는 중...
					</div>
				</div>
			</aside>

		</section>

	</main>

	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1&libraries=services"></script>

	<script>
let foods = [];
let currentRotation = 0;
let isSpinning = false;
let currentWeather = "";
let currentLat = null;
let currentLng = null;

let map = null;
let marker = null;
let ps = null;

const colors = [
    "#ffe8b5", "#ffd4d4", "#e2d5ff", "#ffe7c2", "#d8f3dc",
    "#dbeafe", "#fde68a", "#fecaca", "#bbf7d0", "#bfdbfe"
];

function initMap(lat, lng) {
    currentLat = lat;
    currentLng = lng;

    const mapContainer = document.getElementById("locationMap");
    const mapOption = {
        center: new kakao.maps.LatLng(lat, lng),
        level: 4
    };

    map = new kakao.maps.Map(mapContainer, mapOption);

    marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(lat, lng)
    });

    marker.setMap(map);

    ps = new kakao.maps.services.Places();

    kakao.maps.event.addListener(map, "click", function(mouseEvent) {
        const clickedLat = mouseEvent.latLng.getLat();
        const clickedLng = mouseEvent.latLng.getLng();

        currentLat = clickedLat;
        currentLng = clickedLng;

        marker.setPosition(mouseEvent.latLng);
        map.setCenter(mouseEvent.latLng);

        document.getElementById("locationText").innerText =
            "선택한 위치 기준으로 추천을 진행합니다.";

        loadWeather(clickedLat, clickedLng);
    });
}

function searchLocation() {
    const keywordInput = document.getElementById("locationKeyword");
    const keyword = keywordInput.value.trim();

    if (keyword === "") {
        alert("검색할 위치를 입력해주세요.");
        return;
    }

    if (ps == null) {
        ps = new kakao.maps.services.Places();
    }

    ps.keywordSearch(keyword, function(data, status) {
        if (status === kakao.maps.services.Status.OK) {
            const lat = data[0].y;
            const lng = data[0].x;

            const moveLatLng = new kakao.maps.LatLng(lat, lng);

            currentLat = lat;
            currentLng = lng;

            map.setCenter(moveLatLng);
            marker.setPosition(moveLatLng);

            document.getElementById("locationText").innerText =
                keyword + " 기준으로 추천을 진행합니다.";

            loadWeather(lat, lng);
        } else {
            alert("검색 결과가 없습니다. 다른 위치명으로 검색해주세요.");
        }
    });
}

function getWeatherKeywords() {
    if (currentWeather.includes("비") || currentWeather.includes("눈") || currentWeather.includes("빗방울")) {
        return ["국밥", "찌개", "라면", "짬뽕", "우동", "칼국수", "탕", "전골",
            "부대찌개", "김치찌개", "순두부찌개", "감자탕", "해장국", "곰탕",
            "설렁탕", "쌀국수", "마라탕", "샤브샤브", "수제비", "떡볶이"];
    }

    if (currentWeather.includes("흐림") || currentWeather.includes("구름")) {
        return ["국밥", "찌개", "파스타", "분식", "김치찌개", "부대찌개",
            "돈까스", "제육볶음", "김밥", "덮밥", "카레", "비빔밥",
            "칼국수", "쌀국수", "햄버거", "피자", "떡볶이", "순대국",
            "샌드위치", "볶음밥"];
    }

    if (currentWeather.includes("맑음")) {
        return ["초밥", "샐러드", "파스타", "냉면", "덮밥", "햄버거", "피자",
            "김밥", "샌드위치", "쌀국수", "포케", "브런치", "타코",
            "돈까스", "비빔밥", "메밀소바", "막국수", "카레", "텐동",
            "스테이크", "치킨"];
    }

    return [];
}

function renderWeatherRecommendFoods() {
    const title = document.getElementById("weatherRecommendTitle");
    const chips = document.getElementById("weatherRecommendChips");

    const keywords = getWeatherKeywords();

    if (keywords.length === 0) {
        title.innerText = "날씨별 추천 음식";
        chips.innerHTML = "추천 음식을 불러올 수 없어요.";
        return;
    }

    title.innerText = currentWeather + " 날씨에 어울리는 음식";
    chips.innerHTML = "";

    keywords.forEach(function(food) {
        chips.innerHTML += '<span class="weather-food-chip">' + food + '</span>';
    });
}

function renderFoods() {
    const chips = document.getElementById("chips");
    const foodCount = document.getElementById("foodCount");

    chips.innerHTML = "";

    foods.forEach(function(food, index) {
        const chip = document.createElement("span");
        chip.className = "chip";
        chip.innerHTML = food + '<button type="button">x</button>';

        chip.querySelector("button").addEventListener("click", function() {
            removeFood(index);
        });

        chips.appendChild(chip);
    });

    foodCount.innerText = foods.length;
    renderWheel();
}

function renderWheel() {
    const wheel = document.getElementById("wheel");
    const wheelLabels = document.getElementById("wheelLabels");

    wheelLabels.innerHTML = "";

    if (foods.length === 0) {
        wheel.style.background = "#fff3df";
        return;
    }

    const slice = 360 / foods.length;
    let gradient = "conic-gradient(";

    foods.forEach(function(food, index) {
        const start = slice * index;
        const end = slice * (index + 1);

        gradient += colors[index % colors.length] + " " + start + "deg " + end + "deg";

        if (index !== foods.length - 1) {
            gradient += ", ";
        }

        const labelAngle = start + slice / 2;

        wheelLabels.innerHTML +=
            '<div class="wheel-label" style="' +
            'transform: rotate(' + labelAngle + 'deg) translateY(-150px) rotate(90deg);' +
            '">' + food + '</div>';
    });

    gradient += ")";
    wheel.style.background = gradient;
}

function addFood() {
    if (isSpinning) return;

    const input = document.getElementById("foodInput");
    const value = input.value.trim();

    if (value === "") {
        alert("음식 후보를 입력해주세요.");
        return;
    }

    if (foods.length >= 10) {
        alert("후보는 최대 10개까지 가능합니다.");
        return;
    }

    foods.push(value);
    input.value = "";
    renderFoods();
}

function removeFood(index) {
    if (isSpinning) return;

    foods.splice(index, 1);
    renderFoods();
}

function clearFoods() {
    if (isSpinning) return;

    foods = [];
    currentRotation = 0;

    const wheel = document.getElementById("wheel");
    wheel.style.transform = "rotate(0deg)";

    renderFoods();

    document.getElementById("resultFood").innerText = "아직 없음";
    document.getElementById("resultText").innerText = "후보를 입력하고 돌림판을 돌려보세요.";
    document.getElementById("resultLink").style.display = "none";
}

function getConditionBasedIndex() {
    if (foods.length === 0) {
        return -1;
    }

    const weatherKeywords = getWeatherKeywords();

    const situation = document.getElementById("situation").value;
    const priceRange = document.getElementById("priceRange").value;
    const spicyLevel = document.getElementById("spicyLevel").value;

    let weightedFoods = [];

    foods.forEach(function(food, index) {
        weightedFoods.push(index);

        weatherKeywords.forEach(function(keyword) {
            if (food.includes(keyword)) {
                weightedFoods.push(index);
                weightedFoods.push(index);
            }
        });

        if (situation === "혼밥") {
            ["국밥", "라면", "김밥", "덮밥", "햄버거", "쌀국수", "분식"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }

        if (situation === "데이트") {
            ["파스타", "스테이크", "초밥", "브런치", "샐러드", "피자", "리조또", "와인바"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }

        if (situation === "친구") {
            ["치킨", "피자", "떡볶이", "햄버거", "마라탕", "곱창", "삼겹살"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }

        if (situation === "가족") {
            ["백반", "갈비", "샤브샤브", "한정식", "삼겹살", "국밥", "전골"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }

        if (situation === "회식") {
            ["삼겹살", "곱창", "치킨", "족발", "보쌈", "전골", "회", "갈비"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }

        if (priceRange === "가성비") {
            ["김밥", "국밥", "라면", "분식", "덮밥", "햄버거", "백반", "칼국수"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                }
            });
        }

        if (priceRange === "고급") {
            ["스테이크", "오마카세", "초밥", "한우", "샤브샤브", "파스타", "한정식"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                }
            });
        }

        if (spicyLevel === "매움") {
            ["짬뽕", "마라탕", "떡볶이", "불닭", "제육", "닭발", "매운탕", "낙곱새"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }

        if (spicyLevel === "안 매움") {
            ["초밥", "샐러드", "돈까스", "햄버거", "파스타", "브런치", "냉면", "쌀국수"].forEach(function(keyword) {
                if (food.includes(keyword)) {
                    weightedFoods.push(index);
                    weightedFoods.push(index);
                }
            });
        }
    });

    const random = Math.floor(Math.random() * weightedFoods.length);
    return weightedFoods[random];
}

function spinWheel() {
    if (foods.length < 2) {
        alert("후보를 2개 이상 입력해주세요.");
        return;
    }

    if (currentLat == null || currentLng == null) {
        alert("위치를 먼저 선택하거나 검색해주세요.");
        return;
    }

    if (isSpinning) return;
    isSpinning = true;

    let selectedIndex = getConditionBasedIndex();

    if (selectedIndex === -1) {
        selectedIndex = Math.floor(Math.random() * foods.length);
    }

    const selectedFood = foods[selectedIndex];

    const slice = 360 / foods.length;
    const selectedCenterAngle = selectedIndex * slice + slice / 2;
    const rotateToPointer = -selectedCenterAngle;

    const normalizedCurrent = ((currentRotation % 360) + 360) % 360;
    const normalizedTarget = ((rotateToPointer % 360) + 360) % 360;

    let correction = normalizedTarget - normalizedCurrent;

    if (correction < 0) {
        correction += 360;
    }

    currentRotation += 360 * 5 + correction;

    const wheel = document.getElementById("wheel");
    wheel.style.transform = "rotate(" + currentRotation + "deg)";

    setTimeout(function() {
        document.getElementById("resultFood").innerText = selectedFood;
        document.getElementById("resultText").innerText =
            selectedFood + " 기준으로 주변 맛집을 추천해드릴게요.";

        const situation = document.getElementById("situation").value;
        const priceRange = document.getElementById("priceRange").value;
        const spicyLevel = document.getElementById("spicyLevel").value;

        const link = document.getElementById("resultLink");
        link.href = "${contextPath}/recommend/result?selectedFood=" + encodeURIComponent(selectedFood)
            + "&lat=" + encodeURIComponent(currentLat)
            + "&lng=" + encodeURIComponent(currentLng)
            + "&weather=" + encodeURIComponent(currentWeather)
            + "&situation=" + encodeURIComponent(situation)
            + "&priceRange=" + encodeURIComponent(priceRange)
            + "&spicyLevel=" + encodeURIComponent(spicyLevel);

        link.style.display = "inline-block";

        isSpinning = false;
    }, 3000);
}

function loadWeather(lat, lng) {
    fetch("${contextPath}/api/weather?lat=" + lat + "&lng=" + lng)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            currentWeather = data.weatherText;
            document.getElementById("weatherText").innerText = data.weatherText;
            renderWeatherRecommendFoods();
        })
        .catch(function(error) {
            currentWeather = "";
            document.getElementById("weatherText").innerText = "날씨 정보 없음";
            renderWeatherRecommendFoods();
        });
}

document.getElementById("foodInput").addEventListener("keydown", function(e) {
    if (e.key === "Enter") {
        addFood();
    }
});

document.getElementById("locationKeyword").addEventListener("keydown", function(e) {
    if (e.key === "Enter") {
        searchLocation();
    }
});

renderWheel();

if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        function(position) {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;

            initMap(lat, lng);
            loadWeather(lat, lng);

            document.getElementById("locationText").innerText =
                "현재 위치 기준으로 추천을 진행합니다. 위치가 다르면 검색하거나 지도를 클릭해 바꿔주세요.";
        },
        function(error) {
            currentWeather = "";
            document.getElementById("weatherText").innerText = "위치 권한이 필요해요";
            document.getElementById("locationText").innerText =
                "위치를 허용하거나 위 검색창에 지역명을 입력해주세요.";

            renderWeatherRecommendFoods();

            initMap(35.23625957158495, 128.57829025641476);
        }
    );
} else {
    currentWeather = "";
    document.getElementById("weatherText").innerText = "위치 기능을 지원하지 않아요";
    document.getElementById("locationText").innerText =
        "위 검색창에 지역명을 입력해주세요.";

    renderWeatherRecommendFoods();

}
</script>

	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>