
$(function(){  //
  $('#modalAddCart').on('click', function(e) {
    e.preventDefault();

    
    let data = $('#modalForm').serialize();

    
    $.ajax({
      url: '/api/insertCart',
      type: 'POST',
      data: data,
      success: function(res) {
        alert(res.message);
        
        $('#overlay, #detailModal').addClass('hidden');
      },
      error: function(xhr, status, err) {
        console.error('장바구니 담기 실패:', err);
        alert(err.message);
        
       
      }
    });
    
  });

});


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
      })
  });
  
});

$(function(){





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

	    let $li = $('<li>').data('stock', opt.stock);

	    $li.append(
	      $('<span>').addClass('option-name')
	                 .text(opt.optionName + ' ' + opt.optionValue),
	      // 히든 필드
	      $('<input>').attr({type:'hidden', name:'optionNo'}).val(opt.optionNo),
	    );

	    // 수량 컨트롤
	    let $ctrl   = $('<div>').addClass('quantity-control');
	    let $btnDec = $('<button>').attr('type','button').addClass('qty-decrease').text('-');
	    let $val    = $('<span>').addClass('qty-value').text('0');
	    let $qtyIn  = $('<input>').attr({
	                     type:'hidden',
	                     name:'count'
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
	      $li.find('input[name="count"]').val(q);
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
	    let $input = $li.find('input[name="count"]');
	    
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
	    const $li    = $(this).closest('li');
	    const stock  = $li.data('stock');
	    const cur    = parseInt($li.find('.qty-value').text(), 10);

	    if (cur >= stock) return;

	    // 여기에 $val, $input 선언
	    const $val   = $li.find('.qty-value');
	    const $input = $li.find('input[name="count"]');

	    if (cur === 0) {
	      // 다른 옵션 리셋
	      $list.children('li').each(function() {
	        $(this).find('.qty-value').text('0');
	        $(this).find('input[name="count"]').val(0);
	      });
	      // 클릭된 것만 1
	      $val.text('1');
	      $input.val(1);
	    } else {
	      // 이미 선택된 것 +1
	      const newQty = cur + 1;
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



  
  
  