<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문취소</title>
</head>
<body>
	<h1>주문취소</h1>
	<form action="" method="post">
		<input type="hidden" name="deliveryNo" value="${deliveryNo}">
		
		<label><input type="radio" name="reasonCode" value="R01">상품이 파손되어 도착했어요</label>
		<label><input type="radio" name="reasonCode" value="R02">배송이 너무 늦어요</label>
		<label><input type="radio" name="reasonCode" value="R03">잘못된 상품이 배송되었어요</label>
		<label><input type="radio" name="reasonCode" value="R04">주문 실수에요</label>
		<label><input type="radio" name="reasonCode" value="R05">정보를 잘 못 입력했어요</label>
		<label><input type="radio" name="reasonCode" value="R06">단순 변심이에요</label>
		<label><input type="radio" name="reasonCode" value="ETC">기타</label>
		
		<textarea name="etcReason" placeholder="기타 사유 입력" style="display:none;"></textarea>
		
		<button type="submit">취소 신청</button>
	</form>
</body>

	<script type="text/javascript">
		document.querySelectorAll('input[name="reasonCode"]').forEach(function(radio) {
			radio.addEventListener('change', function() {
				const textarea = document.querySelector('textarea[name="etcReason"]');
				textarea.style.display = (this.value == 'ETC') ? 'block' : 'none';
			});
		});
	</script>
</html>