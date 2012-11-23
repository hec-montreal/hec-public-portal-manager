<%@ page contentType="text/html" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link media="all" href="/library/skin/tool_base.css" rel="stylesheet" type="text/css" />
		<link media="all" href="/library/skin/default/tool.css" rel="stylesheet" type="text/css" />
		<link media="all" href="css/hec-public-portal-manager.css" rel="stylesheet" type="text/css" />

		<script src="/library/js/headscripts.js" language="JavaScript" type="text/javascript"></script>
		<script type="text/javascript" src="js/datatables-1.9.4/jquery.js"></script>
		<script type="text/javascript" src="js/datatables-1.9.4/jquery.dataTables.min.js"></script>
	</head>
	<body>
		<div class="portletBody">
			<div id="ajaxReturn">
				<div id="ajaxMessage" class="return_message"></div>
			</div>

			<br/>
			<table id="correspondence_table">
				<thead>
					<tr>
						<th>No. de répertoire</th>
						<th>Section du cours</th>			
						<th>Date de modification</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<br/>

			<form id="save_form">
				<fieldset>
					<div><label for="courseId">No. de répertoire:</label><input type="text" name="courseId"/></div>
					<div>
					<label for="courseSection">Section du cours:</label><input type="text" name="courseSection"/>
					<input type="checkbox" name="no_section"/><label for="no_section">Aucun plan de cours sélectionné</label>
					</div>
				</fieldset>
				<button type="submit">Sauvegarder</button>
			</form>

		</div>
		
		<script  type="text/javascript" src="js/functions.js"></script>
		<script type="text/javascript" src="js/init.js"></script>
	</body>
</html>
