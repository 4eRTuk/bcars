$(document).ready(function() {
var optSum = 0, prepSum = 0;
var opts = [], preps = [];
	
	var clr = '#ffffff';
	var clr_name = '';
	var totalSum = 0;
	totalSum = parseInt($("#total-sum").text());
	$("#spec-sum").text(formatCurrency(totalSum));
	updateSums();
	$('#engines li input').first().prop("checked", true);
	$('#engines li').first().addClass("selected");
	$("#engine-sum").text($('#engines li label').first().text());
	
    $('#tab_c2 .add').click(function(e) {
		o_id = $.inArray($(this).attr("data-opt-id"), opts);
		
		if (o_id == -1) {
			opts.push($(this).attr("data-opt-id"));
			$(this).text("Добавлено");
			$(this).css('background', '#BB0000');
			//sum = parseInt($(this).attr("data-price")) + parseInt($("#total-opts-sum").text());
			optSum += parseInt($(this).attr("data-price"));
			totalSum += parseInt($(this).attr("data-price"));
		}
		else {
			opts.splice(o_id, 1);
			$(this).text("Добавить");
			$(this).css('background', '');
			//sum = parseInt($("#total-opts-sum").text()) - parseInt($(this).attr("data-price"));
			optSum -= parseInt($(this).attr("data-price"));
			totalSum -= parseInt($(this).attr("data-price"));			
		}
		
		updateSums();
    });
	
    $('#tab_c3 .add').click(function(e) {
		o_id = $.inArray($(this).attr("data-prep-id"), preps);
		
		if (o_id == -1) {
			preps.push($(this).attr("data-prep-id"));
			$(this).text("Добавлено");
			$(this).css('background', '#BB0000');
			//sum = parseInt($(this).attr("data-price")) + parseInt($("#total-opts-sum").text());
			prepSum += parseInt($(this).attr("data-price"));
			totalSum += parseInt($(this).attr("data-price"));
		}
		else {
			preps.splice(o_id, 1);
			$(this).text("Добавить");
			$(this).css('background', '');
			//sum = parseInt($("#total-opts-sum").text()) - parseInt($(this).attr("data-price"));
			prepSum -= parseInt($(this).attr("data-price"));
			totalSum -= parseInt($(this).attr("data-price"));		
		}
		
		updateSums();
    });
	
	$('.colors div').click(function(e) {
		$('.colors div').each(function() {
			$(this).removeClass("clr-selected");
			$(this).text('');
		});
		$('.new-color').removeClass("clr-selected");
				
		$(this).addClass("clr-selected");
		$(this).text('✓');
		clr = rgb2hex($(this).css("backgroundColor"));
		clr_name = $(this).attr("title");
	});
	
	$('#make-order').click(function(e) {
		$.cookie('opts', opts.join(','), {path: '/'});
		$.cookie('preps', preps.join(','), {path: '/'});
		$.cookie('color', clr, {path: '/'});
		$.cookie('color_name', clr_name, {path: '/'});
		$.cookie('spec', $("input[name=spec]").val(), {path: '/'});
		$.cookie('engine', $("input:radio[name=engine]:checked").val(), {path: '/'});
		$.cookie('model', $("input[name=model]").val(), {path: '/'});
	});
	
	function updateSums() {
		$("#total-sum").text(formatCurrency(totalSum));
		$("#total-opts-sum").text(formatCurrency(optSum));
		$("#total-opts").text(opts.length.toString());
		$("#total-preps-sum").text(formatCurrency(prepSum));
		$("#total-preps").text(preps.length.toString());
	}
});