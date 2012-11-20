<jsp:directive.include file="/templates/includes.jsp" />
<jsp:directive.include file="/templates/header.jsp" />
<div id="ajaxReturn">
	<div id="ajaxMessage" class="return_message"></div>
</div>
<h3>
	<c:out value="${msgs.message_header}" />
</h3>

<br />
<table id="correspondence_table">
	<thead>
		<tr>
			<th><c:out value="${msgs.label_course_id}" /></th>
			<th><c:out value="${msgs.label_course_section}" /></th>			
			<th><c:out value="${msgs.label_date_modification}" /></th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody></tbody>
</table>

<!--
<input type="hidden" id="course_id" />
<input type="hidden" id="last_modified_date" />
-->
<input type="hidden" id="message_server_error" value="<c:out value="${msgs.message_generic_error}" />" />
<input type="hidden" id="message_confirm_delete" value="<c:out value="${msgs.message_confirm_delete}" />" />


<jsp:directive.include file="/templates/footer.jsp" />