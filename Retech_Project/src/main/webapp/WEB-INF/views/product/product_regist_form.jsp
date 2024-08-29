<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 반응형웹페이지를 위한 설정 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">
//이미지 추가 버튼 스크립트
   let preview_array = [false, false, false, false, false];
   //이미지 등록 시 미리보기 추가 작업
   function img_preview() {
      for (var i = 0; i < preview_array.length; i++) {
         //i가 0일 때
         if(i == 0){
            //0번 사진 비어있는 경우
            if(preview_array[0] == false){
               //섬네일 사진
               //0번 사진 인풋태그 호출
               send_0();
               return;
            }
            //1번 사진 비어있는 경우
            if(preview_array[1] == false){
               //섬네일 사진
               //1번 사진 인풋태그 호출
               send_1();
               return;
            }
            //2번 사진 비어있는 경우
            if(preview_array[2] == false){
               //섬네일 사진
               //2번 사진 인풋태그 호출
               send_2();
               return;
            }
            //3번 사진 비어있는 경우
            if(preview_array[3] == false){
               //섬네일 사진
               //3번 사진 인풋태그 호출
               send_3();
               return;
            }
            //4번 사진 비어있는 경우
            if(preview_array[4] == false){
               //섬네일 사진
               //4번 사진 인풋태그 호출
               send_4();
               return;
            }
         }
      }
      alert("더 이상 사진을 등록할 수 없습니다!")
      return;
   }
   
   //프리뷰 파트 끝==========================================================================================
   
    // 상품 카테고리 공통코드 사용 함수
      let pd_category;
      $(function () {
          $("select").eq(0).on("change", function() {
             let product = "PRODUCT";
             let product1 = $("#c_id").val();
             let product2 = $("#c_id2").val();
//                $("#pd_category_hidden").hidden = pd_category;
				pd_category = product +  product1 + product2;
             $("#pd_category_hidden").val(pd_category);
//                $("#text").html("pd_category");
             console.log("product : " + product);
             console.log("product1 : " + product1);
             console.log("product2 : " + product2);
             console.log("pd_category : " + pd_category);
             console.log("pd_category : " +  $("#pd_category_hidden").val());
          });
            
       });
   	
    
     
//----------------------------------------------------------------------------------------------------------------------
// 이미지 갯수 표현 함수
   function img_num() {
      let img_number = 0;
      for (var i = 0; i < preview_array.length; i++) {
         if(preview_array[i] == true){
            img_number++;
         }
      }
      //이미지 갯수 표시
      $("#img_number").html('(' + img_number + '/5)')
   }
//----------------------------------------------------------------------------------------------------------------------

   function send_0() {
      $("#sumimage").click();      
   }
   
   $(function() {
      $("#sumimage").on('change',function(){
         if($("#sumimage")[0].files[0] == undefined){
            return;
         }
         imgcheck0(this);
      })
   });

   
//이미지 미리보기 --------------------------------------------------------------------------------------------------------

   function imgcheck0(input) {
      //이미지 확장자 파일체크
      let file_kind = input.value.lastIndexOf('.');
      let file_name = input.value.substring(file_kind+1,input.length);
      let file_type = file_name.toLowerCase();
      
      let check_array = new Array( 'jpg','png','jpeg' );
      
      $('#sumimage').val();
      
      if(check_array.indexOf(file_type)==-1){
         
         // 사용자에게 알려주고 
         alert('이미지 파일만 선택할 수 있습니다.');
         // 실제 업로드 되는 input태그 vlaue값 지우기 
         $('#sumimage').val('');
         
         return;
      
      }    
      
       if (input.files && input.files[0]) {
           let reader = new FileReader();
           reader.onload = function (e) {
              $('#imgup_sum').attr('src', e.target.result);
              
              $("#img_preview0").css("display","inline-block");
            $("#imgup_sum").show();
              $("#del_sum").show();
             
            preview_array[0] = true;
            
            /* 이미지넘버 변경 */
            img_num();
           }
           reader.readAsDataURL(input.files[0]);
        }
   }
   
   //1번 사진 
   
   function send_1() {
      $("#imageFile1").click();
   }
   $(function() {
      $("#imageFile1").on('change', function() {
         //파일 선택을 취소하였을 때
         if($("#imageFile1")[0].files[0] == undefined){
            return;
         }
         imgcheck1(this);
      })
   });
   
   function imgcheck1(input) {
      //이미지 확장자 파일체크
      let file_kind = input.value.lastIndexOf('.');
      let file_name = input.value.substring(file_kind+1, input.length);
      let file_type = file_name.toLowerCase();
      
      let check_array = new Array('jpg', 'png', 'jpeg');
      
      if(check_array.indexOf(file_type) == -1){
         alert('이미지 파일만 선택할 수 있습니다.');
         //실제 업로드되는 input태그 value값 지우기
         $('#imageFile1').val('');
         return;
      }
      if(input.files && input.files[0]){
         let reader = new FileReader();
         reader.onload = function(e) {
            
            $('#imgup_1').attr('src', e.target.result);
            //배열에 트루값주기, 트루면 업로드 못함
            
            $("#img_preview1").css("display", "inline-block");
            $("#imgup_1").show();
            $("#del_img1").show();
            
            preview_array[1] = true;
            
            //이미지 넘버 변경
            img_num();
         }
         reader.readAsDataURL(input.files[0]);
      }
   }
   //2번 사진
   function send_2() {
      $("#imageFile2").click();
   }
   
   $(function() {
      $("#imageFile2").on('change', function() {
         //파일 선택을 취소하였을 때
         if($("#imageFile2")[0].files[0] == undefined){
            return;
         }
         imgcheck2(this);
      })
   });   

   
   function imgcheck2(input) {
      
      /* 이미지 확장자 파일체크 */
      let file_kind = input.value.lastIndexOf('.');
      let file_name = input.value.substring(file_kind+1,input.length);
      let file_type = file_name.toLowerCase();

      let check_array = new Array( 'jpg','png','jpeg' );
      
      if(check_array.indexOf(file_type)==-1){
         alert('이미지 파일만 선택할 수 있습니다.');
         /* 실제 업로드 되는 input태그 vlaue값 지우기 */
         $('#imageFile2').val('');
         
         return;
      
      } 
      
      
       if (input.files && input.files[0]) {
          let reader = new FileReader();
           reader.onload = function (e) {
            $('#imgup_2').attr('src', e.target.result);
            
             $("#img_preview2").css("display","inline-block");
            $("#imgup_2").show();
            $("#del_img2").show();
            
            preview_array[2] = true;
              /* 이미지넘버 변경 */
            img_num();
          
           }
           
           reader.readAsDataURL(input.files[0]);
       }
   }
   //3번 이미지
   function send_3() {
      $("#imageFile3").click();
   }
   $(function() {
      $("#imageFile3").on('change', function() {
         //파일 선택을 취소하였을 때
         if($("#imageFile3")[0].files[0] == undefined){
            return;
         }
         imgcheck3(this);
      })
   });   
   function imgcheck3(input) {
         
         /* 이미지 확장자 파일체크 */
         let file_kind = input.value.lastIndexOf('.');
         let file_name = input.value.substring(file_kind+1,input.length);
         let file_type = file_name.toLowerCase();
   
         let check_array = new Array( 'jpg','png','jpeg' );
         
         if(check_array.indexOf(file_type)==-1){
            alert('이미지 파일만 선택할 수 있습니다.');
            /* 실제 업로드 되는 input태그 vlaue값 지우기 */
            $('#imageFile3').val('');
            
            return;
         
         } 
         
         
          if (input.files && input.files[0]) {
             let reader = new FileReader();
              reader.onload = function (e) {
               $('#imgup_3').attr('src', e.target.result);
               
                $("#img_preview3").css("display","inline-block");
               $("#imgup_3").show();
               $("#del_img3").show();
               
               preview_array[3] = true;
                 /* 이미지넘버 변경 */
               img_num();
             
              }
              
              reader.readAsDataURL(input.files[0]);
          }
      }
   //4번 이미지
   function send_4() {
      $("#imageFile4").click();
   }
   $(function() {
      $("#imageFile4").on('change', function() {
         //파일 선택을 취소하였을 때
         if($("#imageFile4")[0].files[0] == undefined){
            return;
         }
         imgcheck4(this);
      })
   });   
   function imgcheck4(input) {
         
         /* 이미지 확장자 파일체크 */
         let file_kind = input.value.lastIndexOf('.');
         let file_name = input.value.substring(file_kind+1,input.length);
         let file_type = file_name.toLowerCase();
   
         let check_array = new Array( 'jpg','png','jpeg' );
         
         if(check_array.indexOf(file_type)==-1){
            alert('이미지 파일만 선택할 수 있습니다.');
            /* 실제 업로드 되는 input태그 vlaue값 지우기 */
            $('#imageFile3').val('');
            
            return;
         
         } 
         
         
          if (input.files && input.files[0]) {
             let reader = new FileReader();
              reader.onload = function (e) {
               $('#imgup_4').attr('src', e.target.result);
               
                $("#img_preview4").css("display","inline-block");
               $("#imgup_4").show();
               $("#del_img4").show();
               
               preview_array[4] = true;
                 /* 이미지넘버 변경 */
               img_num();
             
              }
              
              reader.readAsDataURL(input.files[0]);
          }
      }
   
//이미지 미리보기 삭제
   
   function del_sum() {
      //실제 DB에 들어가는 input value 지움
      $('#sumimage').val('');
      
      $("#img_preview0").css("display", "none");
      $('#imgup_sum').hide();
      $("#del_sum").hide();
      
      //썸네일 비움
      preview_array[0] = false;
      
      //이미지 넘버변경
      img_num();
      
      return;
   }
      
   function del_img1() {
      
      $('#imageFile1').val('');
      
      $("#img_preview1").css("display","none");
      $('#imgup_1').hide();
      $("#del_img1").hide();
      
      // 1번사진 비움 
      preview_array[1] = false;
      
      // 이미지 넘버변경 
      img_num();
      
      return;
   }
   
   function del_img2() {
      
      $('#imageFile2').val('');
      
      $("#img_preview2").css("display","none");
      $('#imgup_2').hide();
      $("#del_img2").hide();
      
      // 2번사진 비움 
      preview_array[2] = false;
      
      // 이미지 넘버변경 
      img_num();
      
      return;
   }   
   function del_img3() {
      
      $('#imageFile3').val('');
      
      $("#img_preview3").css("display","none");
      $('#imgup_3').hide();
      $("#del_img3").hide();
      
      // 3번사진 비움 
      preview_array[3] = false;
      
      // 이미지 넘버변경 
      img_num();
      
      return;
   }   
   function del_img4() {
      
      $('#imageFile4').val('');
      
      $("#img_preview4").css("display","none");
      $('#imgup_4').hide();
      $("#del_img4").hide();
      
      // 4번사진 비움 
      preview_array[4] = false;
      
      // 이미지 넘버변경 
      img_num();
      
      return;
   }   

//====================================================================================================================

//<!-- 주소API -->-------------------------------------------
   function addrFind() {
      
      let width = 500; //팝업의 너비
      let height = 300; //팝업의 높이
      
      
       new daum.Postcode({
           oncomplete: function(data) {
            
               $("#p_location").val(data.address);
           },
       
          theme: {
              searchBgColor: "#7dd87d", //검색창 배경색
              queryTextColor: "white" //검색창 글자색
          },
          
          width: width, 
          height: height
          
       
       
       }).open({
           left: (window.screen.width / 2) - (width / 2),
           top: (window.screen.height / 2) - (height / 2) - 200
       });
      
   }

//--------------------------------------------------------------------------------------------------------------------------
//본격적인 데이터 넣기------------------------------------------------------------------------------------------------------
   
	let regular_han = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-z|A-Z]/;
	
	function proInfoSend() {
      
      //세션으로부터 받은 member_id값
      let member_id = $("#member_id").val().trim();
      
      let p_name = $("#p_name").val().trim();
      let c_id = $("#c_id").val();
      let c_id2 = $("#c_id2").val();
      
      let p_price = $("#p_price").val().trim();
      let p_exp = $("#p_exp").val().trim();
      let sumimage = $("#sumimage").val(); 
      
      if(sumimage == ''){
         alert('대표 이미지를 반드시 등록해주세요.');
         $("#imgup").focus();
         return;
      }
      
      if(p_name==''){
         alert('제목이 비어있습니다. (필수입력, 공백불가)');
         $("#p_name").val('');
         $("#p_name").focus();
         return;
      }
      
      if(c_id==0){
         alert('카테고리를 모두 선택하세요. ');
         $("#c_id").focus();
         return;
      }
      
      if(c_id2==0){
         alert('카테고리를 모두 선택하세요. ');
         $("#c_id2").focus();
         return;
      }
      
      if(p_price==''){
         
         alert('가격이 비어있습니다.');
         $("#p_price").val('');
         $("#p_price").focus();
         return;
      }
      
      if(p_exp==''){
         
         alert('상품 설명이 비어있습니다. ');
         $("#p_exp").val('');
         $("#p_exp").focus();
         return;
      }

      
      if( regular_han.test(p_price) ){
         alert('숫자만 입력 가능합니다.');
         $("#p_price").val('');
         $("#p_price").focus();
         return;
      } 
      
  
   
      // 가격 콤마 제거 
      p_price = p_price.replace(/,/g, "");
      
      if(p_price < 100){
         alert('가격은 100원 이상 입력해주세요.');
         $("#p_price").val('');
         $("#p_price").focus();
         return;
      }
      
      
      if(confirm('등록 하시겠습니까?') == false) return;
      
      let form = $("#imgform")[0];
      let formData = new FormData(form);
      
      //이미지
      //필수 이미지 = sumimage

      formData.append('file1',$('#sumimage')[0].files[0]);
      if($('#imageFile1')[0].files[0]!=undefined){
         formData.append('file2',$('#imageFile1')[0].files[0]);   
      }
      if($('#imageFile2')[0].files[0]!=undefined){
         formData.append('file3',$('#imageFile2')[0].files[0]);
      }
      if($('#imageFile3')[0].files[0]!=undefined){
         formData.append('file4',$('#imageFile3')[0].files[0]);
      }
      if($('#imageFile4')[0].files[0]!=undefined){
         formData.append('file5',$('#imageFile4')[0].files[0]);
      }
      formData.append('member_id', member_id);      // 유저idx
      formData.append('pd_subject',p_name);         // 상품명
      
      
      formData.append('pd_price',p_price);         // 가격
      formData.append('pd_content',p_exp);            // 상품설명
      formData.append('pd_category', pd_category);		//카테고리
      /*   
         파일 데이터를 ajax처리 하기 위해선
         반드시 processData,contentType 들을 false 해주기
       */
      
       $.ajax({
         
         url     : 'ProductRegistPro',
         type    : 'POST',
         data    : formData,
         processData : false,
         contentType : false,
         dataType : 'json',
         success  : function(res){
            if(res == true){
               alert('해당 상품이 정상적으로 등록되었습니다!');
               location.href='${pageContext.request.contextPath }/ProductList';
            }
         },error  : function(err){
            alert('해당 상품에 실패했습니다. 관리자나 1:1 게시판에 문의하세요.');
         }
      });
   }
   
   // 상품등록을 취소하게 하는 함수(procancel)   
   function procancel(){
      
      if(confirm('상품등록을 취소하시겠습니까?')==false) return;
      
      history.back();

      
   }   
 //================================================================================
	  //<!-- 가격 함수 (실시간 콤마, 한글입력불가) -->------------
  	  
     $(function() {

        $("#p_price").on("propertychange change keyup paste input", function() {
           
           
          let p_price = $(this).val() ;
           
           if(p_price<100 ){
              $("#price_under").show();
              $("#price_under").text('100원 이상만 입력하세요.').css('color','red');
               $("#p_price").css('outline','1px solid red');
              $("#p_price").css('border-color','red');
              
           }
           
           if(p_price>=100 || p_price=='' ){
              $("#price_under").hide();
              $("#p_price").css('border-color','black');
              $("#p_price").css('outline','black');
           }
           
           /* 숫자 comma 찍는 함수 */
           p_price = comma(uncomma(p_price));
           
           
           console.log(p_price);
           
           $("#p_price").val(p_price);

        });

     });
 	// 실제 입력값을 변경해주는 함수
 	function comma(str) {
	    str = String(str);
	    
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function uncomma(str) {
	    str = String(str);
	    
	    if(regular_han.test(str)){
	    	alert('숫자만 입력하세요');
	    }
	    
	    return str.replace(/[^\d]+/g, '');
	}

//------------------------------------------------------------------------------------------------------------------------
//실시간 글자수 체크 코드!!-----------------------------------------------------------------------------------------------
   
   $(function() {
       $("#p_name").on("input", function() {
           let p_name_length = $(this).val().length;
           $("#name_length").html(p_name_length + '/40');
   
           // 입력된 값이 최대 길이를 넘지 않도록 처리
           numberMaxLength(this);
       });
   
       $("#p_exp").on("input", function() {
           let p_exp_length = $(this).val().length;
           $("#exp_length").html(p_exp_length + '/1000');
   
           // 입력된 값이 최대 길이를 넘지 않도록 처리
           numberMaxLength(this);
       });
   });
   function numberMaxLength(e) {
       if (e.value.length > e.maxLength) {
           e.value = e.value.slice(0, e.maxLength);
       }
   }


   $(function() {

      $("#p_name").on("propertychange change keyup paste input", function() {

         var p_name = $(this).val().length;

         /* console.log(p_name); */

         $("#name_length").html(p_name + '/40')

      });

   })

   $(function() {

      $("#p_exp").on("propertychange change keyup paste input", function() {

         var p_exp = $(this).val().length;

         $("#exp_length").html(p_exp + '/1000')

      });

   })
   

</script>

<style>
body {
	font-family: 'Gowun Dodum', sans-serif;
}

#root {
	/*       background: #ccffcc; */
	width: 100%;
	height: 100%;
}

/* 실제 전체 div */
#insert_box {
	width: 1020px;
	margin: auto;
	padding-top: 160px;
	/*       background: gray; */
	min-height: 1000px;
	text-align: center;
}

/* 인클루드 한 메인프레임 */
#mainframe {
	/* position : absolute; */
	/* z-index: 999; */
	
}

#title {
	font-size: 40px;
}

/* span태그 */
.pro_info {
	font-size: 20px;
}

/* 전체 인풋태그 css */
/* 현재 CSS에서 입력 필드에 접근성을 높이기 위해 z-index를 조정할 수 있습니다. */
.input-tag {
	/*        position: relative; /* position 속성을 추가 */ */
	/* z-index 값을 추가하여 다른 요소보다 위로 표시되도록 합니다. */
	display: inline-block;
	height: 35px;
	padding: 5px;
	vertical-align: middle;
	border: 1px solid black;
	width: 100%;
	color: black;
	font-size: 15px;
	border-radius: 5px;
}

/* 혹시 다른 요소들이 입력 필드 위에 겹치는 경우를 대비하여 */
#insert_box {
	position: relative;
	z-index: 5; /* 필요한 경우 z-index 값을 낮게 설정합니다. */
}

/* 부모 요소나 관련된 다른 요소에서 pointer-events 속성을 확인합니다. */
input, select, textarea {
	pointer-events: auto; /* pointer-events가 none으로 설정된 경우 auto로 변경합니다. */
}

/* 이미지 미리보기 css */
#img_preview0, #img_preview1, #img_preview2, #img_preview3,
	#img_preview4, #img_preview5 {
	display: none;
	position: relative;
	margin: 5px;
	width: 150px;
	height: 150px;

	/*       border: 2px solid black; */
}
/* footer부분 밑으로 고정css*/
footer {
	background-color: #f8f9fa; /* 원하는 배경색으로 설정 */
	padding: 10px;
	text-align: center;
	position: relative; /* 필요한 경우 relative로 설정 */
	bottom: -100;
	width: 100%;
}
/* 미리보기 삭제버튼 css */
#sum_style {
	text-align: center;
	width: 75px;
	height: 20spx;
	position: absolute;
	font-size: 12px;
	outline: none;
	border: none;
	border-radius: 15px;
	right: 70px;
	bottom: 130px;
	/* z-index:1; */
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
}

.chk_style {
	vertical-align: middle;
	text-align: center;
	width: 28px;
	height: 28px;
	position: absolute;
	/* font-size:20px; */
	outline: none;
	border: none;
	border-radius: 18px;
	right: 9px;
	bottom: 115px;
	/* z-index:1; */
	background-color: rgba(0, 0, 0, 0.5);
	color: #ffcccc;
}

/* 미리보기 삭제 css */
#del_img1, #del_img2, #del_img3, #del_img4, #del_sum {
	cursor: pointer;
	display: none;
}

#imgup {
	margin-top: 5px;
}

/* 이미지 미리보기 css */
#imgup_1, #imgup_2, #imgup_3, #imgup_4, #imgup_sum {
	cursor: pointer;
	display: none;
}

.input-tag:focus {
	outline: none;
	border: 1px solid black;
}

/* 제목입력창 넓이 */
#p_name {
	width: 88%;
}

/* 제품설명 textarea css */
#p_exp {
	padding: 15px;
	width: 100%;
	height: 150px;
	resize: none;
}

/* 주소버튼 */
#addrfind, #myaddr {
	background: white;
	cursor: pointer;
	border: 1px solid black;
	width: 90px;
	height: 40px;
}

/* 상품 상태 */
/*    #p_condition { */
/*       width: 15px; */
/*       height: 15px; */
/*    } */

/* 거래 방법*/
#p_delivery_type {
	width: 15px;
	height: 15px;
}

/* 결제방법 */
#p_paymentType {
	width: 15px;
	height: 15px;
}

input {
	accent-color: red;
}

/* 테이블 간의 간격 */
td {
	width: 1020px;
	/*       padding: 0.8em 1.4em 0.5em 0.8em; */
}

.td1 {
	width: 20%;
	vertical-align: top;
}

.td2 {
	width: 80%;
}

#img_zone {
	/* background-color: black; */
	margin: auto;
	width: 65%;
	min-height: 50px;
	margin-bottom: 50px;
}

#img_intro {
	font-size: 16px;
	color: skyblue;
	/* background-color: #ccffcc; */
	margin: auto;
	width: 65%;
	min-height: 50px;
}
</style>


<title>Retech 메인페이지</title>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<!-- 이미지 파일 업로드용 폼 -->
	<form enctype="multipart/form-data" id="imgform" method="post">
		<input type="file" id="sumimage" style="display: none;" accept=".jpg, .jpeg, .png"> 
		<input type="file" id="imageFile1" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile2" style="display: none;" accept=".jpg, .jpeg, .png">
		<input type="file" id="imageFile3" style="display: none;" accept=".jpg, .jpeg, .png"> 
		<input type="file" id="imageFile4" style="display: none;" accept=".jpg, .jpeg, .png"> 
		<input type="file" id="imageFile5" style="display: none;" accept=".jpg, .jpeg, .png">
	</form>
	<div id="root">
		<input type="hidden" id="member_id" value="${sessionScope.member_id}">

		<div id="insert_box">
			<span id="title">상품등록</span>

			<table style="margin-top: 30px;">
				<!-- 기본정보 -->
				<tr>
					<td colspan="2" align="left"><span class="pro_info">기본정보</span> &nbsp;&nbsp;&nbsp; <span style="font-size: 14px; color: red">*필수항목</span></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>

				<!-- 상품이미지 -->
				<tr>
					<td class="td1" align="left">
						<span class="pro_info">등록 상품 이미지</span> 
						<span class="pro_info" id="img_number">(0/5)</span> 
						<span style="color: red">*</span> 
						<input type="image" id="imgup" onclick="img_preview();"src="${ pageContext.request.contextPath }/resources/img/image_upload.png" width="150px" height="150px">
					</td>
					<td class="td2" align="left">
						<!-- 이미지 등록 영역 -->
						<div id="img_zone">
							<div id="img_preview0">
								<input type="image" id="imgup_sum" onclick="send_0();" src="" width="150px" height="150px" required="required"> 
								<span id="sum_style">대표 이미지</span>
								<!-- 삭제버튼 -->
								<span id="del_sum" class="chk_style" onclick="del_sum();">x</span>
							</div>
							<div id="img_preview1">
								<input type="image" id="imgup_1" onclick="send_1();" src="" width="150px" height="150px">
								<!-- 삭제버튼 -->
								<span id="del_img1" class="chk_style" onclick="del_img1();">x</span>
							</div>
							<div id="img_preview2">
								<input type="image" id="imgup_2" onclick="send_2();" src="" width="150px" height="150px">
								<!-- 삭제버튼 -->
								<span id="del_img2" class="chk_style" onclick="del_img2();">x</span>
							</div>
							<div id="img_preview3">
								<input type="image" id="imgup_3" onclick="send_3();" src="" width="150px" height="150px">
								<!-- 삭제버튼 -->
								<span id="del_img3" class="chk_style" onclick="del_img3();">x</span>
							</div>
							<div id="img_preview4">
								<input type="image" id="imgup_4" onclick="send_4();" src="" width="150px" height="150px">
								<!-- 삭제버튼 -->
								<span id="del_img4" class="chk_style" onclick="del_img4();">x</span>
							</div>
						</div>
						<div id="img_intro">

							* <b>대표 이미지</b>는 반드시 <font color="red"><b>등록</b></font>해야 합니다.<br> - <b>최소한</b> <font color="red"><b>3장의</font></b>이미지를 등록하셔야합니다.<br>- .jpg, .jpeg, .png</b> 만 등록 가능합니다.<br> - 이미지를 <b>클릭할</b> 경우 이미지를 <b>수정</b>하실 수 있습니다.<br> - 이미지 등록은 좌측 <b>이미지
								등록</b>을 눌러 등록할 수 있습니다.<br> - 이미지 확장자는 <b>.jpg, .jpeg, .png</b> 만 등록 가능합니다.
						</div>

					</td>
				</tr>
				<!-- 이미지영역끝 -->
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 제목  -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span class="pro_info">제목<span style="color: red">*</span></span></td>
					<td class="td2" align="left">
						<div style="display: inline-block; min-width: 70px;">
							<span class="pro_info" id="name_length">0/40</span>
						</div> <input maxlength="40" oninput="numberMaxLength(this);" type="text" id="p_name" name="p_name" class="input-tag" placeholder="제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 카테고리 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span class="pro_info">카테고리<span style="color: red">*</span></span></td>
					<td class="td2" align="left"><select class="input-tag" id="c_id" name="c_id" style="width: 30%; height: 35px;">
							<option value="">카테고리 선택</option>
							<option value="PC">PC</option>
							<option value="NB">노트북</option>
					</select> <select class="input-tag" id="c_id2" name="c_id2" style="width: 30%; height: 35px;">
							<option value="">카테고리 선택</option>
							<option value="SA">삼성</option>
							<option value="AP">애플</option>
							<option value="LG">LG</option>
							<option value="ET">기타</option>
					</select> <input type="hidden" name="pd_category" id="pd_category_hidden"></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<!-- 결제방법 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span class="pro_info">가격<span style="color: red">*</span></span></td>
					<td class="td2" align="left"><input type="text" id="p_price" maxlength="11" name="p_price" class="input-tag" placeholder="가격"
						oninput="numberMaxLength(this);" style="width: 30%;"> &nbsp; <span class="pro_info">원</span> <br> <span class="pro_info"
						id="price_under"></span></td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>

				<!-- 상품설명 -->
				<tr>
					<td class="td1" align="left" style="vertical-align: top;"><span class="pro_info">상품설명<span style="color: red">*</span></span></td>
					<td align="left"><br>
						<div>
							<textarea class="input-tag" id="p_exp" name="p_exp" maxlength="1000" oninput="numberMaxLength(this);"
								placeholder="구입연도, 브랜드, 사용감, 직거래시 거래지역, 하자유무 등 필요한 정보를 넣어주세요. &#13;&#10;구매자의 문의를 좀더 줄일 수 있습니다."></textarea>
						</div>
						<div align="right">
							<span style="font-size: 18px;" id="exp_length">0/1000</span>
						</div></td>
				</tr>

				<tr>
					<td colspan="2"><hr></td>
				</tr>

				<!-- 등록 취소버튼 -->
				<tr>
					<td colspan="2"><input class="btn btn-success" type="button" value="등록하기" onclick="proInfoSend();"> <input class="btn btn"
						type="button" value="취소하기" onclick="procancel()"></td>
				</tr>
			</table>

		</div>
	</div>
	<div style="min-height: 200px;"></div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>