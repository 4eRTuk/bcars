$(document).ready ->
	updatePreSums = ->
		$("#spec-sum").text formatCurrency(specSum)
		return
  
	specSum = 0
	specSum = parseInt($("#spec-sum").text())
	return