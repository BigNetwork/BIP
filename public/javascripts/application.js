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

        $("form#spotify_search").submit(function(e){
            var query = $("form#spotify_search input#query").val();
            searchSpotify(query);
            e.preventDefault();
        });

        $("table#spotify_search_results").hide();
        $("form#new_track").hide();
        $("#spotify_search_status").hide();

});

function searchSpotify(query){
	// Tell the user what is happening:
	$("form#spotify_search input#query").val(query);
	//$("#spotify_metadata_result .status").text("Söker...");
	
	$.getJSON("http://ws.spotify.com/search/1/track.json?q=" + query, function(data){

		if(data.info.num_results == 0)
		{
			//$("#spotify_metadata_result .status").html("<strong>Hoppsan...</strong><br><br> Din sökning matchade inget i Spotify-katalogen. <br><br>Kontrollera att alla ord har rätt stavning. Du kan också pröva annorlunda eller enklare sökningar.");
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
	$("#spotify_search_results tbody").empty();
}

function renderTracks(tracks){
	// Remove old search results:
	clearSearchResults();
	
	console.log(tracks);

        var playlist_id = $("input#track_playlist_id").val();

	// Add new:
	$.each(tracks, function(index){
		trackHtml  = '';
		trackHtml += '<tr class="track">';
		trackHtml += '  <td class="action"><a href="/tracks?[track][href]=' + this.href + '&[track][playlist_id]=' + playlist_id + '" class="icon add" title="Lägg till" data-method="post" data-remote="true" onclick="addTrack(\'' + this.href + '\')">+</a></td>';
		trackHtml += '  <td class="artist"><a href="#" onclick="searchSpotify(\'' + this.artists[0].name + '\')">' + this.artists[0].name + '</a></td>';
		trackHtml += '  <td class="name"><a href="#" onclick="searchSpotify(\'' + this.name + '\')">' + this.name + '</a></td>';
		//trackHtml += '  <td class="album"><a href="#" onclick="searchSpotify(\'' + this.album.name + '\')">' + this.album.name + '</a></td>';
		//trackHtml += '  <td class="action"><a href="' + this.href + '" class="icon open" title="Visa i Spotify">Visa i Spotify</a></td>';
		//<td class="action"><a href="spotify:track:09ISyLOPeuno7kKlzdbZuq" class="icon open" title="Visa i Spotify"></a></td>
		trackHtml += '</tr>';
		$("#spotify_search_results tbody").append(trackHtml);
	});
	
        $("#spotify_search_results").show();

	$("#spotify_metadata_results .status").empty();	// Show no error message.
}

function addTrack(href){
    $("table#spotify_search_results").hide();
    $("#spotify_search_status").show();
    $("#spotify_search_status").text("Låten tillagd.");
    //window.location.replace("http://bip.bignetwork.se/playlists/" + playlist_id + "?highlight_track_id=");
}
