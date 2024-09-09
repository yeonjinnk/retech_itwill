document.addEventListener('DOMContentLoaded', function() {
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

  // 7일 전 날짜를 라벨로 설정
  const labels = getLast7Days();

  // 차트 데이터 예시
  const member_subscription = {
    label: '가입자 수',
    backgroundColor: 'rgb(255, 99, 132)',
    borderColor: 'rgb(255, 0, 0)',
    data: [10, 5, 5, 4, 10, 5, 20], // 예시 데이터
  };


  const data = {
    labels: labels,
    datasets: [member_subscription]
  };

  const config = {
    type: 'line',
    data: data,
    options: {
      maintainAspectRatio: false
    }
  };

  const ctx = document.getElementById('line-chart').getContext('2d');
  new Chart(ctx, config);
});
