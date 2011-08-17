class PlaylistsController < ApplicationController
  # GET /playlists
  # GET /playlists.xml
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playlists }
      format.json  { render :json => @playlists }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.xml
  def show
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.xml
  def new
    @playlist = Playlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /playlists
  # POST /playlists.xml
  def create
    @playlist = Playlist.new(params[:playlist])

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully created.') }
        format.xml  { render :xml => @playlist, :status => :created, :location => @playlist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.xml
  def update
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.xml
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to(playlists_url) }
      format.xml  { head :ok }
    end
  end
  
  def play
    @playlist = Playlist.find(params[:id])
    
    # TODO: Replace TRACK with PLAYLIST_ITEM
    # TODO: TEST MOAR!
    
    if @playlist && @playlist.playlist_items
      
      # Mark the playlist as playing:
      @playlist.is_playing = true
      @playlist.save!
      
      # Find the first track
      @playlist_item = @playlist.playlist_items.first
      
      respond_to do |format|
        format.html { redirect_to("/playlists/#{@playlist.id}/tracks/#{@playlist_item.id}/play") }
        format.xml  { redirect_to("/playlists/#{@playlist.id}/tracks/#{@playlist_item.id}/play.xml") }
      end
      # Redirect to track
      
    end
  end
  
  def pause
    # 
    @playlist = Playlist.find(params[:id])
    if @playlist
      @playlist.is_playing = false
      @playlist.save!
    end
    
    redirect_to :back
    
    # TODO: Connect to the playback server and pause it as well!
  end

  def next
    play
  end
  
end
