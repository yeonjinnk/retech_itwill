// 결제 비밀번호 확인
function openCheckPayPwdWindow() {
    // "CheckPayPwd" 서블릿 주소로 새 창을 열기
        window.open('CheckPayPwd', 'CheckPayPwdWindow', 'width=500,height=400');
}

// 충전금액 텍스트박스에 반영하기
$(document).ready(function() {
	// 
    $('#chargeButtons').on('click', '.charge-btn', function() {
    	
        // 현재 텍스트 박스에 입력된 값을 숫자로 변환(빈 값일 경우 0으로 처리)
        let currentAmount = parseInt($('#chargeAmount').val().replace(/,/g, '')) || 0; // 기존 콤마 제거
        // 클릭된 버튼의 data-amount 속성에서 충전 금액 가져오기
        let additionalAmount = parseInt($(this).data('amount'));
        // 기존 금액에 버튼의 금액을 더하기
        let newAmount = currentAmount + additionalAmount;
        // 텍스트 박스의 값을 업데이트 (1000단위 콤마 추가)
        $('#chargeAmount').val(newAmount.toLocaleString());
    });
	

    // 충전금액 텍스트박스에 숫자만 허용
    $('#chargeAmount').on('input', function() {
        let value = this.value.replace(/,/g, '');
        if (/^\d*$/.test(value)) {
            this.value = Number(value).toLocaleString();
            $('#onlyDigitMessage').hide();
        } else {
            $('#onlyDigitMessage').show();
        }
    });
	
    // 'X' 버튼 클릭 시 텍스트 박스 내용 초기화
    $('#clearButton').on('click', function() {
        $('#chargeAmount').val('');
    });       
    
});
    	
// 충전금액 판별 후 페이비밀번호 확인 새 창 열기
function openCheckPayPwdWindow() {
	
	let currentAmount = parseInt($('#chargeAmount').val());
	console.log("currentAmount : " + currentAmount);
	
	// 환급금액이 입력되지 않거나
	// 잔액보다 큰 금액을 환급할 시에는 환급 불가
	if(isNaN(currentAmount)) {
		alert("충전 금액을 입력해주세요!");
	} else {
	    // "CheckPayPwd" 서블릿 주소로 페이 비밀번호 확인 새 창 열기
	    window.open('CheckPayPwd', 'CheckPayPwdWindow', 'width=500,height=400');
	}
} 
