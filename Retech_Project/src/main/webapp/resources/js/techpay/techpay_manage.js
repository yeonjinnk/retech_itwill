// 전체 폼 유효성 검사
function validateForm() {
    let isValid = true;

    // 비밀번호 유효성 검사 및 비밀번호 확인 일치 여부 검사
    if (!validatepayPassword()) isValid = false;
    if (!checkSamePw()) isValid = false;

    return isValid;
}

// 테크페이 비밀번호 유효성 검사
function validatepayPassword() {
    let passwd = $("#techpay_passwd").val(); 
    // 정규식을 통해 숫자 6자리인지 확인
    let isNumeric = /^\d{6}$/.test(passwd);  

    if (!isNumeric) {
        $("#checkPasswdResult").text("숫자 6자리여야 합니다.").addClass("error").removeClass("success");
        return false;
    } else {
        $("#checkPasswdResult").text("유효한 비밀번호입니다!").addClass("success").removeClass("error");
        return true;
    }
}

// 작성한 새 비밀번호와 비밀번호 입력 확인 값 일치 여부 검사
function checkSamePw() {
    let passwd = $("#techpay_passwd").val();
    let passwd2 = $("#techpay_passwd2").val();
    if (passwd !== passwd2) {
        $("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다.").addClass("error").removeClass("success");
        return false;
    } else {
        $("#checkPasswdResult2").text("비밀번호가 일치합니다.").addClass("success").removeClass("error");
        return true;
    }
}

// 현재 비밀번호가 세션의 비밀번호와 같은지 비교
function validateCurrentPassword() {
    let enteredPassword = $("#techpay_passwd_db").val();  
    let sessionPassword = "${sessionScope.pay_pwd}";     

    if (enteredPassword !== sessionPassword) {
        return false;
    }
    return true;
}

$(document).ready(function() {
    // payPwdSetForm 제출 처리
    $('#payPwdSetForm').on('submit', function(e) {
    	
    	// 새 비밀번호 유효성 검사
        let isValid = validateForm(); 
     	// 현재 비밀번호 유효성 검사
        let isCurrentPwdValid = validateCurrentPassword(); 
        
        // 유효하지 않으면 폼 제출 막기
        if (!isCurrentPwdValid || !isValid) {
        	// 폼 제출 방지
            e.preventDefault(); 

        	// 유효하지 않은 상황에 맞는 alert창 띄우기
            if (!isCurrentPwdValid) {
                alert("현재 비밀번호를 올바르게 입력해주세요!"); 
                $("#techpay_passwd_db").focus(); 
            } else if (!isValid) {
                alert("테크페이 비밀번호를 다시 확인해주세요!"); 
            }
        }
    });
    
    // 계좌정보 새 창으로 열기
    $('#accountDetailForm input[type="button"]').on('click', function(e) {
        // 기본 폼 제출 막기
        e.preventDefault();
        // 새 창 열기
        var newWindow = window.open('', 'AccountDetailWindow', 'width=800,height=600');
        // 새 창을 target으로 설정
        $('#accountDetailForm').attr('target', 'AccountDetailWindow');
        // 폼 제출
        $('#accountDetailForm').submit();
    });       
});