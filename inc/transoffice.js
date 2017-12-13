/*!
 * Custom & jquery library for transoffice
 *
 */	
	
// snippet below allows table row to become clickable and create a link from the whole row
	jQuery(document).ready(function($) {
	$(".clickable-row").click(function() {
		window.location = $(this).data("url");
		});
	});
	
// on select of new client in clientselect box, page is reloaded with client id set
	jQuery(document).ready(function($) {
	$('#clientselect').change(function() {
		var qmark=window.location.href.indexOf("?");
		if (qmark != -1) {
			window.location.href = window.location.href.substring(0, qmark) +"?clientid="+(this.value);
		} else {
			window.location.href = window.location.href+"?clientid="+(this.value);
		}
		});
	});

// alert box when new button selected without filter (when needed)
	jQuery(document).ready(function($) {
	$('#entitylistnewbutton').click(function(e) {
		if (window.location.href.indexOf("?clientid") == -1) {
			e.preventDefault();
			alert("Please select a Client before creating a new record");
		}
		});
	});	