
var jqxhr = $.ajax('/api/v1/products')
  .done(function(data) {
    alert('yeee')
    console.log(data)
  })
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var array = [["date","sales"],["2020-11-26 18:18:16 +0300",11],["2020-11-25 00:00:00 +0300",11],["2020-11-27 00:00:00 +0300",11],["2020-11-26 20:43:16 +0300",11],["2020-12-04 19:51:45 +0300",11],["2020-12-04 19:51:45 +0300",11],["2020-12-04 19:51:45 +0300",11],["2020-12-04 19:51:45 +0300",11],["2020-12-04 19:51:45 +0300",11],["2020-12-04 19:51:45 +0300",11]]
  var data = google.visualization.arrayToDataTable(array);

  var options = {
    title: 'Company Performance',
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

  chart.draw(data, options);
}
