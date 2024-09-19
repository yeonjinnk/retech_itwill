let pageNum = 1; // 초기 페이지 번호
let maxPage = 0;
let isLoading = false; // 로딩 상태 플래그
let pay_history_type = "";
let start_date = "";
let end_date = "";

$(function() {
    // 게시물 목록 불러오기
    load_list(pay_history_type, start_date, end_date);

    // "더보기" 버튼 클릭 시
    $("#loadMoreBtn").click(function() {
        if (!isLoading && pageNum <= maxPage) {
            load_list(pay_history_type, start_date, end_date);
        }
    });

    // 모아보기 버튼을 클릭하면 에이젝스를 새로 요청함
    $("[name='options']").change(function() {
        pay_history_type = $(this).val();

        // div 영역과 pageNum을 초기화
        $("#payHistoryList").html(""); // 이전 데이터 초기화
        pageNum = 1; // 페이지 번호 초기화
        load_list(pay_history_type, start_date, end_date);
    });

    // 기간 선택 버튼을 클릭하면 날짜 자동 설정
    $("[name='period']").change(function() {
        // 체크박스 다중 선택 방지
        if ($(this).prop('checked')) {
            $('input[type="checkbox"][name="period"]').prop('checked', false);
            $(this).prop('checked', true);
        }

        // 체크된 체크박스 값 저장
        let period = parseInt($(this).val());

        // 오늘 날짜 설정
        let today = new Date();
        let split_end_date = today.toISOString().split("T");
        end_date = split_end_date[0];
        $("#end_date").val(end_date);

        // 선택한 기간만큼 이전 날짜 설정
        let monthAgo = new Date(today.setMonth(today.getMonth() - period));
        let split_start_date = monthAgo.toISOString().split("T");
        start_date = split_start_date[0];
        $("#start_date").val(start_date);
    });

    // 시작날짜 변경 시 유효성 검사
    $("#start_date").change(function() {
        let start_date_real = new Date($("#start_date").val());
        let end_date_real = new Date($("#end_date").val());

        if (start_date_real > end_date_real) {
            $("#start_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '마지막 날짜보다 이전의 날짜를 선택해주세요.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }

        // 두 날짜 차이가 1년 이상이면 경고
        let timeDiff = Math.abs(end_date_real.getTime() - start_date_real.getTime());
        let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

        if (diffDays >= 365) {
            $("#start_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '1년 이내의 기간만 검색 가능합니다.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }
    });

    // 끝날짜 변경 시 유효성 검사
    $("#end_date").change(function() {
        let start_date_real = new Date($("#start_date").val());
        let end_date_real = new Date($("#end_date").val());

        if (start_date_real > end_date_real) {
            $("#end_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '시작 날짜보다 이후의 날짜를 선택해주세요.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }

        // 두 날짜 차이가 1년 이상이면 경고
        let timeDiff = Math.abs(end_date_real.getTime() - start_date_real.getTime());
        let diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

        if (diffDays >= 365) {
            $("#end_date").val("");
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: '1년 이내의 기간만 검색 가능합니다.',
                showConfirmButton: false,
                timer: 2000,
                toast: true
            });
        }
    });
});

// 게시물 목록을 AJAX와 JSON으로 처리하는 함수
function load_list(pay_history_type, start_date, end_date) {
    if (isLoading) return; // 이미 로딩 중이면 실행하지 않음
    isLoading = true; // 로딩 상태로 변경

    let pay_id = $("#pay_id").val();
    let type = pay_history_type;
    let start = start_date;
    let end = end_date;

    $.ajax({
        type: "GET",
        url: "PayHistoryJson",
        data: {
            "pay_id": pay_id,
            "pay_history_type": type,
            "pageNum": pageNum,
            "start_date": start,
            "end_date": end
        },
        dataType: "json",
        success: function(data) {
            console.log("AJAX 응답 데이터:", data);
            console.log("============data.payHistoryList========== : ", data.payHistoryList);

            if (data.listCount == 0) {
                $("#payHistoryList").append("<div id='list_none'>사용 내역이 없습니다</div>");
            }

            $("#info_left").html("총 <span>" + data.listCount + "</span>건");

            // 연도별로 데이터 그룹화
            let groupedData = {};
            for (let item of data.payHistoryList) {
	            console.log("============item(data.payHistoryList)========== : ", item);
                let year = new Date(item.techpay_tran_dtime).getFullYear();
                if (!groupedData[year]) {
                    groupedData[year] = [];
                }
                groupedData[year].push(item);
            }

            
            
            // 그룹화된 데이터 연도별로 표시
            let years = Object.keys(groupedData).reverse();
            for (let year of years) {
                if ($("#" + year).length === 0) {
                    $("#payHistoryList").append(
                        '<div id="' + year + '">' +
                        '<span id="year">' + year + '년</span>' +
                        '<div class="year_list" id="' + year + 'list"></div>' +
                        '</div>'
                    );
                }

                const paymentArray = groupedData[year];
                for (let history of paymentArray) {
                    let date = history.techpay_tran_dtime.slice(5, 10);
                    let time = history.techpay_tran_dtime.slice(11, 16);
                    console.log("==============history============ : ", history);
                    let pd_idx = history.pd_idx;
                    console.log("==============history.pd_idx============ : ", history.pd_idx);

                    let pay_history_type = "";
                    let subject = "";
                    if (history.techpay_type == "1") {
                        pay_history_type = "충전";
                        subject = "페이충전";
                    } else if (history.techpay_type == "2") {
                        pay_history_type = "환급";
                        subject = "페이환급";
                    } else if (history.techpay_type == "3") {
                        pay_history_type = "사용";
                        subject = '<a href="product_detail?pd_idx=' + history.pd_idx + '&member_id=' + history.id + '">' + history.pd_subject + '</a>';
                    } else if (history.techpay_type == "4") {
                        pay_history_type = "수익";
                        subject = '<a href="product_detail?pd_idx=' + history.pd_idx + '&member_id=' + history.id + '">' + history.pd_subject + '</a>';
                    }

                    let pay_amount = history.tran_amt.toLocaleString();
                    let pay_history_balance = history.pay_balance.toLocaleString();

                    $("#" + year + "list").append(
                        '<div class="row content_list">' +
                        '<div class="col-lg-2 col-md-2 col-12">' +
                        '<h5 class="pay_date">' + date + '</h5>' +
                        '</div>' +
                        '<div class="col-lg-7 col-md-7 col-12 subject-area">' +
                        '<h5 class="product-name">' + subject + '</h5>' +
                        '<p class="pay-info-sub">' + time + ' | ' + pay_history_type + '</p>' +
                        '</div>' +
                        '<div class="col-lg-3 col-md-3 col-12">' +
                        '<h5 class="pay-amount">' + pay_amount + '</h5>' +
                        '<p class="pay-balance-sub">' + pay_history_balance + '</p>' +
                        '</div>' +
                        '</div>'
                    );
                }
            }

            maxPage = data.maxPage; // 끝페이지 번호 갱신
            pageNum++; // 페이지 번호 증가

            // maxPage와 비교하여 더보기 버튼 표시/숨기기
            if (pageNum > maxPage) {
                $("#loadMoreBtn").hide(); // 마지막 페이지에 도달하면 더보기 버튼 숨김
            }

            isLoading = false; // 로딩 상태 해제
        },
        error: function(request, status, error) {
            console.log("AJAX 요청 실패:", status, error);
        }
    });
}

// 모달창에서 조회하기 버튼 눌렀을 때
function select_date() {
    start_date = $("#start_date").val();
    end_date = $("#end_date").val();

    // div 영역과 pageNum 초기화
    $("#payHistoryList").html("");
    pageNum = 1;
    load_list(pay_history_type, start_date, end_date);

    $('#date_modal').modal('hide');

    // 입력한 기간을 판별하여 표시
    if ($("input[name='period']:checked").val() != null && $("input[name='period']:checked").val() != "") {
        let checked = $("input[name='period']:checked").val();
        if (checked == 12) {
            $("#info_right").html("1년");
        } else {
            $("#info_right").html(checked + "개월");
        }
    } else if (start_date != "" && end_date != "") {
        $("#info_right").html(start_date + " ~ " + end_date);
    } else {
        $("#info_right").html("전체기간");
    }

    $('input[name="period"]').prop('checked', false);
}
