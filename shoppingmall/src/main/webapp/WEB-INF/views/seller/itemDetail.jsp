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
    .action-buttons button {
        width: 100%;
        padding: 15px;
        font-size: 1.2em;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        margin-top: 10px;
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
          <%-- <jsp:include page="/WEB-INF/views/common/header_guest.jsp" flush="true" /> --%>
          <div style="text-align:right; padding: 10px; background-color:#f0f0f0;">Guest Header</div>
        </c:when>
        <c:otherwise>
          <%-- <jsp:include page="/WEB-INF/views/common/header_member.jsp" flush="true" /> --%>
          <div style="text-align:right; padding: 10px; background-color:#f0f0f0;">Member Header</div>
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
                        <img src="https://placehold.co/400x400/e0e0e0/777?text=No+Image" alt="이미지 없음">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="product-info-area">
                <h1 class="product-title">${itemInfo.title}</h1>
                <p class="product-desc">${itemInfo.content}</p>

                <!-- 옵션 -->
                <c:if test="${not empty itemOption}">

                    <div class="option-selection-area">
                        <label for="productOption">옵션 선택:</label>
                        <select id="productOption" name="selectedOption">
						    <option value="">-- 옵션을 선택해주세요 --</option>
						    <c:forEach var="opt" items="${itemOption}">
								<c:choose>
									<c:when test="${opt.stock == 0}">
										<option value="${opt.optionNo}" disabled style="text-decoration:line-through;">
											${opt.optionName} - ${opt.optionValue} 품절
										</option>
									</c:when>
									<c:otherwise>
										<%-- ① null/빈값 대비해서 먼저 변수로 만든다 --%>
										<c:set var="optName" value="${not empty opt.optionName ? opt.optionName : '옵션명없음'}" />
										<c:set var="optValue" value="${not empty opt.optionValue ? opt.optionValue : '값없음'}" />
										<c:set var="optPrice" value="${not empty opt.price ? opt.price : itemInfo.amount}" />
																	
										<option
										    value="${opt.optionNo}"
										    data-name="${fn:escapeXml(optName)} - ${fn:escapeXml(optValue)}"
										    data-price="${optPrice}"
										    data-stock="${opt.stock}">
										    ${fn:escapeXml(optName)} - ${fn:escapeXml(optValue)} (재고: ${opt.stock})
										</option>

									</c:otherwise>
								</c:choose>
							</c:forEach>

						</select>
                        
                        <!-- 선택된 옵션이 표시될 영역 -->
                        <div id="selectedOptionsContainer"></div>
                            
                        <!-- 총 금액 및 장바구니 버튼 영역 -->
                        <div id="totalSection">
                            <div class="total-price-section">
                                <span>총 상품 금액:</span>
                                <span id="totalPrice" class="price">0원</span>
                            </div>
                            <div class="action-buttons">
                                <button type="button" class="cart-btn">장바구니 담기</button>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty itemOption}">
                    <p>이 상품은 옵션이 없습니다.</p>
                    <div class="total-price-section">
                         <span>상품 금액:</span>
                         <span class="price"><fmt:formatNumber value="${itemInfo.amount}" type="number" groupingUsed="true"/>원</span>
                    </div>
                    <div class="action-buttons">
                       <button type="button" class="cart-btn">장바구니 담기</button>
                    </div>
                </c:if>
            </div>
        </div>    
        
        <%--디버깅 --%>
<c:forEach var="opt" items="${itemOption}">
	<option 
		value="${opt.optionNo}"
		data-name="${opt.optionName}"
		data-price="${opt['PRICE']}" 
		data-stock="${opt.stock}">
		${opt.optionValue}
	</option>
</c:forEach>

<c:forEach var="opt" items="${itemOption}">
	<pre>${opt}</pre>
</c:forEach>


            

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
        document.addEventListener('DOMContentLoaded', function() {
            // productOptionSelect가 없는 경우(옵션 없는 상품) 스크립트 실행 중단
            const productOptionSelect = document.getElementById('productOption');
            if (!productOptionSelect) {
                return;
            }

            const selectedOptionsContainer = document.getElementById('selectedOptionsContainer');
            const totalPriceElement = document.getElementById('totalPrice');
            const totalSection = document.getElementById('totalSection');
        
            const selectedOptionIds = new Set();
        
            productOptionSelect.addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];
    			
                if (!selectedOption.value) {
                    return;
                }
        
                const optionId = selectedOption.value;
                const optionName = selectedOption.dataset.name;
                const optionPrice = parseFloat(selectedOption.dataset.price);
                const optionStock = parseInt(selectedOption.dataset.stock);
                
                // console.log('optionId:', optionId);
    			// console.log('optionName:', optionName);
    			// console.log('optionPrice:', optionPrice);
    			// console.log('optionStock:', optionStock);
        
                if (selectedOptionIds.has(optionId)) {
                    alert('이미 선택된 옵션입니다.');
                    this.value = '';
                    return;
                }
        
                selectedOptionIds.add(optionId);
        
                const optionItem = document.createElement('div');
                optionItem.className = 'selected-option-item';
                optionItem.dataset.optionId = optionId;
                optionItem.dataset.price = optionPrice;
                optionItem.dataset.stock = optionStock;
        
                const displayPrice = isNaN(optionPrice) ? 0 : optionPrice;
                
                // console.log('displayPrice', displayPrice);
                
                optionItem.innerHTML = `
                    <span class="option-name">${optionName || '선택된 옵션'}</span>
                    <div class="quantity-control">
                        <button type="button" class="decrease-btn">-</button>
                        <input type="text" class="quantity" value="1" readonly>
                        <button type="button" class="increase-btn">+</button>
                    </div>
                    <span class="item-price">${displayPrice.toLocaleString()}원</span>
                    <button type="button" class="remove-item-btn">×</button>
                `;

                selectedOptionsContainer.appendChild(optionItem);
        
                this.value = '';
                updateTotalPrice();
            });
        
            selectedOptionsContainer.addEventListener('click', function(e) {
                const target = e.target;
                const optionItem = target.closest('.selected-option-item');
                if (!optionItem) return;
        
                const quantityInput = optionItem.querySelector('.quantity');
                let quantity = parseInt(quantityInput.value);
                const stock = parseInt(optionItem.dataset.stock);
        
                // 구매제한 (최대 구매가능 수량은 == 재고수량)
                if (target.classList.contains('increase-btn')) {
                    if (quantity < stock) {
                        quantity++;
                        quantityInput.value = quantity;
                        updateTotalPrice();
                    } else {
                        alert(`최대 구매 가능 수량은 ${stock}개 입니다.`);
                    }
                }
        
                if (target.classList.contains('decrease-btn')) {
                    if (quantity > 1) {
                        quantity--;
                        quantityInput.value = quantity;
                        updateTotalPrice();
                    }
                }
        
                if (target.classList.contains('remove-item-btn')) {
                    const optionIdToRemove = optionItem.dataset.optionId;
                    selectedOptionIds.delete(optionIdToRemove);
                    optionItem.remove();
                    updateTotalPrice();
                }
            });
        
            function updateTotalPrice() {
                let total = 0;
                const selectedItems = selectedOptionsContainer.querySelectorAll('.selected-option-item');
        
                selectedItems.forEach(item => {
                    const price = parseFloat(item.dataset.price);
                    const quantity = parseInt(item.querySelector('.quantity').value);
                    
                    if (!isNaN(price) && !isNaN(quantity)) {
                       total += price * quantity;
                    }
                });
        
                totalPriceElement.textContent = `${total.toLocaleString()}원`;
            }
        });
        </script>
</body>
</html>
