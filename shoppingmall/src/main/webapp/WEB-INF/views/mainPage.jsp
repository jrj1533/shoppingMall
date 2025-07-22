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
                    overflow:hidden; display:flex; flex-direction:column; }
    .product-card .thumb { position:relative; width:100%; padding-top:100%; background:#f9f9f9; }
    .product-card .thumb img { position:absolute; top:0; left:0;
      width:100%; height:100%; object-fit:contain; }
    .product-card .info { padding:12px; flex:1;
      display:flex; flex-direction:column; justify-content:space-between; }
    .product-card .name { font-size:1rem; color:#333; margin:0 0 8px;
      line-height:1.3; height:2.6em; overflow:hidden; }
    .product-card .price { font-size:1.1rem; font-weight:bold; color:#333;
      margin-bottom:12px; }
    .product-card .btn-cart { background:#7f00ff; color:#fff; border:none;
      border-radius:20px; padding:8px 0; text-align:center; font-size:.95rem;
      cursor:pointer; }
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

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%-- 상단에 contextPath 변수 추가 --%>
<script>
	const ctx = '${pageContext.request.contextPath}';
</script>

<script>
$(function(){
  const defaultSize = 10;     // 한 페이지당 상품 수
  let currentPage = 1;        // 현재 페이지

  /** 상품 목록 가져오기 & 렌더링 */
  function loadProducts(page = 1) {
    currentPage = page;
    $.getJSON(`${ctx}/api/products`, { page, size: defaultSize })
      .done(res => {
        console.log('API 응답 ➡️', res);
        renderProducts(res.products);
        renderPagination(res.startPage, res.endPage, res.currentPage);
      })
      .fail((xhr, status, err) => {
        console.error('API 호출 실패:', err);
      });
  }

  /** 상품 카드 생성 */
function renderProducts(list) {
  const $box = $('#products').empty();
  list.forEach(p => {
    const imgSrc = p.saveName;
    $box.append(
      '<div class="product-card">' +
        '<div class="thumb">' +
          '<img src="' + imgSrc + '" alt="' + p.itemTitle + '" />' +
        '</div>' +
        '<div class="info">' +
          '<p class="name">' + p.itemTitle + '</p>' +
          '<p class="price">' + p.itemAmount.toLocaleString() + '원</p>' +
        '</div>' +
      '</div>'
    );
  });
}



  /** 페이지네이션 생성 */
  function renderPagination(startPage, endPage, currentPage) {
    const $pg = $('#pagination').empty();
    for (let i = startPage; i <= endPage; i++) {
      const cls = i === currentPage ? 'active' : '';
      $pg.append(`<a href="#" class="${cls}" data-page="${i}">${i}</a>`);
    }
  }

  /** 페이지네이션 생성 */
  function renderPagination(startPage, endPage, currentPage) {
    var $pg = $('#pagination').empty();
    for (var i = startPage; i <= endPage; i++) {
      var cls = (i === currentPage) ? 'active' : '';
      // 템플릿 리터럴 대신 문자열 + 연산
      $pg.append(
        '<a href="#" class="' + cls +
        '" data-page="' + i +
        '">' + i + '</a>'
      );
    }
  }

  /** 이벤트 바인딩 */
  // 페이지 번호 클릭
  $('#pagination').on('click', 'a', function(e) {
    e.preventDefault();
    loadProducts(+$(this).data('page'));
  });

  // 필터 클릭 (전체 reload)
  $('.filter-panel li').click(function() {
    $('.filter-panel li').removeClass('active');
    $(this).addClass('active');
    loadProducts(1);
  });

  // 최초 1회 호출
  loadProducts();

});
</script>
</body>
</html>