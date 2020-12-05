var products = null;
var currentProductName = 'Levures 500g';

google.load("visualization", "1", {packages:["corechart"]});

$(document).ready(function() {
  loadProducts();

  $("#productForm").on('submit', function(evt) {
    evt.preventDefault();

    currentProductName = $('#productForm select').val();
    var startDate = $('#start').val()
    var endDate = $('#end').val()

    if (!validate(startDate, endDate)) {
      return;
    }

    var opts = { data: { start_date: startDate, end_date: endDate, product_name: currentProductName } }

    $('#loader').show();

    loadProducts(params(opts));
  });
});

function loadProducts(opts = {}) {
  var jqxhr = $.ajax(params(opts))
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

function params(opts) {
  var defaultParams = {
    url: '/api/v1/products',
    data: {
      product_name: currentProductName
    }
  }

  return $.extend(defaultParams, opts)
}

function validate(startDate, endDate) {
  if (!startDate || !endDate) {
    alert("date range not filled!");
    return false;
  }

  return true
}
