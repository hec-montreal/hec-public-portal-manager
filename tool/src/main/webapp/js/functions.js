/* Refresh the datatable after saving a catalog description */
// $.fn.dataTableExt.oApi.fnReloadAjax = function(oSettings, sNewSource,
		// fnCallback, bStandingRedraw) {
	// if (typeof sNewSource != 'undefined' && sNewSource != null) {
		// oSettings.sAjaxSource = sNewSource;
	// }
	// this.oApi._fnProcessingDisplay(oSettings, true);
	// var that = this;
	// var iStart = oSettings._iDisplayStart;
	// var aData = [];

	// this.oApi._fnServerParams(oSettings, aData);

	// oSettings.fnServerData(oSettings.sAjaxSource, aData, function(json) {
		// /* Clear the old information from the table */
		// that.oApi._fnClearTable(oSettings);

		// /* Got the data - add it to the table */
		// var aData = (oSettings.sAjaxDataProp !== "") ? that.oApi
				// ._fnGetObjectDataFn(oSettings.sAjaxDataProp)(json) : json;

		// for ( var i = 0; i < aData.length; i++) {
			// that.oApi._fnAddData(oSettings, aData[i]);
		// }

		// oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
		// that.fnDraw();

		// if (typeof bStandingRedraw != 'undefined' && bStandingRedraw === true) {
			// oSettings._iDisplayStart = iStart;
			// that.fnDraw(false);
		// }

		// that.oApi._fnProcessingDisplay(oSettings, false);

		// /* Callback user function - for event handlers etc */
		// if (typeof fnCallback == 'function' && fnCallback != null) {
			// fnCallback(oSettings);
		// }
	// }, oSettings);
// };

/* Save a catalog description */
/*
function save(description, id, last_modified_date) {

	$.ajax({
		url : 'save.json',
		type : "POST",
		data : 'description=' + description + '&id=' + id + '&last_modified_date=' + last_modified_date,
		datatype : 'json',
		success : function(data) {
			$('#ajaxMessage').html(data.message);
			$('#ajaxReturn').show();

			if (data.status == 'success') {
				$('#ajaxReturn').addClass("info");
			} else {
				$('#ajaxReturn').addClass("error");
			}
		},

		error : function(xhr, ajaxOptions, thrownError) {
			var genericError = $('#genericError').val();
			$('#ajaxMessage').html(genericError);
			$('#ajaxReturn').addClass("error");
		}
	});
}
*/

/* Get a catalog description and initialize the editor dialog box  */
/*
function openDialogCatalogDescriptionCurrentRow(id) {
	$.ajax({
		url : 'get.json',
		data : 'id=' + id,
		datatype : 'json',
		success : function(cd) {

			if (cd.status == 'success') {
				var dialog_title = cd.courseid + ' - ' + cd.title;
				var description = cd.description;
				var last_modified_date = cd.last_modified_date;
				$("#selected_course_acad_department").html(cd.acad_department);
				$("#selected_course_acad_career").html(cd.acad_career);
				$("#selected_course_credits").html(cd.credits);
				$("#selected_course_requirements").html(cd.requirements);
				$("#selected_course_language").html(cd.language);
				$("#cdm_editor").dialog('option', 'title', dialog_title);
				$('#editor_area').val(description);
				$('#last_modified_date').val(last_modified_date);
				$("#cdm_editor").dialog('open');
			} else {
				$('#ajaxMessage').html(cd.message);
				$('#ajaxReturn').addClass("error");
			}
		},

		error : function(xhr, ajaxOptions, thrownError) {
			var genericError = $('#genericError').val();
			$('#ajaxMessage').html(genericError);
			$('#ajaxReturn').addClass("error");
		}
	});
}
*/

/* Delete a course correspondence */
function deleteCorrespondence(course_id) {
	$.ajax({
		url : 'deleteCorrespondence.json',
		type : "POST",
		data : 'courseId=' + course_id,
		datatype : 'json',
		success : function(data) {
			$('#ajaxMessage').html(data.message);
			$('#ajaxReturn').show();
			$('#ajaxReturn').fade('slow', function(){});

			if (data.status == 'success') {
				$('#ajaxReturn').addClass("info");
			} else {
				$('#ajaxReturn').addClass("error");
			}
		},

		error : function(xhr, ajaxOptions, thrownError) {
			var serverError = $('#message_server_error').val();
			$('#ajaxMessage').html(serverError);
			$('#ajaxReturn').addClass("error");
		}
	});
}

