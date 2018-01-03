/*!
 * Custom & jquery library for transoffice
 *
 */	

// utilize data tables on tables.inc	
/*	$(document).ready( function () {
		$('#elementlist').DataTable( {
		  "stateSave": true,
		  "stateSaveParams": function (settings, data) {
			data.search.search = "";
		  }
		} );
	} );
 */
 $(document).ready(function() {
    $('#elementlist').DataTable( {
        initComplete: function () {
            this.api().columns().every( function () {
                var column = this;
                var select = $('<select><option value=""></option></select>')
                    .appendTo( $(column.header()) )
					.on( 'click', function(e) {
						e.preventDefault(); 
						e.stopPropagation();
						return false;
					})
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );
 
                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    }
				);
 
				column.data().unique().sort().each( function ( d, j ) {
					if(column.search() === '^'+d+'$'){
						select.append( '<option value="'+d+'" selected="selected">'+d+'</option>' )
					} else {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					}
				} );
            } );
        },
		"paging": true,
		"stateSave": true,
		"stateSaveParams": function (settings, data) {
			data.search.search = "";
		}
    } );
} );

// snippet below allows table row to become clickable and create a link from the whole row
$(document).ready(function() {
	var table = $('#elementlist').DataTable(); 
	$('#elementlist tbody').on('click', 'tr',  function() {
		window.location = $(this).data("url");
	} );
} );
	 
// snippet below allows table row to become clickable and create a link from the whole row (old - pre-datatables)
/*	jQuery(document).ready(function($) {
	$(".clickable-row").click(function() {
		window.location = $(this).data("url");
		});
	});
*/
	
// on select of new client in clientselect box, page is reloaded with client id set
	jQuery(document).ready(function($) {
	$('#clientselect').change(function() {
// making updates for job-endclient filtering
//		var qmark=window.location.href.indexOf("?");
		var clid=window.location.href.indexOf("clientid");
		var jobid=window.location.href.indexOf("jobid");
		if (jobid != -1) {
			var delim = "&";
		} else {
			var delim = "?";
		}
		if (clid != -1) {
			// clientid already exists, so replace rather than add to the url
			window.location.href = window.location.href.substring(0, clid-1) +delim+"clientid="+(this.value);
		} else {
			window.location.href = window.location.href+delim+"clientid="+(this.value);
		}
		});
	});

/*	
// on select of new client in clientselect box, page is reloaded with client id set
	jQuery(document).ready(function($) {
	$('#clientselect').change(function() {
// making updates for job-endclient filtering
//		var qmark=window.location.href.indexOf("?");
		var clid=window.location.href.indexOf("?clientid");
		if (clid != -1) {
			// ?clientid already exists, so replace rather than add to the url
			window.location.href = window.location.href.substring(0, clid) +"?clientid="+(this.value);
		} else {
			window.location.href = window.location.href+"?clientid="+(this.value);
		}
		});
	});	
*/	
	
// alert box when new button selected without filter (when needed)
	jQuery(document).ready(function($) {
	$('#entitylistnewbutton').click(function(e) {
		if (window.location.href.indexOf("?clientid") == -1) {
			e.preventDefault();
			alert("Please select a Client before creating a new record");
		}
		});
	});	
	
// alert box for changing user details
	jQuery(document).ready(function($) {
	$('.supportalert').click(function() {
		alert("Please contact support@kennettechservices.com to change your login information");
		});
	});	
