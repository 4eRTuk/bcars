// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require jquery.facebox
//= require bootstrap-colorpicker
//= require facebox

	function formatCurrency(val) {
		var tail = [];
		tail.push(' RUB');
		tmp = val;
		a = 10;
		c = 0;
		
		if (tmp <= 0)
			tail.push('0');			
		
		while (tmp > 0)
		{
			c++;
			tmp = parseInt(tmp / 10);
		}
		
		tmp = val;
		for (var i = 1; i <= c; i++)
		{
			tail.push((tmp % 10).toString());
			tmp = parseInt(tmp / 10);
			
			if (i % 3 == 0)
				tail.push(' ');
		}
		
		res = '';
		while(tail.length > 0)
			res += tail.pop();
		
		return res;
	}
	
	
	function rgb2hex(rgb) {
		rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);

		function hex(x) {
			return ("0" + parseInt(x).toString(16)).slice(-2);
		}

		return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
	}
	
	/*$(function() {
		$(".list th a, .list .pagination a").live("click", function() {
			$.getScript(this.href);
			return false;
		});
		
		$("#models_search input").keyup(function() {
			$.get($("#models_search").attr("action"), $("#models_search").serialize(), null, "script");
			return false;
		});
	});*/