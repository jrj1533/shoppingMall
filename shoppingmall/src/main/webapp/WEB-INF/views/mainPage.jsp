<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Kurly Main Page</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body { margin-top: 100px; margin:0; padding:0; font-family:Arial,sans-serif; }
    main { max-width:1200px; margin:32px auto; padding:0 24px; }
    .search-results { display:flex; gap:24px; }
    .filter-panel { width:240px; border-right:1px solid #eee; padding-right:16px; }
    .filter-panel h4 { margin-top:0; }
    .filter-panel ul { list-style:none; padding:0; margin:0; }
    .filter-panel li { margin:8px 0; cursor:pointer; }
    .filter-panel li.active { font-weight:bold; color:#7f00ff; }
    .product-list { flex:1; }
    .products { display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:24px; }
    .pagination { text-align:center; margin:16px 0; }
    .pagination a { margin:0 4px; text-decoration:none; color:#333; }
    .pagination a.active { font-weight:bold; color:#7f00ff; }
    .product-card { background:#fff; border:1px solid #eee; border-radius:8px;
                    overflow:hidden; display:flex; flex-direction:column;  max-height: 400px; height: auto; }
    .product-card .thumb { position:relative; width:100%;  padding-top:80%; background:#f9f9f9; }
    .product-card .thumb img { position:absolute; top:0; left:0;
      width:100%; height:100%; object-fit:contain; }
    .product-card .info { padding:8px; flex:1;
      display:flex; flex-direction:column; justify-content:space-between; gap: 4px;}
    .product-card .name { font-size:1rem; color:#333; margin:12px 0 0;
      line-height:1.3; height:2.6em; overflow:hidden; }
    .product-card .price { font-size:1.1rem; font-weight:bold; color:#333;
      margin: -20px 0 8px; }
    .product-card .btn-cart { background:#7f00ff; color:#fff; border:none;
      border-radius:20px; padding:8px 0; text-align:center; font-size:.95rem;
      cursor:pointer; }
    /* 공통: 숨기기 */
.hidden { display: none; }

/* 오버레이 (반투명 검정) */
#overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.4);
  z-index: 1000;
}

/* 모달 창 */
.modal {
  position: fixed;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  z-index: 1001;
  width: 90%;
  max-width: 400px;
}
.modal-content {
  background: #fff;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
.modal-title {
  margin: 0 0 8px;
  font-size: 1.2rem;
}
.modal-desc {
  margin: 0 0 16px;
  color: #555;
}
.modal-price-qty {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}
.modal-price {
  font-size: 1.1rem;
  font-weight: bold;
}
.quantity-control {
  display: flex;
  align-items: center;
  gap: 8px;
}
.quantity-control button {
  width: 32px; height: 32px;
  border: 1px solid #ccc;
  background: #fff;
  cursor: pointer;
  border-radius: 4px;
}
.quantity-control .qty-value {
  min-width: 24px;
  text-align: center;
}
.modal-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}
.modal-actions button {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
#modalCancel {
  background: #eee;
  color: #333;
}
#modalAddCart {
  background: #7f00ff;
  color: #fff;
}

.modal-thumb {
  text-align: center;
  margin-bottom: 16px;
}
.modal-thumb img {
  max-width: 100%;
  height: auto;
  border-radius: 4px;
}

.modal-options {
  list-style: none;
  padding: 0;
  margin: 16px 0;
  max-height: 200px;
  overflow-y: auto;
  border-top: 1px solid #eee;
  border-bottom: 1px solid #eee;
}
.modal-options li {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #f1f1f1;
}
.modal-options li:last-child {
  border-bottom: none;
}
.modal-options .option-name {
  flex: 1;
}
.quantity-control {
  display: flex;
  align-items: center;
  gap: 4px;
}
.modal-total {
  text-align: right;
  font-weight: bold;
  margin: 12px 0;
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

  <main>
    <div class="search-results">
      <!-- 필터 패널 -->
      <aside class="filter-panel">
        <h4>필터</h4>
        <ul>
          <li>새로 나온</li>
          <li>Kurly Only</li>
        </ul>
        <h4>카테고리</h4>
        <ul>
          <li>과자·간식 (413)</li>
          <li>쿠키·비스킷·크래커 (194)</li>
          <li>초콜릿·젤리·캔디 (77)</li>
          <li>디저트 (76)</li>
        </ul>
      </aside>

      <!-- 상품 목록 -->
      <section class="product-list">
        <div id="products" class="products"></div>
        <div id="pagination" class="pagination"></div>
      </section>
    </div>
  </main>
	  
	<!-- 모달 오버레이 + 창 (초기엔 .hidden 처리) -->
<!-- 오버레이 + 모달 -->
<!-- 오버레이 + 모달 -->
<div id="overlay" class="hidden"></div>
<div id="detailModal" class="modal hidden">
  <div class="modal-content">
    <!-- 1) 대표 이미지 -->
    <div class="modal-thumb">
      <input type="hidden"  name ="itemNo" class ="modal-itemNo" value="">
      <img id="modalImg" src="" alt="상품 이미지" />
      <!-- 이미지 URL 히든 필드 -->
      
    </div>

    <!-- 2) 제목/설명 -->
    <h3 class="modal-title"></h3>
    
    <p class="modal-desc"></p>
    

    <!-- 3) 옵션 목록 -->
    <ul id="modalOptionsList" class="modal-options">
     
      <li>
        <!-- 옵션 라벨 -->
        <span class="option-name">옵션명 옵션값</span>

        <!-- 옵션 데이터 히든 필드 -->
        

        <!-- 수량 컨트롤 -->
        <div class="quantity-control">
          <button type="button" class="qty-decrease">-</button>
          <input type="text" class="qty-value"
                 name="options[0].quantity"
                 value="0"
                 readonly />
          <button type="button" class="qty-increase">+</button>
        </div>
      </li>
      <!-- …index 1, 2, … 계속 반복… -->
    </ul>

    <!-- 4) 전체 합계 -->
    <div class="modal-total">
      합계: <span id="modalTotalPrice">0원</span>
    </div>

    <!-- 5) 액션 버튼 -->
    <div class="modal-actions">
      <button id="modalCancel">취소</button>
      <button id="modalAddCart">장바구니 담기</button>
    </div>
  </div>
</div>


	
	
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%-- 상단에 contextPath 변수 추가 --%>
<script>
	const ctx = '${pageContext.request.contextPath}';
</script>

<script>
$(function(){
  // 1) "담기" 버튼 클릭
  $(document).on('click', '.btn-cart', function(){
    var raw    = $(this).attr('data-item-no');
    var itemNo = parseInt(raw, 10);

    var url = ctx + '/api/productsOption?itemNo=' + itemNo;
    console.log('▶ 요청 URL =', url);

    $.getJSON(url)
      .done(function(res){
        console.log('API 응답 ➡️', res);
        loadProductsOption(res);
      })
      .fail(function(xhr, status, err){
        console.error('API 호출 실패:', err);
      });
  });

  function loadProductsOption(dto) {
	  // 1) 대표 이미지 & 기본 정보 + 히든 필드
	  let imgUrl = ctx + '/upload/' + dto.saveName;
	  $('#modalImg').attr('src', imgUrl);
		
	  $('.modal-title').text(dto.itemTitle);
	  $('.modal-itemNo').val(dto.itemNo);
	  $('.modal-desc').text(dto.itemContent || '');
	  $('#modalDescInput').val(dto.itemContent || '');

	  // 2) 옵션 목록 초기화 & 렌더링
	  let $list = $('#modalOptionsList').empty();
	  for (let i = 0; i < dto.options.length; i++) {
	    let opt = dto.options[i];

	    let $li = $('<li>');

	    $li.append(
	      $('<span>').addClass('option-name')
	                 .text(opt.optionName + ' ' + opt.optionValue),
	      // 히든 필드
	      $('<input>').attr({type:'hidden', name:'options['+i+'].optionNo'}).val(opt.optionNo),
	      $('<input>').attr({type:'hidden', name:'options['+i+'].optionName'}).val(opt.optionName),
	      $('<input>').attr({type:'hidden', name:'options['+i+'].optionValue'}).val(opt.optionValue)
	    );

	    // 수량 컨트롤
	    let $ctrl   = $('<div>').addClass('quantity-control');
	    let $btnDec = $('<button>').attr('type','button').addClass('qty-decrease').text('-');
	    let $val    = $('<span>').addClass('qty-value').text('0');
	    let $qtyIn  = $('<input>').attr({
	                     type:'hidden',
	                     name:'options['+i+'].quantity'
	                   }).val(0);
	    let $btnInc = $('<button>').attr('type','button').addClass('qty-increase').text('+');

	    $ctrl.append($btnDec, $val, $btnInc, $qtyIn);
	    $li.append($ctrl);
	    $list.append($li);
	  }

	  // 3) 합계 계산 & 히든 필드 동기화
	  function updateTotal() {
	    let total = 0;
	    $list.children('li').each(function() {
	      let $li = $(this);
	      let q   = parseInt($li.find('.qty-value').text(), 10);
	      // 히든 수량도 동기화
	      $li.find('input[name$=".quantity"]').val(q);
	      if (q > 0) {
	        total += q * parseInt(dto.itemAmount, 10);
	      }
	    });
	    let formatted = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	    $('#modalTotalPrice').text(formatted + '원');
	    $('#modalTotalPriceInput').val(total);
	  }

	// 4) 이벤트 바인딩 (중복 방지)
	  $list.off('click', '.qty-decrease')
	       .off('click', '.qty-increase');

	  // '-' 버튼: 해당 옵션만 1씩 감소
	  $list.on('click', '.qty-decrease', function() {
	    let $li  = $(this).closest('li');
	    let $val = $li.find('.qty-value');
	    let $input = $li.find('input[name$=".quantity"]');
	    
	    let cur  = parseInt($val.text(), 10);
	    if (cur > 0) {
    	  let newQty = cur - 1;
	      $val.text(newQty);
	      $input.val(newQty);
	      updateTotal();
	    }
	  });

	  // '+' 버튼: 
	  //   • cur === 0 이면 → 다른 옵션 전부 0 으로 초기화, 이 항목만 1
	  //   • cur  > 0 이면 → 이 항목만 cur+1
	  $list.on('click', '.qty-increase', function() {
	    let $li  = $(this).closest('li');
	    let $val = $li.find('.qty-value');
	    let $input = $li.find('input[name$=".quantity"]');
	    let cur  = parseInt($val.text(), 10);

	    if (cur === 0) {
	      // ① 다른 옵션 모두 0 으로 리셋
	      $list.children('li').each(function() {
	        $(this).find('.qty-value').text('0');
	        $(this).find('input[name$=".quantity"]').val(0);
	      });
	      // ② 클릭된 것만 1 로
	      $val.text('1');
	      $input.val(1);
	    } else {
	      let newQty = cur + 1;
	    	// 이미 선택된 옵션은 계속 증가
	      $val.text(newQty);
	      $input.val(newQty);
	    }

	    updateTotal();
	  });
	  // 6) 모달 열기 & 취소
	  $('#overlay, #detailModal').removeClass('hidden');
	  $('#modalCancel').one('click', function() {
	    $('#overlay, #detailModal').addClass('hidden');
	  });
	}



});
</script>


<script>
$(function(){
  // 1) "담기" 버튼 클릭



  // 3) 페이징 변수
  var defaultSize = 10;
  var currentPage = 1;

  // 4) 상품 목록 불러오기
  function loadProducts(page, filterType) {
    if (page === undefined) page = 1;
    if (filterType === undefined) filterType = '';
    currentPage = page;

    var params = { page: page, size: defaultSize };
    if (filterType) params.filter = filterType;

    $.getJSON(ctx + '/api/products', params)
      .done(function(res){
        renderProducts(res.products);
        renderPagination(res.startPage, res.endPage, res.currentPage);
      })
      .fail(function(xhr, status, err){
        console.error('API 호출 실패:', err);
      });
  }

  // 5) "신상품" 필터 클릭
  $('#filter-new').click(function(e){
    e.preventDefault();
    $('.filter-panel a').removeClass('active');
    $(this).addClass('active');
    loadProducts(1, $(this).data('filter'));
  });

  // 6) 상품 카드 렌더링 (문자열 연결)
  function renderProducts(list) {
    var $box = $('#products').empty();
    for (var i = 0; i < list.length; i++){
      var p = list[i];
      var imgSrc  = p.saveName;
      var linkUrl = '/item/detail/' + p.itemNo;
      var itemNo = p.itemNo
      var priceFormatted = p.itemAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      
      $box.append(
        '<div class="product-card">' +
          '<div class="thumb">' +
            '<a href="' + linkUrl + '">' +
              '<img src="' + imgSrc + '" alt="' + p.itemTitle + '" />' +
            '</a>' +
          '</div>' +
          '<div class="info">' +
          '<button class="btn-cart" data-item-no="' + p.itemNo + '">🛒 담기</button>'+
            '<p class="name">' + p.itemTitle + '</p>' +
            '<p class="price">' + priceFormatted + '원</p>' +
          '</div>' +
        '</div>'
      );
    }
  }

  // 7) 페이지네이션 생성
  function renderPagination(startPage, endPage, currentPage) {
    var $pg = $('#pagination').empty();
    for (var i = startPage; i <= endPage; i++){
      var cls = (i === currentPage) ? 'active' : '';
      $pg.append(
        '<a href="#" class="' + cls + '" data-page="' + i + '">' +
        i + '</a>'
      );
    }
  }

  // 8) 페이지 클릭 이벤트
  $('#pagination').on('click', 'a', function(e){
    e.preventDefault();
    loadProducts(parseInt($(this).data('page'), 10));
  });

  // 9) 전체 필터 클릭
  $('.filter-panel li').click(function(){
    $('.filter-panel li').removeClass('active');
    $(this).addClass('active');
    loadProducts(1);
  });

  // 10) 초기 호출
  loadProducts();
});
</script>


</body>
</html>