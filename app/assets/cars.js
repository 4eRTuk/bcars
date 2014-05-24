$(document).ready(function() {
	var specSum = parseInt($("#spec-sum").text());
	updatePreSums();
		
	function updatePreSums() {
		$("#spec-sum").text(formatCurrency(specSum));
	}
});