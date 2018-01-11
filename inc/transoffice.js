/*!
 * Custom & jquery library for transoffice
 *
 */	

// Tables - utilize data tables on tables.inc	
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

// Tables - snippet below allows table row to become clickable and create a link from the whole row (excludes invcheck class)
$(document).ready(function() {
	var table = $('#elementlist').DataTable(); 
	$('#elementlist tbody').on('click', 'tr',  function(e) {
		if ($(e.target).is('.invcheck')) return;
		window.location = $(this).data("url");
	} );
} );

// Generate Invoices - when Check all button pressed, all visible checkboxes checked and Check all button changed to Uncheck all
$(document).ready(function(){
   $('.selectallinv:button').click(function(){
          var checked = !$(this).data('checked');
          $('input:checkbox').prop('checked', checked);
          $(this).val(checked ? 'Uncheck all' : 'Check all' )
          $(this).data('checked', checked);
    });
})

// Generate Invoices - Confirm / Cancel invoice - sets invconfirmcancel value to either 'Confirm' or 'Cancel'
$(document).ready(function(){
   $('#invconfirm').click(function(){
       $('#invconfirmcancel').val('confirm');
//	   alert("TEST "+val('Confirm')+" "+$('#inconfirmcancel').val());
    });
   $('#invcancel').click(function(){
       $('#invconfirmcancel').val('cancel');
    });

})



// Client Submenus - on select of new client in clientselect box, page is reloaded with client id set
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
			// clientid already exists in url, so replace rather than add to the url
			window.location.href = window.location.href.substring(0, clid-1) +delim+"clientid="+(this.value);
		} else {
			window.location.href = window.location.href+delim+"clientid="+(this.value);
		}
		});
	});

// Job form
// Change status to Completed - sets Completed Date to today
	jQuery(document).ready(function() {
	$('#jobstatus').change(function() {
		if ($(this).val() == 5) {
			// create date variable of today's date
			var d = new Date();
			var month = d.getMonth()+1;
			var day = d.getDate();
			var output = d.getFullYear() + '-' + (month<10 ? '0' : '') + month + '-' + (day<10 ? '0' : '') + day;
			// apply date variable to completed date
			$('#jobcompleteddate').val(output);
		} else if ($(this).val() == 4) {
			$('#jobcompleteddate').val('');
		}
		});
	});	
	
// Settings menu
// in settings menu, selection of entity from drop down controls element selection and page reload
	jQuery(document).ready(function($) {
	$('.settingsselectors').change(function() {
		if (window.location.href.indexOf("package") != -1) {
			var settingid = "packageid";
		} else if (window.location.href.indexOf("jobtype") != -1) {
			var settingid = "jobtypeid";
		} else if (window.location.href.indexOf("profile") != -1) {
			alert("It's a Job Profile");
		} else if (window.location.href.indexOf("userdefined") != -1) {
			alert("It's a User Defined");
		} else if (window.location.href.indexOf("reportsetup") != -1) {
			alert("It's a Report");
		}
		
		var idpos=window.location.href.indexOf(settingid);
		if (idpos != -1) {
			// setting id already exists in url, so replace rather than add to the url
			window.location.href = window.location.href.substring(0, idpos)+settingid+"="+(this.value);
		} else {
			window.location.href = window.location.href+"?"+settingid+"="+(this.value);
		}
		
		});
	});

// Settings - Change Settings page to Edit mode onclick of Edit button
$(document).ready(function() {
    $("div.settingsedit").hide();
	var domainid = $("input[name$='settingsdomainid']").val();
//	alert("domainid = "+domainid);
    $("input[name$='editsettingsbtn']").click(function() {
		if (domainid == 0) {
			alert("System Default Option - unable to edit");
		} else {
			$("div.settingsview").hide();
			$("div.settingsedit").show();
			$('.settingfield').removeAttr('readonly');
		}
    });
});

// Settings - Change Settings page to Edit mode and empty form values onclick of New button
$(document).ready(function() {
	$("div.settingsedit").hide();	
    $("input[name$='newsettingsbtn']").click(function() {
        $('.form-control').removeAttr('value');
		$('textarea').val('');
		$("div.settingsview").hide();
        $("div.settingsedit").show();
		$('.settingfield').removeAttr('readonly');
    });	
});

	
// ALERTS	
	
// Client Submenus - alert box when new button selected without filter (when needed)
	jQuery(document).ready(function($) {
	$('#entitylistnewbutton').click(function(e) {
		if (window.location.href.indexOf("?clientid") == -1) {
			e.preventDefault();
			alert("Please select a Client before creating a new record");
		}
		});
	});	
	
// User Details - alert box for changing user details
	jQuery(document).ready(function($) {
	$('.supportalert').click(function() {
		alert("Please contact support@kennettechservices.com to change your login information");
		});
	});	
