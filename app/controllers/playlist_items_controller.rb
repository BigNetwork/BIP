class PlaylistItemsController < ApplicationController

  add_crumb 'Spellistor', :playlists_path

  # GET /playlist_items
  # GET /playlist_items.xml
  def index
    @playlist_items = PlaylistItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playlist_items }
    end
  end

  # GET /playlist_items/1
  # GET /playlist_items/1.xml
  def show
    @playlist_item = PlaylistItem.find(params[:id])

    unless params[:playlist_id].blank?
      @playlist = Playlist.find(params[:playlist_id])
      add_crumb @playlist.name, playlist_path(@playlist)
    end
    add_crumb @playlist_item.track.full_name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @playlist_item }
    end
  end

  # GET /playlist_items/new
  # GET /playlist_items/new.xml
  def new
    @playlist_item = PlaylistItem.new
    unless params[:playlist_id].blank?
      @playlist = Playlist.find(params[:playlist_id])
      unless @playlist.nil?
        @playlist_item.playlist_id = @playlist.id
      end
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @playlist_item }
    end
  end

  # GET /playlist_items/1/edit
  def edit
    @playlist_item = PlaylistItem.find(params[:id])
  end

  # POST /playlist_items
  # POST /playlist_items.xml
  def create
    @playlist_item = PlaylistItem.new(params[:playlist_item])
    
    # Make sure we don't create a new track if we already have it:
    @track = Track.find_or_create_by_spotify_id(params[:playlist_item][:spotify_id])
    
    unless @track.blank? || params[:playlist_item][:spotify_id].blank? 
      # Find the song with Spotifys metadata API 
      # (using a wrapper from http://github.com/philnash/meta-spotify)
      found_track = MetaSpotify::Track.lookup(params[:playlist_item][:spotify_id])
    
      # Only save data if MetaSpotify could find the song
      unless found_track.blank?
        @track.name = found_track.name
        @track.artist = found_track.artists.first.name
        @track.album = found_track.album.name
        @track.href = found_track.uri
        @track.length = found_track.length
        @track.popularity = found_track.popularity
        @track.votes_count = 0
        @track.cover_url = @track.fetch_cover_url
        @track.save!
    
        # Save the playlist_id from the form:
        unless params[:playlist_item][:playlist_id].blank?
          @playlist_item.playlist_id = params[:playlist_item][:playlist_id]
        end
        
        # Only save track_id if all previous worked
        @playlist_item.track_id = @track.id
      end # unless found_track.blank?
    end # unless @track.blank? || params[:spotify_id].blank? 
    
    respond_to do |format|
      if @playlist_item.save
        format.html { redirect_to(@playlist_item.playlist)}#, :notice => 'Playlist item was successfully created.') }
        format.xml  { render :xml => @playlist_item, :status => :created, :location => @playlist_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playlist_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /playlist_items/1
  # PUT /playlist_items/1.xml
  def update
    @playlist_item = PlaylistItem.find(params[:id])

    respond_to do |format|
      if @playlist_item.update_attributes(params[:playlist_item])
        format.html { redirect_to(@playlist_item, :notice => 'Playlist item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @playlist_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playlist_items/1
  # DELETE /playlist_items/1.xml
  def destroy
    @playlist_item = PlaylistItem.find(params[:id])
    @playlist_item.destroy

    respond_to do |format|
      format.html { redirect_to(playlist_items_url) }
      format.xml  { head :ok }
    end
  end
  
  def play
    @playlist_item = PlaylistItem.find(params[:id])
    if @playlist_item
      # Increment amount of plays
      #@playlist_item.??? = @track.??? + 1
      
      # Reset number of votes
      @playlist_item.previous_votes_count = @playlist_item.previous_votes_count.to_i + @playlist_item.votes_count.to_i
      @playlist_item.votes_count = 0
      
      # Respond with XML format:
      respond_to do |format|
        format.html { redirect_to(playlist_path(@playlist_item.playlist)) }
        format.xml  { redirect_to(playlist_item_path(@playlist_item, :format => :xml)) }
      end
    end
  end
end
