<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>차트</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chart.css">
  <link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/resources/css/admin_default.css" rel="stylesheet" type="text/css">
  <script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
  <script src='https://cdn.jsdelivr.net/npm/chart.js'></script>
</head>
<body>
  <header>
    <jsp:include page="/WEB-INF/views/inc/admin_top.jsp"></jsp:include>  
  </header>
  <div class="inner">
    <section class="wrapper">
      <jsp:include page="/WEB-INF/views/inc/admin_side_nav.jsp"></jsp:include>
      <article>
      </article>
    </section>
  </div>

  <!-- 차트 컨테이너 -->
  <div class="chart-container">
    <canvas id="line-chart"></canvas>
    <!-- 라인 차트 -->
  </div>

  <div class="chart-container">
    <canvas id="pie-chart"></canvas>
    <!-- 파이 차트 -->
  </div>

  <!-- JavaScript 코드 -->
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const memberData = JSON.parse('${memberData}');  // 데이터를 안전하게 전달
        console.log('Member Data:', memberData);

        // 오늘 날짜를 기준으로 7일 전 날짜를 생성하는 함수
        function getLast7Days() {
            const today = new Date();
            const dates = [];
            
            for (let i = 6; i >= 0; i--) {
                const date = new Date(today);
                date.setDate(today.getDate() - i);
                dates.push(date.toISOString().split('T')[0]); // YYYY-MM-DD 형식
            }
            
            return dates;
        }

        // 날짜를 YYYY-MM-DD 형식으로 변환하는 함수
        function formatDate(dateString) {
            const date = new Date(dateString);
            if (isNaN(date.getTime())) {
                console.error('Invalid date:', dateString); // 디버깅: 유효하지 않은 날짜
                return null; // 유효하지 않은 날짜
            }
            return date.toISOString().split('T')[0];
        }

        // 7일 전 날짜를 라벨로 설정
        const labels = getLast7Days();
        console.log('Labels:', labels); // 디버깅: 날짜 라벨 확인

        // 날짜별 가입자 수를 집계
        const subscriptions = labels.map(date => {
            const count = memberData.reduce((acc, item) => {
                const itemDate = formatDate(item.member_subscription); // 가입일자 확인
                console.log('Item Date:', itemDate, 'Comparing with:', date); // 디버깅: 날짜 비교
                return itemDate === date ? acc + 1 : acc; // 가입일자가 주어진 날짜와 일치하면 acc를 증가
            }, 0);
            console.log('Date:', date, 'Count:', count); // 디버깅: 날짜별 가입자 수
            return count; // 해당 날짜의 가입자 수
        });

        // 차트 데이터 설정
        const member_subscription = {
            label: '가입자 수',
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 0, 0)',
            data: subscriptions, // 서버에서 받은 데이터로 업데이트
        };

        const chartData = {
            labels: labels, // 7일 전부터 오늘까지의 날짜
            datasets: [member_subscription]
        };

        const config = {
            type: 'line',
            data: chartData,
            options: {
                maintainAspectRatio: false
            }
        };

        const lineCtx = document.getElementById('line-chart').getContext('2d');
        new Chart(lineCtx, config);

        // 파이 차트
        const productData = JSON.parse('${productData}');  // 데이터를 안전하게 전달
        console.log('Product Data:', productData);
        
        const extractLastTwoChars = (str) => str.slice(-2);
        
        const counts = productData.reduce((acc, item) => {
            const key = extractLastTwoChars(item.pd_category);
            acc[key] = (acc[key] || 0) + 1;
            return acc;
        }, {});

        const pieLabels = Object.keys(counts);
        const pieData = Object.values(counts);
        const pieColors = [
          "rgb(153,21,0)",
          "rgb(189,90,45)",
          "rgb(208,255,113)",
          "rgb(255,36,0)",
        ].slice(0, pieLabels.length);

        const pieCtx = document.getElementById('pie-chart').getContext('2d');
        
        const pieChart = new Chart(pieCtx, {
          type: 'pie',
          data: {
            labels: pieLabels,
            datasets: [
              {
                data: pieData,
                backgroundColor: pieColors
              }
            ]
          },
          options:{
            plugins:{
              legend:{
                display:true,
                labels:{
                  color:'blue',
                  font:{
                    size: '20px',
                    style:'italic'
                  }
                }
              }
            }
          }
        });
    });
  </script>
</body>
</html>
