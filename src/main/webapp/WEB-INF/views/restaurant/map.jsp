<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>픽잇 - 맛집 지도</title>

<style>
* {
    box-sizing: border-box;
    font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
}

body {
    margin: 0;
    background: #f9fafb;
    color: #111827;
}

a {
    text-decoration: none;
    color: inherit;
}

.header {
    height: 70px;
    background: #fff;
    border-bottom: 1px solid #eee;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 42px;
}

.logo {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 28px;
    font-weight: 900;
}

.logo-icon {
    width: 22px;
    height: 28px;
    background: #ff6500;
    border-radius: 50% 50% 50% 0;
    transform: rotate(-45deg);
    position: relative;
}

.logo-icon::before {
    content: "";
    width: 8px;
    height: 8px;
    background: white;
    border-radius: 50%;
    position: absolute;
    top: 8px;
    left: 7px;
}

.nav {
    display: flex;
    gap: 40px;
    font-weight: 800;
}

.nav a.active {
    color: #ff6500;
}

.container {
    padding: 34px 42px;
}

.page-title {
    display: flex;
    justify-content: space-between;
    align-items: end;
    margin-bottom: 24px;
}

.page-title h1 {
    font-size: 34px;
    margin: 0;
}

.page-title p {
    color: #6b7280;
    margin: 8px 0 0;
}

.view-btn {
    background: #ff6500;
    color: #fff;
    padding: 14px 20px;
    border-radius: 14px;
    font-weight: 900;
}

.layout {
    display: grid;
    grid-template-columns: 390px 1fr;
    gap: 24px;
}

.side {
    background: #fff;
    border-radius: 24px;
    box-shadow: 0 16px 42px rgba(0,0,0,0.08);
    overflow: hidden;
    height: 600px;
}

.side-header {
    padding: 22px;
    border-bottom: 1px solid #eee;
}

.side-header strong {
    color: #ff6500;
}

.search-box {
    margin-top: 16px;
    display: flex;
    gap: 8px;
}

.search-box input {
    flex: 1;
    height: 42px;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    padding: 0 14px;
    font-size: 14px;
    font-weight: 700;
    outline: none;
}

.search-box input:focus {
    border-color: #ff6500;
    box-shadow: 0 0 0 3px rgba(255, 101, 0, 0.12);
}

.search-box button {
    width: 68px;
    border: none;
    border-radius: 12px;
    background: #ff6500;
    color: white;
    font-size: 13px;
    font-weight: 900;
    cursor: pointer;
}

.search-box button:hover {
    background: #e85d00;
}

.search-help {
    margin-top: 10px;
    font-size: 12px;
    color: #6b7280;
    font-weight: 700;
}

.restaurant-list {
    overflow-y: auto;
    height: calc(100% - 150px);
}

.item {
    display: flex;
    gap: 14px;
    padding: 18px;
    border-bottom: 1px solid #eee;
    cursor: pointer;
    transition: 0.2s ease;
}

.item:hover {
    background: #fff7f0;
}

.rank {
    width: 32px;
    height: 32px;
    background: #ff6500;
    color: #fff;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 900;
    flex-shrink: 0;
}

.item-info h3 {
    margin: 0 0 8px;
    font-size: 18px;
}

.category {
    display: inline-block;
    background: #fff3e8;
    color: #ff6500;
    padding: 5px 10px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 900;
    margin-bottom: 8px;
    max-width: 220px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.rating {
    color: #ff9500;
    font-weight: 900;
    font-size: 14px;
}

.address {
    margin-top: 6px;
    font-size: 13px;
    color: #6b7280;
    font-weight: 700;
    line-height: 1.5;
}

.no-result {
    display: none;
    padding: 34px 20px;
    text-align: center;
    color: #6b7280;
    font-weight: 800;
}

.map-wrap {
    background: #fff;
    border-radius: 24px;
    padding: 18px;
    box-shadow: 0 16px 42px rgba(0,0,0,0.08);
    height: 600px;
}

#map {
    width: 100%;
    height: 100%;
    border-radius: 18px;
}

.overlay-card {
    width: 220px;
    background: white;
    border-radius: 18px;
    padding: 16px;
    box-shadow: 0 10px 26px rgba(0,0,0,0.15);
    border: 1px solid #eee;
}

.overlay-title {
    font-size: 16px;
    font-weight: 900;
    margin-bottom: 6px;
}

.overlay-category {
    font-size: 13px;
    color: #6b7280;
    margin-bottom: 8px;
    max-width: 180px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.overlay-rating {
    color: #ff6500;
    font-weight: 900;
    margin-bottom: 10px;
}

.overlay-btn {
    display: inline-block;
    background: #ff6500;
    color: white;
    padding: 8px 12px;
    border-radius: 10px;
    font-size: 13px;
    font-weight: 800;
}

@media (max-width: 1000px) {
    .layout {
        grid-template-columns: 1fr;
    }

    .side, .map-wrap {
        height: 520px;
    }

    .nav {
        display: none;
    }

    .restaurant-list {
        height: calc(100% - 150px);
    }
}
</style>
</head>

<body>

<%@ include file = "/WEB-INF/views/header.jsp" %>

<main class="container">

    <div class="page-title">
        <div>
            <h1>맛집 지도</h1>
            <p>지도에서 등록된 맛집 위치를 한눈에 확인해보세요.</p>
        </div>

        <a class="view-btn" href="${contextPath}/restaurants">리스트 보기</a>
    </div>

    <section class="layout">

        <aside class="side">
            <div class="side-header">
                총 <strong id="visibleCount">${mapList.size()}</strong>개의 맛집이 있습니다.

                <div class="search-box">
                    <input type="text" id="mapSearchInput"
                        placeholder="맛집명, 카테고리, 주소 검색"
                        onkeyup="filterRestaurants()">

                    <button type="button" onclick="resetSearch()">초기화</button>
                </div>

                <div class="search-help">
                    검색어와 일치하는 맛집만 지도와 목록에 표시됩니다.
                </div>
            </div>

            <div class="restaurant-list" id="restaurantList">

                <div class="no-result" id="noResult">
                    검색 결과가 없습니다.
                </div>

                <c:forEach var="r" items="${mapList}" varStatus="status">

                    <div class="item"
                        data-index="${status.index}"
                        data-name="${r.name}"
                        data-category="${r.categoryName}"
                        data-address="${r.address}"
                        onclick="moveToMarker('${status.index}')">

                        <div class="rank">${status.index + 1}</div>

                        <div class="item-info">
                            <h3>${r.name}</h3>

                            <div class="category" title="${r.categoryName}">
                                ${r.categoryName}
                            </div>

                            <div class="rating">★ ${r.rating}</div>

                            <div class="address">${r.address}</div>
                        </div>
                    </div>

                </c:forEach>

            </div>
        </aside>

        <section class="map-wrap">
            <div id="map"></div>
        </section>

    </section>

</main>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a87f90deda3136d9524a194c121dcf1"></script>

<script>
    var mapContainer = document.getElementById('map');

    var mapOption = {
        center: new kakao.maps.LatLng(37.5665, 126.9780),
        level: 5
    };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    var bounds = new kakao.maps.LatLngBounds();

    var markers = [];
    var overlays = [];
    var positions = [];

    <c:forEach var="r" items="${mapList}" varStatus="status">

        <c:if test="${not empty r.latitude and not empty r.longitude}">

            var markerPosition${status.index} =
                new kakao.maps.LatLng(${r.latitude}, ${r.longitude});

            var marker${status.index} = new kakao.maps.Marker({
                position: markerPosition${status.index}
            });

            marker${status.index}.setMap(map);

            bounds.extend(markerPosition${status.index});

            markers[${status.index}] = marker${status.index};
            positions[${status.index}] = markerPosition${status.index};

            var overlayContent${status.index} = `
                <div class="overlay-card">
                    <div class="overlay-title">
                        ${r.name}
                    </div>

                    <div class="overlay-category" title="${r.categoryName}">
                        ${r.categoryName}
                    </div>

                    <div class="overlay-rating">
                        ★ ${r.rating}
                    </div>

                    <a class="overlay-btn"
                       href="${contextPath}/restaurants/${r.restaurantId}">
                        상세보기
                    </a>
                </div>
            `;

            var overlay${status.index} = new kakao.maps.CustomOverlay({
                content: overlayContent${status.index},
                position: markerPosition${status.index},
                yAnchor: 1.3
            });

            overlays[${status.index}] = overlay${status.index};

            kakao.maps.event.addListener(marker${status.index}, 'click', function() {
                closeAllOverlay();

                overlay${status.index}.setMap(map);

                map.panTo(markerPosition${status.index});
            });

        </c:if>

    </c:forEach>

    if (markers.length > 0) {
        map.setBounds(bounds);
    }

    function closeAllOverlay() {
        for (var i = 0; i < overlays.length; i++) {
            if (overlays[i]) {
                overlays[i].setMap(null);
            }
        }
    }

    function moveToMarker(index) {
        closeAllOverlay();

        if (markers[index] && overlays[index]) {
            overlays[index].setMap(map);
            map.panTo(markers[index].getPosition());
        }
    }

    function filterRestaurants() {
        var keyword = document.getElementById("mapSearchInput").value.trim().toLowerCase();

        var items = document.querySelectorAll(".item");
        var visibleCount = 0;

        closeAllOverlay();

        var filteredBounds = new kakao.maps.LatLngBounds();
        var hasVisibleMarker = false;

        for (var i = 0; i < markers.length; i++) {
            if (markers[i]) {
                markers[i].setMap(null);
            }
        }

        items.forEach(function(item) {
            var index = item.getAttribute("data-index");

            var name = (item.getAttribute("data-name") || "").toLowerCase();
            var category = (item.getAttribute("data-category") || "").toLowerCase();
            var address = (item.getAttribute("data-address") || "").toLowerCase();

            var isMatch =
                keyword === "" ||
                name.indexOf(keyword) > -1 ||
                category.indexOf(keyword) > -1 ||
                address.indexOf(keyword) > -1;

            if (isMatch) {
                item.style.display = "flex";
                visibleCount++;

                if (markers[index]) {
                    markers[index].setMap(map);
                    filteredBounds.extend(markers[index].getPosition());
                    hasVisibleMarker = true;
                }

            } else {
                item.style.display = "none";
            }
        });

        document.getElementById("visibleCount").innerText = visibleCount;
        document.getElementById("noResult").style.display =
            visibleCount === 0 ? "block" : "none";

        if (hasVisibleMarker) {
            map.setBounds(filteredBounds);
        }
    }

    function resetSearch() {
        document.getElementById("mapSearchInput").value = "";
        filterRestaurants();
    }
</script>
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>