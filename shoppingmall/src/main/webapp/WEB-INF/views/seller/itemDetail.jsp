<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${itemInfo.title} | 상품 상세</title>
	<style>
		/* 전체 페이지 기본 스타일 */
		body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 0; background-color: #f8f8f8; color: #333; }
		.container { max-width: 1050px; margin: 30px auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
		h2 { text-align: center; margin-bottom: 40px; color: #333; font-size: 2em; border-bottom: 2px solid #eee; padding-bottom: 15px; }

		/* 상품 메인 정보 섹션 (대표 이미지 + 상품 정보) */
		.product-main-section {
			display: flex;
			flex-wrap: wrap; /* 반응형을 위해 줄바꿈 허용 */
			gap: 40px; /* 이미지와 정보 블록 사이 간격 */
			margin-bottom: 50px;
			align-items: flex-start; /* 상단 정렬 */
		}

		.main-image-area {
			flex: 1; /* 가용 공간의 절반 */
			min-width: 400px; /* 최소 너비 설정 */
			max-width: 500px; /* 최대 너비 제한 */
			box-sizing: border-box;
			border: 1px solid #eee;
			border-radius: 8px;
			overflow: hidden; /* 이미지 오버플로우 방지 */
		}
		.main-image-area img {
			width: 100%;
			height: auto;
			display: block;
		}

		.product-info-area {
			flex: 1; /* 나머지 가용 공간 차지 */
			min-width: 400px; /* 최소 너비 설정 */
			max-width: 550px; /* 최대 너비 제한 */
			box-sizing: border-box;
			padding-top: 5px; /* 이미지와 높이 맞추기 */
		}
		.product-info-area .product-title {
			font-size: 2.2em;
			font-weight: bold;
			margin-top: 0;
			margin-bottom: 15px;
			color: #333;
		}
		.product-info-area .product-price {
			font-size: 2.5em;
			font-weight: bold;
			color: #5f0080; /* 컬리 포인트 색상 */
			margin-bottom: 25px;
			border-bottom: 1px solid #eee;
			padding-bottom: 15px;
		}
		.product-info-area .product-desc {
			font-size: 1.1em;
			line-height: 1.6;
			color: #555;
			margin-bottom: 20px;
		}
		.product-info-area .product-stock {
			font-size: 1em;
			color: #777;
			margin-bottom: 20px;
			padding: 10px 0;
			border-top: 1px dashed #eee;
			border-bottom: 1px dashed #eee;
		}

		/* 옵션 선택 영역 */
		.option-selection-area {
			margin-top: 30px;
			padding-top: 20px;
			border-top: 1px solid #eee;
		}
		.option-selection-area label {
			display: block;
			margin-bottom: 10px;
			font-weight: bold;
			color: #333;
		}
		.option-selection-area select {
			width: 100%;
			padding: 10px;
			border: 1px solid #ddd;
			border-radius: 4px;
			font-size: 1em;
			margin-bottom: 15px;
		}
		.option-selection-area button {
			width: 100%;
			padding: 15px;
			background-color: #5f0080;
			color: #fff;
			border: none;
			border-radius: 4px;
			font-size: 1.2em;
			cursor: pointer;
			transition: background-color 0.3s;
		}
		.option-selection-area button:hover {
			background-color: #4a0066;
		}

		/* 제품 상세 이미지 섹션 (하단) */
		.detail-images-section {
			margin-top: 60px;
			padding-top: 40px;
			border-top: 2px solid #eee;
		}
		.detail-images-section h3 {
			text-align: center;
			margin-bottom: 35px;
			color: #333;
			font-size: 1.8em;
		}
		.detail-images-section img {
			max-width: 100%;
			height: auto;
			display: block;
			margin: 0 auto 30px auto;
			border: 1px solid #ddd;
			border-radius: 5px;
			box-shadow: 0 1px 3px rgba(0,0,0,0.05);
		}

		/* 반응형 디자인 */
		@media (max-width: 768px) {
			.product-main-section {
				flex-direction: column;
				gap: 20px;
			}
			.main-image-area, .product-info-area {
				max-width: 100%;
				min-width: unset;
			}
			.product-info-area {
				padding-left: 0;
			}
			.product-info-area .product-title {
				font-size: 1.8em;
			}
			.product-info-area .product-price {
				font-size: 2em;
			}
		}
	</style>
</head>
<body>
	  <!-- 헤더: 로그인/비회원에 따라 분기 -->
	  <c:choose>
	    <c:when test="${sessionScope.roleNo == null || sessionScope.roleNo == 0}">
	      <jsp:include page="/WEB-INF/views/common/header_guest.jsp" flush="true" />
	    </c:when>
	    <c:otherwise>
	      <jsp:include page="/WEB-INF/views/common/header_member.jsp" flush="true" />
	    </c:otherwise>
	  </c:choose>

	<div class="container">
		<h2>${itemInfo.title}</h2>

		<div class="product-main-section">
			<div class="main-image-area">
				<c:choose>
					<%-- 업로드 이미지중 첫번째 사진을 대표사진으로 설정 --%>
					<c:when test="${not empty itemFile && not empty itemFile[0].saveName}">
						<img src="/upload/${itemFile[0].saveName}" alt="${itemInfo.title} 대표 이미지">
					</c:when>
					<c:otherwise>
						<img src="/images/no_image.png" alt="이미지 없음">
						<p style="text-align: center; color: #888;">대표 이미지가 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="product-info-area">
				<h1 class="product-title">${itemInfo.title}</h1>
				<p class="product-desc">${itemInfo.content}</p>
				<p class="product-price"><fmt:formatNumber value="${itemInfo.amount}" type="number" groupingUsed="true"/>원</p>

				<c:if test="${not empty itemOption}">
					<div class="option-selection-area">
						<label for="productOption">옵션 선택:</label>
						<select id="productOption" name="selectedOption">
							<option value="">-- 옵션을 선택해주세요 --</option>
							<c:forEach var="opt" items="${itemOption}">
								<option value="${opt.optionNo}">${opt.optionName} - ${opt.optionValue} (재고: ${opt.stock})</option>
							</c:forEach>
						</select>
						<button type="button">장바구니 담기</button> <%-- 추후 링크필요 --%>
					</div>
				</c:if>
				<c:if test="${empty itemOption}">
					<p>이 상품은 옵션이 없습니다.</p>
					<button type="button">장바구니 담기</button>
				</c:if>
			</div>
		</div>

		<div class="detail-images-section">
			<h3>제품 상세 보기</h3>
			<c:choose>
				<c:when test="${not empty itemFile}">
					<c:forEach var="img" items="${itemFile}">
						<img src="/upload/${img.saveName}" alt="${itemInfo.title} 상세 이미지">
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p style="text-align: center; color: #888;">등록된 상세 이미지가 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>

	</div>
</body>
</html>