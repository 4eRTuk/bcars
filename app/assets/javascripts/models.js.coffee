# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	clr = "#ffffff"
	clr_name = "White"
	totalSum = 0
	optSum = 0
	prepSum = 0
	opts = []
	preps = []

	updateSums = ->
		$("#total-sum").text formatCurrency(totalSum)
		$("#total-opts-sum").text formatCurrency(optSum)
		$("#total-opts").text opts.length.toString()
		$("#total-preps-sum").text formatCurrency(prepSum)
		$("#total-preps").text preps.length.toString()
		return
	
	totalSum = parseInt($("#total-sum").text(), 10)
	$("#spec-sum").text formatCurrency(totalSum)
	updateSums()
	$("#engines li input").first().prop "checked", true
	$("#engines li").first().addClass "selected"
	$("#engine-sum").text $("#engines li label").first().text()
	
	$("#engines li").click (e) ->
		$("#engines li").each ->
			$(this).removeClass "selected"
			return
		
		$(this).addClass "selected"
		$(this).children("input").prop "checked", true
		$("#engine-sum").text $(this).children("label").text()
		return

	$(".colors div").click (e) ->
		$(".colors div").each ->
			$(this).removeClass "clr-selected"
			$(this).text ""
			return

		$(".new-color").removeClass "clr-selected"
		$(this).addClass "clr-selected"
		$(this).text "X"
		clr = rgb2hex($(this).css("backgroundColor"))
		clr_name = $(this).attr("title")
		return
		
	$("#tab_c2 .add").click (e) ->
		o_id = $.inArray($(this).attr("data-opt-id"), opts)
		
		if o_id is -1
			opts.push $(this).attr("data-opt-id")
			$(this).text "Added"
			$(this).css "background", "#BB0000"      
			optSum += parseInt($(this).attr("data-price"))
			totalSum += parseInt($(this).attr("data-price"))
		else
			opts.splice o_id, 1
			$(this).text "Add"
			$(this).css "background", ""
			optSum -= parseInt($(this).attr("data-price"))
			totalSum -= parseInt($(this).attr("data-price"))
			
		updateSums()
		return
	
	$("#tab_c3 .add").click (e) ->
		o_id = $.inArray($(this).attr("data-prep-id"), preps)
		
		if o_id is -1
			preps.push $(this).attr("data-prep-id")
			$(this).text "Added"
			$(this).css "background", "#BB0000"
			prepSum += parseInt($(this).attr("data-price"))
			totalSum += parseInt($(this).attr("data-price"))
		else
			preps.splice o_id, 1
			$(this).text "Add"
			$(this).css "background", ""
			prepSum -= parseInt($(this).attr("data-price"))
			totalSum -= parseInt($(this).attr("data-price"))
			
		updateSums()
		return
	
	$("#make-order").click (e) ->
		$.cookie "opts", opts.join(","),
		  path: "/"

		$.cookie "preps", preps.join(","),
		  path: "/"

		$.cookie "color", clr,
		  path: "/"

		$.cookie "color_name", clr_name,
		  path: "/"

		$.cookie "spec", $("input[name=spec]").val(),
		  path: "/"

		$.cookie "engine", $("input:radio[name=engine]:checked").val(),
		  path: "/"

		$.cookie "model", $("input[name=model]").val(),
		  path: "/"

		return
	
	return