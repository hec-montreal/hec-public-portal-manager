/*****************************Initialisation of frame sizes  **********************************/
var iframeHeight = 500;
var dialogWidth = $(window).width() * 0.9;
var dialogHeight = 450;
var editorHeight = 180;

$(window).resize(function(){
	dialogWidth = $(window).width() * 0.9;
});

var frame = parent.document.getElementById(window.name);
$(frame).css('height', iframeHeight);

// Initialisation of Correspondence
$(document).ready(function() {
	oTable = $('#correspondence_table').dataTable({
		"bJQueryUI" : true,
		"bProcessing" : true,
		"sAjaxSource" : 'listCorrespondences.json',
		"sPaginationType" : "full_numbers",
		"aoColumns" : [
			null, // course id
			null, // course section
			null, // last modification date 
			{	
				// link button
				"mDataProp": null,
				"sClass": "link",
				"sDefaultContent": '',
				"bSortable": false
			},
			{	
				// delete button
				"mDataProp": null,
				"sClass": "delete",
				"sDefaultContent": '',
				"bSortable": false
			}
		]
	});
});

// bind click listener for table row to populate form
$('#correspondence_table tr').live("click", function() {
	$('#save_form input[name=courseId]').val(oTable.fnGetData(this, 0));
	$('#save_form input[name=courseSection]').val(oTable.fnGetData(this, 1));
});

$('#correspondence_table td.delete').live('click', function () {
	var courseid = oTable.fnGetData(this.parentNode, 0);
	if (window.confirm(confirm_delete_message + " " + courseid + "?")) {
		deleteCorrespondence(courseid);
	}
} );

$('#correspondence_table td.link').live('click', function () {
	var courseid = oTable.fnGetData(this.parentNode, 0);
	window.open('/portail/#cours='+courseid);
} );

$('#save_form').submit(function() {
	var section = ($('input[name="no_section"]').is(':checked')) ? "" : $('input[name="courseSection"]').val();
	saveCorrespondence($('input[name="courseId"]').val(), section);
	
	return false;
});

// bind disable to checkbox
$('#save_form input[name="no_section"]').bind('click', function () {
    var inputs = $(this).closest('li.form-item').find('div.element-container').children('input,select');

    if ($(this).is(':checked')) {
        $('#save_form input[name="courseSection"]').attr('disabled', true);
    } else {
        $('#save_form input[name="courseSection"]').removeAttr('disabled');
    }
});

