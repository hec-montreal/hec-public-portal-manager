var delete_success_message = "La suppression a &eacute;t&eacute; effectu&eacute;";
var delete_failure_message = "La suppression a &eacute;chou&eacute;";
var save_success_message = "La correspondence a bien &eacute;t&eacute; sauvegard&eacute;e";
var save_failure_message = "Une erreur s'est produite lors de la sauvegarde de la correspondence";
var server_error_message = "Une erreur interne s'est produite durant la derni&egrave;re op&eacute;ration";
var confirm_delete_message = "Voulez-vous vraiment supprimer la correspondence";
var fade_out_delay = 2000;

function resetForm() {
	$('#save_form').get(0).reset();
    $('#save_form input[name="courseSection"]').removeAttr('disabled');
}

/* Save a course correspondence */
function saveCorrespondence(course_id, course_section) {
	$.ajax({
		url : 'saveCorrespondence.json?'+'courseId=' + course_id.toUpperCase() + '&courseSection=' + course_section.toUpperCase(),
		type : "POST",
		datatype : 'json',
		success : function(data) {
			if (data.status == 'success') {
				$('#ajaxReturn').attr("class", "info");
				$('#ajaxMessage').html(save_success_message);
			} else {
				$('#ajaxReturn').attr("class", "error");
				$('#ajaxMessage').html(save_failure_message);
			}

			$('#ajaxReturn').show();
			$('#ajaxReturn').fadeOut(fade_out_delay);

			oTable.fnReloadAjax();
			resetForm();
		},

		error : function(xhr, ajaxOptions, thrownError) {
			$('#ajaxMessage').html(server_error_message);
			$('#ajaxReturn').addClass("error");
		}
	});
}

/* Delete a course correspondence */
function deleteCorrespondence(course_id) {
	$.ajax({
		url : 'deleteCorrespondence.json?'+'courseId=' + course_id,
		type : "POST",
	datatype : 'json',
		success : function(data) {
			if (data.status == 'success') {
				$('#ajaxReturn').attr("class", "info");
				$('#ajaxMessage').html(delete_success_message);
			} else {
				$('#ajaxReturn').attr("class", "error");
				$('#ajaxMessage').html(delete_failure_message);
			}

			$('#ajaxReturn').show();
			$('#ajaxReturn').fadeOut(fade_out_delay);

			oTable.fnReloadAjax();
			resetForm();
		},

		error : function(xhr, ajaxOptions, thrownError) {
			$('#ajaxMessage').html(server_error_message);
			$('#ajaxReturn').addClass("error");
		}
	});
}

/* Refresh the datatable from the server */
$.fn.dataTableExt.oApi.fnReloadAjax = function(oSettings, sNewSource, fnCallback, bStandingRedraw) {
	if (typeof sNewSource != 'undefined' && sNewSource != null) {
		oSettings.sAjaxSource = sNewSource;
	}
	this.oApi._fnProcessingDisplay(oSettings, true);
	var that = this;
	var iStart = oSettings._iDisplayStart;
	var aData = [];

	this.oApi._fnServerParams(oSettings, aData);

	oSettings.fnServerData(oSettings.sAjaxSource, aData, function(json) {
		/* Clear the old information from the table */
		that.oApi._fnClearTable(oSettings);

		/* Got the data - add it to the table */
		var aData = (oSettings.sAjaxDataProp !== "") ? that.oApi
				._fnGetObjectDataFn(oSettings.sAjaxDataProp)(json) : json;

		for ( var i = 0; i < aData.length; i++) {
			that.oApi._fnAddData(oSettings, aData[i]);
		}

		oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
		that.fnDraw();

		if (typeof bStandingRedraw != 'undefined' && bStandingRedraw === true) {
			oSettings._iDisplayStart = iStart;
			that.fnDraw(false);
		}

		that.oApi._fnProcessingDisplay(oSettings, false);

		/* Callback user function - for event handlers etc */
		if (typeof fnCallback == 'function' && fnCallback != null) {
			fnCallback(oSettings);
		}
	}, oSettings);
};
