<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        text-align: right;
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
    
    .selected-option-item {
        background-color: #f9f9f9;
        border: 1px solid #eee;
        border-radius: 8px;
        padding: 15px;
        margin-top: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .selected-option-item .option-name {
        font-size: 14px;
        color: #333;
        flex-grow: 1;
    }
    .quantity-control {
        display: flex;
        align-items: center;
        margin: 0 15px;
    }
    .quantity-control button {
        width: 30px;
        height: 30px;
        border: 1px solid #ccc;
        background-color: #fff;
        cursor: pointer;
        font-size: 16px;
    }
    .quantity-control .quantity {
        width: 40px;
        height: 30px;
        text-align: center;
        border: 1px solid #ccc;
        border-left: none;
        border-right: none;
        box-sizing: border-box;
    }
    .item-price {
        min-width: 80px;
        text-align: right;
        font-weight: bold;
    }
    .remove-item-btn {
        background: none;
        border: none;
        font-size: 20px;
        cursor: pointer;
        color: #888;
        margin-left: 15px;
    }

    /* 총 가격 및 버튼 영역 */
    .total-price-section {
        margin-top: 20px;
        padding-top: 20px;
        border-top: 2px solid #333;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        font-weight: bold;
    }
    .total-price-section .price {
        font-size: 24px;
        color: #d9534f;
    }
    .action-buttons {
        margin-top: 10px;
    }
    .action-buttons button {
        width: 100%;
        padding: 15px;
        font-size: 1.2em;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        background-color: #5f0080;
        color: white;
        transition: background-color 0.3s;
    }
    .action-buttons button:hover {
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
        width: 100%;
        margin: 0 0 30px 0;
        height: auto;
        display: block;
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
                    <c:when test="${not empty itemFile && not empty itemFile[0].saveName}">
                        <img src="/upload/${itemFile[0].saveName}" alt="${itemInfo.title} 대표 이미지">
                    </c:when>
                    <c:otherwise>
                        <img src="https://placehold.co/500x500/e0e0e0/777?text=No+Image" alt="이미지 없음">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="product-info-area">
                <h1 class="product-title">${itemInfo.title}</h1>
                <p class="product-desc">${itemInfo.content}</p>

                <div class="option-selection-area">
                    <c:choose>
                        <c:when test="${not empty itemOption}">
                            <label for="productOption">옵션 선택</label>
                            <select id="productOption" name="selectedOption">
                                <option value="">-- 옵션을 선택해주세요 --</option>
                                <c:forEach var="opt" items="${itemOption}">
                                    <option 
                                        value="${opt.optionNo}"
                                        data-id="${opt.optionNo}"
                                        data-name="${opt.optionName} - ${opt.optionValue}"
                                        data-price="${opt.price}"
                                        data-stock="${opt.stock}">
                                        ${opt.optionName} - ${opt.optionValue} (재고: ${opt.stock})
                                    </option>
                                </c:forEach>
                            </select>
                            
                            <div id="selectedOptionsContainer"></div>
                                
                            <div id="totalSection">
                                <div class="total-price-section">
                                    <span>총 상품 금액:</span>
                                    <span id="totalPrice" class="price">원</span>
                                </div>
                                <div class="action-buttons">
                                    <button type="button" class="cart-btn">장바구니 담기</button>
                                </div>
                            </div>
                        </c:when>

                    </c:choose>
                </div>
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
    
	<script>
	document.addEventListener('DOMContentLoaded', function () {
		const productOptionSelect = document.getElementById('productOption');
		const selectedOptionsContainer = document.getElementById('selectedOptionsContainer');
		const totalPriceElement = document.getElementById('totalPrice');
		const selectedOptionIds = new Set();
	
		// 옵션 선택 이벤트
		productOptionSelect.addEventListener('change', function () {
			const selectedOption = this.options[this.selectedIndex];
			if (!selectedOption.value) return;
	
			const optionId = selectedOption.value;
			const optionName = selectedOption.dataset.name;
			const optionPrice = parseInt(selectedOption.dataset.price, 10);
			const optionStock = parseInt(selectedOption.dataset.stock, 10);
	
			if (selectedOptionIds.has(optionId)) {
				alert('이미 선택된 옵션입니다.');
				this.value = '';
				return;
			}
	
			if (optionStock <= 0) {
				alert('해당 옵션은 재고가 없습니다.');
				this.value = '';
				return;
			}
	
			selectedOptionIds.add(optionId);
	
			// 옵션 DOM 생성 (부모)
			const optionItem = document.createElement('div');
			optionItem.className = 'selected-option-item';
			optionItem.dataset.optionId = optionId;
			optionItem.dataset.price = optionPrice;
			optionItem.dataset.stock = optionStock;
	
			// 옵션명 (자식)
			const optionNameSpan = document.createElement('span');
			optionNameSpan.className = 'option-name';
			optionNameSpan.textContent = optionName;
			optionItem.appendChild(optionNameSpan);
	
			// 수량 컨트롤 (자식)
			const quantityControl = document.createElement('div');
			quantityControl.className = 'quantity-control';
	
			const btnDecrease = document.createElement('button');
			btnDecrease.type = 'button';
			btnDecrease.className = 'decrease-btn';
			btnDecrease.textContent = '-';
	
			const inputQuantity = document.createElement('input');
			inputQuantity.type = 'text';
			inputQuantity.className = 'quantity';
			inputQuantity.value = 1;
			inputQuantity.readOnly = true;
	
			const btnIncrease = document.createElement('button');
			btnIncrease.type = 'button';
			btnIncrease.className = 'increase-btn';
			btnIncrease.textContent = '+';
	
			quantityControl.appendChild(btnDecrease);
			quantityControl.appendChild(inputQuantity);
			quantityControl.appendChild(btnIncrease);
			optionItem.appendChild(quantityControl);
	
			// 개별 가격 (자식)
			const priceSpan = document.createElement('span');
			priceSpan.className = 'item-price';
			priceSpan.textContent = (optionPrice * 1).toLocaleString() + '원';
			optionItem.appendChild(priceSpan);
	
			// 삭제 버튼 (자식)
			const removeBtn = document.createElement('button');
			removeBtn.type = 'button';
			removeBtn.className = 'remove-item-btn';
			removeBtn.textContent = '×';
			optionItem.appendChild(removeBtn);
	
			selectedOptionsContainer.appendChild(optionItem);
			updateTotalPrice();
	
			this.value = '';
		});
		//  ↑↑↑부모 생성후 자식들은 생성한 순서대로 화면에 출력↑↑↑
	
		// 수량 변경 및 삭제 이벤트
		selectedOptionsContainer.addEventListener('click', function (e) {
			const target = e.target;
			const optionItem = target.closest('.selected-option-item');
			if (!optionItem) return;
	
			const quantityInput = optionItem.querySelector('.quantity');
			let quantity = parseInt(quantityInput.value, 10);  // parseInt의 두번째 매개값은 진수를 의미해서 10진수로 해석
			const stock = parseInt(optionItem.dataset.stock, 10);
			const unitPrice = parseInt(optionItem.dataset.price, 10);
			const priceSpan = optionItem.querySelector('.item-price');
	
			if (target.classList.contains('increase-btn')) { 
				if (quantity < stock) {
					quantity++;
				} else {
					alert('최대 구매 가능 수량은 ' + stock + '개 입니다.');
				}
			} else if (target.classList.contains('decrease-btn')) {
				if (quantity > 1) {
					quantity--;
				}
			} else if (target.classList.contains('remove-item-btn')) {
				selectedOptionIds.delete(optionItem.dataset.optionId);
				optionItem.remove();
				updateTotalPrice();
				return;
			}
	
			quantityInput.value = quantity;
	
			// 개별 가격 업데이트
			const totalOptionPrice = unitPrice * quantity;
			priceSpan.textContent = totalOptionPrice.toLocaleString() + '원';
	
			updateTotalPrice();
		});
	
		// 총 금액 계산 함수
		function updateTotalPrice() {
		    const items = document.querySelectorAll(".selected-option-item");
		    let total = 0;

		    // const totalPriceElement = document.getElementById('totalPrice');
		    items.forEach(item => {
		        const quantity = parseInt(item.querySelector(".quantity").value, 10);
		        const unitPrice = parseInt(item.dataset.price, 10);

		        if (!isNaN(quantity) && !isNaN(unitPrice)) {
		            total += quantity * unitPrice;
		        }
		    });

		    totalPriceElement.textContent = total.toLocaleString() + '원';
		    // toLocaleString() -> 금액 단위에 ,표시 1000 - > 1,000으로 
		    // totalPriceElement.textContent = `${total.toLocaleString()}원`;  `백틱 불량`
		    //console.log('totalPrice:', total);

		}

	});
	</script>

</body>
</html>
