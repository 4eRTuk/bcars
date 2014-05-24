# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	updatePreSums = ->
		$("#spec-sum").text formatCurrency(specSum)
		return
  
	specSum = 0
	specSum = parseInt($("#spec-sum").text())
	return
