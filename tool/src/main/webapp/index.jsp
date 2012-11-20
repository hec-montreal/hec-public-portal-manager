<jsp:directive.include file="/templates/includes.jsp" />
<jsp:directive.include file="/templates/header.jsp" />
<div id="ajaxReturn">
	<div id="ajaxMessage" class="return_message"></div>
</div>
<h3>
	<c:out value="${msgs.message_header}" />
</h3>

<br />
<!--
<div id="cdm_editor">
	<div id="accordeonWrap">
		<h3>
			<a href="#"><c:out value="${msgs.label_description}" /></a>
		</h3>
		<div>
			<textarea id="editor_area"></textarea>
		</div>
		<h3>
			<a href="#"><c:out value="${msgs.label_course_info}" /></a>
		</h3>
		<div>
			<table class="course_info">
				<tr class="row_space" />
				<tr>
					<td><span class="td_title"><c:out
								value="${msgs.label_acad_department}" /> </span></td>
					<td id="selected_course_acad_department" />
				</tr>
				<tr class="row_space" />
				<tr>
					<td><span class="td_title"><c:out
								value="${msgs.label_acad_career}" /> </span></td>
					<td id="selected_course_acad_career" />
				</tr>
				<tr class="row_space" />
				<tr>
					<td><span class="td_title"><c:out
								value="${msgs.label_credits}" /> </span></td>
					<td id="selected_course_credits" />
				</tr>
				<tr class="row_space" />
				<tr>
					<td><span class="td_title"><c:out
								value="${msgs.label_requirements}" /> </span></td>
					<td id="selected_course_requirements" />
				</tr>
				<tr class="row_space" />
				<tr>
					<td><span class="td_title"><c:out
								value="${msgs.label_language}" /> </span></td>
					<td id="selected_course_language" />
				</tr>
			</table>
		</div>
	</div>
	<div id="div_buttons" style="clear: both;">
		<br /> <span id="save_button" class="button"><c:out
				value="${msgs.button_save}" /></span> <span id="cancel_button"
			class="button"><c:out value="${msgs.button_cancel}" /></span>
	</div>
</div>
-->

<table id="correspondence_table">
	<thead>
		<tr>
			<th><c:out value="${msgs.label_course_id}" /></th>
			<th><c:out value="${msgs.label_course_section}" /></th>			
			<th><c:out value="${msgs.label_date_modification}" /></th>
			<th></th>
		</tr>
	</thead>
	<tbody></tbody>
</table>

<!--
<input type="hidden" id="course_id" />
<input type="hidden" id="last_modified_date" />
-->
<input type="hidden" id="genericError"
	value="<c:out value="${msgs.message_generic_error}" />" />


<jsp:directive.include file="/templates/footer.jsp" />