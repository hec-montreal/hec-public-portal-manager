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

/*****************************Initialisation of Catalog Description datatable  **********************************/
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
	
	this.reset();
	
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

/***************************** Binding 'click' event on a table row (open dialog_box) **********************************/
/*
$('#catalog_description_table').on("click", "tbody tr", function(event) {

	var id_row = oTable.fnGetData(this)[0];
	$('#course_id').val(id_row);
	openDialogCatalogDescriptionCurrentRow(id_row);
});
*/