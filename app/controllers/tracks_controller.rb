class TracksController < ApplicationController
  # GET /tracks
  # GET /tracks.xml
  def index
    @tracks = Track.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tracks }
    end
  end

  # GET /tracks/1
  # GET /tracks/1.xml
  def show
    @track = Track.find(params[:id])

    require 'net/http'
    require 'json'
    url = URI.parse("http://ws.audioscrobbler.com/2.0/?method=track.getinfo&api_key=b25b959554ed76058ac220b7b2e0a026&format=json&artist=#{@track.artist.gsub("\ ", "+")}&track=#{@track.name.gsub("\ ", "+")}")
    resp = Net::HTTP.get_response(url)
    data = resp.body
    result = JSON.parse(data)

    unless result["track"]["album"].nil?
      @artist_image_url = result["track"]["album"]["image"][1]["#text"]
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @track }
    end
  end

  # GET /tracks/new
  # GET /tracks/new.xml
  def new
    
    @track = Track.new
    unless params[:playlist_id].blank?
      @playlist = Playlist.find(params[:playlist_id])
      unless @playlist.nil?
        @track.playlist_id = @playlist.id
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @track }
    end
  end

  # GET /tracks/1/edit
  def edit
    @track = Track.find(params[:id])
  end

  # POST /tracks
  # POST /tracks.xml
  def create
    
    # Make sure we don't create a new track if we already have it:
    @track = Track.find_or_initialize_by_href(params[:track][:href])
    
    unless params[:track][:href].blank?
      # Find the song with Spotifys metadata API 
      # (using a wrapper from http://github.com/philnash/meta-spotify)
      found_track = MetaSpotify::Track.lookup(params[:track][:href])
      
      # Only save data if MetaSpotify could find the song
      unless found_track.blank?
        @track.name = found_track.name
        @track.artist = found_track.artists.first.name
        @track.album = found_track.album.name
        @track.href = found_track.uri
        @track.length = found_track.length
        @track.popularity = found_track.popularity
        @track.votes_count = 0
        
        # Save the playlist_id from the form:
        unless params[:track][:playlist_id].blank?
          @track.playlist_id = params[:track][:playlist_id]
        end
      end
      
    end
    
    #@track = Track.new(params[:track])

    respond_to do |format|
      if @track.save
        format.html { 
          if @track.playlist_id.blank?
            redirect_to(@track, :notice => 'The track was added.') 
          else
            redirect_to({:controller => :playlists, :action => :show, :id => @track.playlist.id, :highlight_track_id => @track.id}, :notice => 'The track was added.')
          end
        }
        format.xml  { render :xml => @track, :status => :created, :location => @track }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tracks/1
  # PUT /tracks/1.xml
  def update
    @track = Track.find(params[:id])

    respond_to do |format|
      if @track.update_attributes(params[:track])
        format.html { redirect_to(@track, :notice => 'Track was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.xml
  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to(tracks_url) }
      format.xml  { head :ok }
    end
  end
end
