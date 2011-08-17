# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def index
    @query = params[:q]
    @tracks = []
    @result_type = nil
    @playlist_item = PlaylistItem.new
    if params[:playlist_id]
      @playlist = Playlist.find_by_id(params[:playlist_id])
      if @playlist
        @playlist_item.playlist_id = @playlist.id
      end
    end
    begin
      if MetaSpotify::Artist::URI_REGEX.match(@query)
        @search = MetaSpotify::Artist.lookup(@query, :extras => 'albumdetail')
        @tracks = tracks_for_artist(@search)
      elsif MetaSpotify::Album::URI_REGEX.match(@query)
        @search = MetaSpotify::Album.lookup(@query, :extras => 'trackdetail')
        @tracks = @search[:tracks]
      elsif MetaSpotify::Track::URI_REGEX.match(@query)
        @search = MetaSpotify::Track.lookup(@query)
        @tracks << @search
      else
        @search = MetaSpotify::Track.search(@query)
        @tracks = @search[:tracks]
      end
    rescue MetaSpotify::MetaSpotifyError => e
      errno = e.data[0,3].to_i
      if errno
        case errno
        #when 400
          # 400 - The request was not understood
        when 403
          # 403 - You are being rate limited, please wait 10 seconds before requesting again
          @error = 'Vi är just nu överbelastade med sökningar, vänta 10 sekunder och försök igen'
        when 404
          # 404 - That resource could not be found.
          @error = 'Vi hittade ingen sådan låt hos Spotify'
        #when 406
          # 406 - The requested format isn't available
        #when 500
          # 500 - The server encountered an unexpected problem
        #when 503
          # 503 - The API is temporarily unavailable
        else
          @error = 'Okänt fel vid sökningen'
        end
      else
        @error = 'Okänt fel vid sökningen'
      end
    end
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @tracks }
      format.json { render :json => @tracks }
    end
  end
  
  private
    def tracks_for_album(album)
      MetaSpotify::Album.lookup(album.uri, :extras => 'trackdetail').tracks
    end
    
    def tracks_for_artist(artist)
      tracks = []
      #logger.info artist
      unless artist.albums.blank?
        #logger.info artist.albums
        artist.albums.each do |album|
          #logger.info album
          #logger.info tracks_for_album(album)
          tracks_for_album(album).each do |track|
            logger.info track
            tracks << track
          end
        end
      end
      tracks
    end
end
