var products = null;
var currentProductName = 'Levures 500g';

google.load("visualization", "1", {packages:["corechart"]});

$(document).ready(function() {
  loadProducts();

  $("#productForm").on('submit', function(evt) {
    evt.preventDefault();
    currentProductName = $('#productForm select').val();

    loadProducts();
  });
});

function loadProducts() {
  var params = {
    url: '/api/v1/products',
    data: {
      product_name: currentProductName
    }
  }

  var jqxhr = $.ajax(params)
    .done(function(json) {
      $('#loader').hide();
      products = JSON.parse(json)['products'];
      google.charts.setOnLoadCallback(drawChart);
    });
}

function drawChart() {
  var data = google.visualization.arrayToDataTable(products);
  var visibleName = currentProductName ? currentProductName : ''

  var options = {
    title: 'Beer sales ' + visibleName,
    curveType: 'function',
    legend: { position: 'bottom' },
    pointSize: '10'
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

  chart.draw(data, options);
}
