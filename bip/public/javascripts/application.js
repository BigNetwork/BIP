// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function(){
	$("table#all_tracks").dataTable({
		//"aaSorting": [[],[ 1, "desc" ], [ 0, "asc" ]],
		//"aoColumns": [ 
		//			{ "sType": "html" },
		//			{ "sType": "text" },
		//			{ "sType": "text" }
		//],
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"bInfo": false,
		"bAutoWidth": false,
		"oLanguage": {
			"sSearch": "Sök:"
		}
	});
	
	$("table#all_playlists").dataTable({
		//"aaSorting": [[],[ 1, "desc" ], [ 0, "asc" ]],
		//"aoColumns": [ 
		//			{ "sType": "html" },
		//			{ "sType": "text" },
		//			{ "sType": "text" }
		//],
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"bInfo": false,
		"bAutoWidth": false,
		"oLanguage": {
			"sSearch": "Sök:"
		}
	});
});