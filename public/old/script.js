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
	
	// Hide adding part of site:
	$("section#adding").hide();
	
	$("form#spotify_metadata_search").submit(function(){
		query = $("input#query").val();
		
		searchSpotify(query);
		
		return false;	// Don't submit the form.
	});
	
	/*
	$("#spotify_metadata_result .tracks").dataTable({
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
	*/
	
});

function searchSpotify(query){
	// Use the correct tab:
	showAdding();
	
	// Tell the user what is happening:
	$("form#spotify_metadata_search input#query").val(query);
	$("#spotify_metadata_result .status").text("Söker...");
	
	$.getJSON("http://ws.spotify.com/search/1/track.json?q=" + query, function(data){

		if(data.info.num_results == 0)
		{
			$("#spotify_metadata_result .status").html("<strong>Hoppsan...</strong><br><br> Din sökning matchade inget i Spotify-katalogen. <br><br>Kontrollera att alla ord har rätt stavning. Du kan också pröva annorlunda eller enklare sökningar.");
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
	
	console.log(tracks);
	
	// Add new:
	$.each(tracks, function(index){
		trackHtml  = '';
		trackHtml += '<tr class="track">';
		trackHtml += '<td class="artist"><a href="#" onclick="searchSpotify(\'' + this.artists[0].name + '\')">' + this.artists[0].name + '</a></td>';
		trackHtml += '<td class="name"><a href="#" onclick="searchSpotify(\'' + this.name + '\')">' + this.name + '</a></td>';
		trackHtml += '<td class="album"><a href="#" onclick="searchSpotify(\'' + this.album.name + '\')">' + this.album.name + '</a></td>';
		trackHtml += '<td class="action"><a href="#" class="icon add" title="Lägg till" onclick="addTrack(\'' + this.href + '\')">+</a></td>';
		trackHtml += '<td class="action"><a href="' + this.href + '" class="icon open" title="Visa i Spotify">Visa i Spotify</a></td>';
		//<td class="action"><a href="spotify:track:09ISyLOPeuno7kKlzdbZuq" class="icon open" title="Visa i Spotify"></a></td>
		trackHtml += '</tr>';
		$("#spotify_metadata_result .tracks tbody").append(trackHtml);
	});
	
	$("#spotify_metadata_result .status").empty();	// Show no error message.
}

function addTrack(spotifyURI){
	alert("Den här funktionen är inte klar ännu, men du klickade för att lägga till låten: \n\n" + spotifyURI);
	console.log("Adding: " + spotifyURI);
}

function voteForTrack(spotifyURI){
	alert("Den här funktionen är inte klar ännu, men du klickade för att rösta på låten: \n\n" + spotifyURI);
	console.log("Voting: " + spotifyURI);
}

/*
function moreAboutTrack(spotifyURI){
	console.log("Requesting more info about: " + spotifyURI);
}
*/

function showVoting(){
	$("section#adding").hide();
	$("section#voting").show();
	$("section#page nav a").removeClass("current");
	$("section#page nav a.voting").addClass("current");
}

function showAdding(){
	$("section#voting").hide();
	$("section#adding").show();
	$("section#page nav a").removeClass("current");
	$("section#page nav a.adding").addClass("current");
	$("form#spotify_metadata_search input#query").focus();
}