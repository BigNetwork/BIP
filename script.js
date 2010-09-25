$(document).ready(function(){
	
	/*
	defaultQuery = "asdf";
	searchSpotify(defaultQuery);
	$("form#spotify_metadata_search input#query").val(defaultQuery);
	*/
	/*
	$("form#spotify_metadata_search input#query").change(function(){
		if($("form#spotify_metadata_search input#query").val() == ''){
			$("#spotify_metadata_result .tracks").empty();
		}
	});
	*/
	
	$("form#spotify_metadata_search").submit(function(){
		query = $("input#query").val();
		
		searchSpotify(query);
		
		return false;	// Don't submit the form.
	});
	
	$("#spotify_metadata_result .tracks").dataTable({
		/*"aaSorting": [[],[ 1, "desc" ], [ 0, "asc" ]],
		"aoColumns": [ 
					{ "sType": "html" },
					{ "sType": "text" },
					{ "sType": "text" }
		],*/
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

function searchSpotify(query){
	// Tell the user what is happening:
	$("form#spotify_metadata_search input#query").val(query);
	$("#spotify_metadata_result .status").text("Söker...");
	
	$.getJSON("http://ws.spotify.com/search/1/track.json?q=" + query, function(data){

		if(data.info.num_results == 0)
		{
			$("#spotify_metadata_result .status").text("Din sökning matchade inget i Spotify-katalogen. Kontrollera att alla ord har rätt stavning. Du kan också pröva annorlunda eller enklare sökningar.");
			clearSearchResults();
		}

		tracks = data.tracks || [];	// Make sure we always have a list to iterate over.
		
		if(tracks.length > 0)
		{
			renderTracks(tracks);
		}
	});
}

function clearSearchResults(){
	$("#spotify_metadata_result .tracks tbody").empty();
}

function renderTracks(tracks){
	// Remove old search results:
	clearSearchResults();
	
	// Add new:
	$.each(tracks, function(index){
		trackHtml  = '';
		trackHtml += '<tr class="track">';
		trackHtml += '<td class="action"><a href="#" class="icon add" title="Add this track to the playlist" onclick="addTrack(\'' + this.href + '\')">Add</a></td>';
		trackHtml += '<td class="artist"><a href="#" onclick="searchSpotify(\'' + this.artists[0].name + '\')">' + this.artists[0].name + '</a></td>';
		trackHtml += '<td class="name"><a href="#" onclick="searchSpotify(\'' + this.name + '\')">' + this.name + '</a></td>';
		//trackHtml += '<td class="action"><a href="#" class="icon more" title="More info about this track" onclick="moreAboutTrack('" + this.href + "')">More</a></td>';
		trackHtml += '</tr>';
		$("#spotify_metadata_result .tracks tbody").append(trackHtml);
	});
	
	$("#spotify_metadata_result .status").empty();	// Show no error message.
}

function addTrack(spotifyURI){
	console.log("Adding: " + spotifyURI);
}

function moreAboutTrack(spotifyURI){
	console.log("Requesting more info about: " + spotifyURI);
}