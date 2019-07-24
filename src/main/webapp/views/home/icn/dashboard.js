$(function() {
	Metronic.init();

	$(".ek-portlet-contain").each(function() {
		var el = $(this);
		$.ajax({
			url : ctxRoot + el.attr("url"),
			success : function(data) {
				ek.editForm(el, data.rows);
				ek.converHtml(el);
			}
		});
	})

	// 基于准备好的dom，初始化echarts图表
	var myChart = echarts.init(document.getElementById('question1ReportContain'));
	var option = {
		tooltip : {
			show : true
		},
		legend : {
			data : [ '人数' ]
		},
		xAxis : [ {
			type : 'category',
			data : [ "更差", "原样", "好一点", "完美" ]
		} ],
		yAxis : [ {
			type : 'value'
		} ]
	};
	myChart.setOption(option);
	$.ajax({
		url : ctxRoot + "/question/1/report",
		success : function(data) {
			var all = 0;
			for (var n = 0; n < data.length; n++) {
				all += data[n];
			}
			$(".responseNumContain").html(all + " responses");
			myChart.setSeries([ {
				"name" : "人数",
				"type" : "bar",
				"data" : data
			} ]);
		}
	});
});