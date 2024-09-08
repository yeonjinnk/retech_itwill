<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>CodePen - Chart.js 3.8 Pie Chart (Base)</title>
  <link rel="stylesheet" href="./style.css">
<style type="text/css">
.chart-container { 
  width: 400px;
  height: 600px;
  border: 1px solid #ddd;
  padding: 10px;
  border-radius: 4px;
}

</style>
</head>
  <script src='https://cdn.jsdelivr.net/npm/chart.js'>
  const data = {
		  labels: [
		    'Red',
		    'Blue',
		    'Yellow'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [300, 50, 100],
		    backgroundColor: [
		      'rgb(255, 99, 132)',
		      'rgb(54, 162, 235)',
		      'rgb(255, 205, 86)'
		    ],
		    hoverOffset: 4
		  }]
		};

		const config = {
		  type: 'doughnut',
		  data: data,
		  options:{
		    maintainAspectRatio:false,
		    cutout:'80%'
		  }
		};

		const myPieChart = new Chart(
		  document.getElementById('pie-chart'),
		  config
		);
</script>
<body>
		<div class="chart-container">
		  <canvas id="pie-chart"></canvas>
		</div>	

</body>
</html>