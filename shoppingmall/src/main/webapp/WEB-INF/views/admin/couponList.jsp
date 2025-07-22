<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 리스트</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
 body {
    font-family: 'Noto Sans KR', sans-serif;
    background: #f4f4f4;
    margin: 0;
    padding: 40px;
  }

  h3 {
    margin-top: 0;
  }

  button {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 10px 20px;
    margin: 5px 0;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
  }

  button:hover {
    background-color: #45a049;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    margin-top: 20px;
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
  }

  th, td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
  }

  th {
    background-color: #f8f8f8;
  }

  .filter-form {
    margin-bottom: 20px;
  }

  .filter-form select, .filter-form input {
    padding: 8px;
    border-radius: 4px;
    border: 1px solid #ccc;
    margin-right: 10px;
  }

  .filter-form button {
    padding: 8px 16px;
  }
  
  #couponModal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0; top: 0;
    width: 100%; height: 100%;
    background-color: rgba(0,0,0,0.4);
  }

  .modal-content {
    background-color: white;
    margin: 10% auto;
    padding: 20px;
    width: 320px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
  }

  .modal-content input,
  .modal-content select {
    width: 100%;
    padding: 8px;
    margin-top: 10px;
    margin-bottom: 15px;
    border-radius: 5px;
    border: 1px solid #ccc;
  }

  .modal-footer {
    text-align: right;
  }
  
  .search-form-wrapper {
  display: flex;
  justify-content: flex-end; /* 오른쪽 정렬 */
  margin-bottom: 20px;
  }
	
  .search-form label,
  .search-form select,
  .search-form input,
  .search-form button {
  margin-left: 10px;
  }
  .top-bar {
  display: flex;
  justify-content: space-between; /* 양쪽 정렬 (왼쪽: 버튼 / 오른쪽: 검색) */
  align-items: center;
  flex-wrap: wrap; /* 좁은 화면에서도 줄바꿈 허용 */
  margin-bottom: 20px;
}

.left-buttons {
  display: flex;
  gap: 10px;
}

.search-form {
  display: flex;
  align-items: center;
  gap: 10px;
}
  
</style>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
	  toggleDiscountInputs(); // 초기 로딩 시 상태 반영
	});
function createCoupon() {
	  const title = $('#title').val();
	  const content = $('#content').val();
	  const type = $('#type').val();
	  const amount = parseInt($('#amount').val()) || 0;
	  const percentage = parseInt($('#percentage').val()) || 0;
	  const startDate = $('#startDate').val();
	  const endDate = $('#endDate').val();

	  $.ajax({
	    url: '/admin/addCoupon', 
	    method: 'POST',
	    contentType: 'application/json',
	    data: JSON.stringify({
	      title: title,
	      content: content,
	      type: type,
	      amount: amount,
	      percentage: percentage,
	      startDate: startDate,
	      endDate: endDate
	    }),
	    success: function (msg) {
	      alert(msg);
	      $('#couponModal').hide();
	      location.reload();
	    },
	    error: function () {
	      alert('등록 실패!');
	    }
	  });
	}
	
function toggleDiscountInputs() {
	  const type = document.getElementById('type').value;

	  if (type === 'PERCENT') {
	    document.getElementById('percentageInput').style.display = 'block';
	    document.getElementById('amountInput').style.display = 'none';
	  } else if (type === 'AMOUNT') {
	    document.getElementById('percentageInput').style.display = 'none';
	    document.getElementById('amountInput').style.display = 'block';
	  } else {
		document.getElementById('percentageInput').style.display = 'none';
		document.getElementById('amountInput').style.display = 'none';
	  }
	}
	

	
</script>
</head>
<body>

<h1>쿠폰리스트</h1>
<div class="top-bar">
  <div class="left-buttons">
    <button onclick="location.href='/mainPage'">홈</button>
    <button onclick="$('#couponModal').show();">+ 쿠폰 등록</button>
  </div>
  <!-- 모달 -->
<div id="couponModal" style="display: none;">
  <div class="modal-content">
    <h3>쿠폰 등록</h3>

    <input type="text" id="title" placeholder="쿠폰명">
    <input type="text" id="content" placeholder="쿠폰 설명">
    
    <select id="type"  onchange="toggleDiscountInputs()">
      <option value="">선택</option>
      <option value="PERCENT">할인율</option>
      <option value="AMOUNT">할인금액</option>
    </select>

    <!-- 할인율 입력 -->
	<div id="percentageInput" style="display: none;">
	  <input type="number" id="percentage" placeholder="할인율 (%)">
	</div>
	
	<!-- 할인금액 입력 -->
	<div id="amountInput" style="display: none;">
	  <input type="number" id="amount" placeholder="할인금액 (원)">
	</div>

    <input type="date" id="startDate" placeholder="시작일">
    <input type="date" id="endDate" placeholder="종료일">

    <div class="modal-footer">
      <button onclick="createCoupon()">등록</button>
      <button onclick="$('#couponModal').hide();">닫기</button>
    </div>
  </div>
</div>
  
  <form action="/admin/couponList" method="get" class="search-form">
    <input type="hidden" name="currentPage" value="1">
    
    <label>검색유형:
      <select name="searchType">
        <option value="all" ${page.searchType == 'all' ? 'selected' : ''}>전체</option>
        <option value="title" ${page.searchType == 'title' ? 'selected' : ''}>이름</option>
        <option value="content" ${page.searchType == 'content' ? 'selected' : ''}>내용</option>
      </select>
    </label>
    
    <label>쿠폰유형:
      <select name="couponType">
        <option value="">전체</option>
        <option value="PERCENT" ${page.couponType == 'PERCENT' ? 'selected' : ''}>할인율</option>
        <option value="AMOUNT" ${page.couponType == 'AMOUNT' ? 'selected' : ''}>할인금액</option>
      </select>
    </label>
    
    <label>검색어:
      <input type="text" name="searchWord" value="${page.searchWord}" placeholder="검색어 또는 숫자 입력">
    </label>
    
    <button type="submit">검색</button>
  </form>
</div>


<table>
    <tr>
        <th>번호</th>
        <th>이름</th>
        <th>내용</th>
        <th>할인</th>
        <th>시작일</th>
        <th>만료일</th>
        <th>생성일</th>
    </tr>
    
    <c:choose>
        <c:when test="${not empty couponList}">
            <c:forEach var="c" items="${couponList}">
                <tr>
                    <td>${c.couponNo}</td>
                    <td>${c.title}</td>
                    <td>${c.content}</td>
                    <td>
                        <c:choose>
                            <c:when test="${c.type == 'PERCENT'}">${c.percentage}%</c:when>
                            <c:otherwise>
                            <fmt:formatNumber value="${c.amount}" type="number" groupingUsed="true" />원
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${c.startDate}</td>
                    <td>${c.endDate}</td>
                    <td>${c.createDate}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="7" class="empty-result">검색 결과가 없습니다.</td>
            </tr>
        </c:otherwise>
    </c:choose>
</table>

<!-- 페이징 영역 -->
<div class="paging">
    <c:if test="${page.currentPage > 1}">
        <a class="page-btn" href="?currentPage=${page.currentPage - 1}&searchType=${page.searchType}&searchWord=${page.searchWord}&couponType=${page.couponType}">이전</a>
    </c:if>

    <c:set var="startPage" value="${(page.currentPage - 1) / 5 * 5 + 1}" />
    <c:set var="endPage" value="${startPage + 4}" />
    <c:if test="${endPage > lastPage}">
        <c:set var="endPage" value="${lastPage}" />
    </c:if>

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
        <c:choose>
            <c:when test="${i == page.currentPage}">
                <span class="page current">${i}</span>
            </c:when>
            <c:otherwise>
                <a class="page" href="?currentPage=${i}&searchType=${page.searchType}&searchWord=${page.searchWord}&couponType=${page.couponType}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${page.currentPage < lastPage}">
        <a class="page-btn" href="?currentPage=${page.currentPage + 1}&searchType=${page.searchType}&searchWord=${page.searchWord}&couponType=${page.couponType}">다음</a>
    </c:if>
</div>

</body>
</html>