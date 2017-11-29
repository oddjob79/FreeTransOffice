	// snippet below allows table row to become clickable and create a link from the whole row
	
	jQuery(document).ready(function($) {
	$(".clickable-row").click(function() {
		window.location = $(this).data("url");
		});
	});
	