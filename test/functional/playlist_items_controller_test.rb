require 'test_helper'

class PlaylistItemsControllerTest < ActionController::TestCase
  setup do
    @playlist_item = playlist_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playlist_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playlist_item" do
    assert_difference('PlaylistItem.count') do
      post :create, :playlist_item => @playlist_item.attributes
    end

    assert_redirected_to playlist_item_path(assigns(:playlist_item))
  end

  test "should show playlist_item" do
    get :show, :id => @playlist_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @playlist_item.to_param
    assert_response :success
  end

  test "should update playlist_item" do
    put :update, :id => @playlist_item.to_param, :playlist_item => @playlist_item.attributes
    assert_redirected_to playlist_item_path(assigns(:playlist_item))
  end

  test "should destroy playlist_item" do
    assert_difference('PlaylistItem.count', -1) do
      delete :destroy, :id => @playlist_item.to_param
    end

    assert_redirected_to playlist_items_path
  end
end
