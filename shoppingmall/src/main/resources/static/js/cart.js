
// 필터 클릭시에 mainPage로 이동
$('#filter-new').click(function(e){
	location.href="mainPage"
});


// file: webapp/js/cart.js
$(function(){
  // 전역 변수: JSP에서 선언된 ctx, apiUrl 사용
  var apiUrl = ctx + '/api/cart';

  // 초기 로드
  loadCart();

  function loadCart() {
    $.getJSON(apiUrl)
      .done(function(res){
        var items = res.result || [];
        var $list = $('#cartItems').empty();

        // 사용자 주소 (API 응답 dto.address 활용)
        if (items.length > 0 && items[0].address) {
          var addr = items[0].address;
          var fullAddr = addr.address +
                         (addr.address2 ? ' ' + addr.address2 : '') +
                         (addr.postCode ? ' (' + addr.postCode + ')' : '');
          $('#userAddress').text(fullAddr);
        }

        // 각 아이템 렌더링
        items.forEach(function(dto) {
          var unitPrice = dto.item.itemAmount + (dto.option && dto.option.price ? dto.option.price : 0);
          var lineTotal = unitPrice * dto.count;

          var $li = $('<li>').addClass('cart-item')
            .data('itemNo', dto.item.itemNo)
            .data('optionNo', dto.option ? dto.option.optionNo : null)
            .data('unitPrice', unitPrice);

          $li.append('<input type="checkbox" class="item-check" name="cartNo" value="'+dto.cartNo+'" />')
            .append('<img src="' + ctx + '/upload/' + dto.item.saveName + '" alt="상품 이미지" />')
            .append(
              $('<div>').addClass('details')
                .append($('<p>').addClass('title')
                                .text(dto.item.itemTitle + (dto.option ? ' / ' + dto.option.optionName : '')))
                .append($('<p>').addClass('price')
                                .text(lineTotal.toLocaleString() + '원'))
                .append(
                  $('<div>').addClass('quantity')
                    .append('<button class="decrease">-</button>')
                    .append($('<span>').addClass('qty-value').text(dto.count))
                    .append('<button class="increase">+</button>')
                )
            )
            .append('<button class="remove">×</button>');

          $list.append($li);
        });

        // 이벤트 바인딩 및 초기 상태
        bindHandlers();
        $('#selectAll').prop('checked', true).trigger('change');
      })
      .fail(function(xhr, status, err){
        console.error('장바구니 로드 실패:', err);
        alert('장바구니 정보를 불러오지 못했습니다.');
      });
  }

  function bindHandlers() {
    // 전체 선택/해제
    $('#selectAll').off('change').on('change', function(){
      var checked = $(this).prop('checked');
      $('.item-check').prop('checked', checked).trigger('change');
    });

    // 개별 체크박스 변경시
    $(document).off('change', '.item-check').on('change', '.item-check', function(){
      var total = $('.item-check').length;
      var checkedCount = $('.item-check:checked').length;
      $('#selectAll').prop('checked', total === checkedCount);
      updateSelectedSummary();
    });

    // 수량 감소
    $(document).off('click', '.decrease').on('click', '.decrease', function(){
      var $li = $(this).closest('li');
      var $val = $li.find('.qty-value');
      var cur = parseInt($val.text(), 10);
      if (cur > 1) {
        $val.text(cur - 1);
        updateLineTotal($li);
      }
    });

    // 수량 증가
    $(document).off('click', '.increase').on('click', '.increase', function(){
      var $li = $(this).closest('li');
      var $val = $li.find('.qty-value');
      var cur = parseInt($val.text(), 10);
      $val.text(cur + 1);
      updateLineTotal($li);
    });

    // X 버튼 클릭 시 해당 아이템 삭제
    $(document).off('click', '.remove').on('click', '.remove', function(){
      let $cartitem = $(this).closest('li.cart-item')
	  let cartNo = $cartitem.find('input[name="cartNo"]').val();
	  
	  $.post(ctx + '/api/cart/delete', {cartNo: cartNo})
	  	.done(function(res){
			// 삭제 성공 시 DOM에서 제거 및 요약 업데이트
			
			$cartitem.remove();
			updateSelectedSummary();
 		}) 
		.fail(function(xhr, status, err){
			console.error('장바구니 항목 삭제 실패:', err);
			alert('해당 아이템을 삭제하지 못했습니다.');
		});
    });

    // 선택 삭제 버튼 클릭
    $('.btn-delete').off('click').on('click', function(){
      $.post(ctx + '/api/cart/deletecartItems')
	   .done(function(res){
		$('.item-check:checked').closest('li.cart-item').remove();
		updateSelectedSummary();
	   })
	   .fail(function(xhr, status, err){
			console.error('장바구니 전체항목 삭제 실패:', err);
			alert(message)
	   }); 	
      
    });

    // 주문하기
    $('#orderButton').off('click').on('click', function(){
      var selected = [];
      $('.item-check:checked').closest('li.cart-item').each(function(){
        var $li = $(this);
        selected.push({
          itemNo: $li.data('itemNo'),
          optionNo: $li.data('optionNo'),
          count: parseInt($li.find('.qty-value').text(), 10)
        });
      });
      if (!selected.length) {
        alert('주문할 상품을 선택하세요.');
        return;
      }
      console.log('주문 대상:', selected);
      // TODO: 실제 주문 페이지로 이동
    });
  }

  function updateLineTotal($li) {
    var unitPrice = $li.data('unitPrice');
    var count = parseInt($li.find('.qty-value').text(), 10);
    var newTotal = unitPrice * count;
    $li.find('.price').text(newTotal.toLocaleString() + '원');
    updateSelectedSummary();
  }

  function updateSelectedSummary() {
    var sub = 0;
    $('.item-check:checked').closest('li.cart-item').each(function(){
      var num = parseInt($(this).find('.price').text().replace(/[^0-9]/g, ''), 10);
      sub += num;
    });
    $('#subtotalItemsPrice').text(sub.toLocaleString() + '원');
    $('#subtotalTotal').text(sub.toLocaleString() + '원');
    $('#summaryProductTotal').text(sub.toLocaleString() + '원');
    $('#summaryTotal').text(sub.toLocaleString() + '원');
    $('#orderButton').text(sub.toLocaleString() + '원 주문하기');
  }

});

