/*****************************Initialisation of frame sizes  **********************************/
var iframeHeight = 500;
var dialogWidth = $(window).width() * 0.9;
var dialogHeight = 450;
var editorHeight = 180;

$(window).resize(function(){
dialogWidth = $(window).width() * 0.9;
$("#cdm_editor").dialog("option","width", dialogWidth);
        });

var frame = parent.document.getElementById(window.name);
$(frame).css('height', iframeHeight);

/*****************************Initialisation of frame editor  **********************************/
/*
var myToolbar = [
		{
			name : 'document',
			items : [ 'Source', '-','Print' ]
		},
 { items : [ 'Bold','Italic','Underline','-','FontSize' ] },
		{
			name : 'paragraph',
			items : [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent',
					'-', 'Blockquote', '-', 'JustifyLeft',
					'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-',
					'BidiLtr', 'BidiRtl' ]
		}];

var config = {
	height: editorHeight,
	position : [ 'center', 'center' ],
	toolbar_mySimpleToolbar : myToolbar,
	toolbar : 'mySimpleToolbar',
	fontSize_defaultLabel : '12'
};
*/
//$('#editor_area').ckeditor(config);	

/*****************************Initialisation of Catalog Description datatable  **********************************/
$(document).ready(function() {
	oTable = $('#correspondence_table').dataTable({
		"bJQueryUI" : true,
		"bProcessing" : true,
		"sAjaxSource" : 'listCorrespondences.json',
		"sPaginationType" : "full_numbers",
		"aoColumns" : [
			null,
			null,
			null,
			{
				"mDataProp": null,
				"sClass": "control",
				"sDefaultContent": 'X'//'<img src=>'
			}
		]
	});
});

$('#correspondence_table td.delete').live('click', function () {
	var courseid = oTable.fnGetData(this.parentNode, 0);
	if (window.confirm("you sure? " + courseid)) {
		deleteCorrespondence(courseid);
	}
} );

/*****************************Initialisation of Editor dialog box  **********************************/
/*
$("#cdm_editor").dialog({
	autoOpen : false,
	modal : true,
	resizable : true,
	draggable : true,
	width : dialogWidth,
	height : dialogHeight,
	autoResize:true
});
$("#save_button").button();
$("#cancel_button").button();
$("#accordeonWrap").accordion({
	autoHeight : false
});
*/

/***************************** Binding 'click' event on a table row (open dialog_box) **********************************/
/*
$('#catalog_description_table').on("click", "tbody tr", function(event) {

	var id_row = oTable.fnGetData(this)[0];
	$('#course_id').val(id_row);
	openDialogCatalogDescriptionCurrentRow(id_row);
});
*/

/***************************** Binding 'click' event on table buttons (save and cancel) **********************************/
/*
$("#save_button").on("click", function(event) {
	save(escape($('#editor_area').val()), $('#course_id').val(), $('#last_modified_date').val());
	$("#cdm_editor").dialog('close');
});

$("#cancel_button").on("click", function(event) {
	$("#cdm_editor").dialog('close');
});
*/