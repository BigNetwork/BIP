$(document).ready(function(){
	
	defaultQuery = "asdf";
	searchSpotify(defaultQuery);
	$("form#spotify_metadata_search input#query").text(defaultQuery);
	
	$("form#spotify_metadata_search input#query").change(function(){
		if($("form#spotify_metadata_search input#query").val() == ''){
			$("#spotify_metadata_result .tracks").empty();
		}
	});
	
	$("form#spotify_metadata_search").submit(function(){
		query = $("input#query").val();
		
		searchSpotify(query);
		
		return false;	// Don't submit the form.
	});
	
});

function searchSpotify(query){
	// Tell the user what is happening:
	$("#spotify_metadata_result .status").text("Söker...");
	
	$.getJSON("http://ws.spotify.com/search/1/track.json?q=" + query, function(data){

		if(data.info.num_results == 0)
		{
			$("#spotify_metadata_result .status").text("Din sökning matchade inget i Spotify-katalogen. Kontrollera att alla ord har rätt stavning. Du kan också pröva annorlunda eller enklare sökningar.");
		}

		tracks = data.tracks || [];	// Make sure we always have a list to iterate over.
		
		if(tracks.length > 0)
		{
			renderTracks(tracks);
		}
	});
}

function renderTracks(tracks){
	// Remove old search results:
	$("#spotify_metadata_result .tracks").empty();
	
	// Add new:
	$.each(tracks, function(index){
		trackHtml  = "";
		trackHtml += "<li class=\"track\">";
		trackHtml += "<a href=\"" + this.href + "\">";
		trackHtml += this.artists[0].name + " - " + this.name;
		trackHtml += "</a>";
		trackHtml += " <a href=\"#\" class=\"icon add\" onclick=\"addTrack('" + this.href + "')\">Add</a>";
		trackHtml += "</li>";
		$("#spotify_metadata_result .tracks").append(trackHtml);
	});
	
	$("#spotify_metadata_result .status").empty();	// Show no error message.
}

function addTrack(spotifyURI){
	console.log("Adding: " + spotifyURI);
}