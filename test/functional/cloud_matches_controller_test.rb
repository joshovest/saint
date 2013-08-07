require 'test_helper'

class CloudMatchesControllerTest < ActionController::TestCase
  setup do
    @cloud_match = cloud_matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cloud_matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cloud_match" do
    assert_difference('CloudMatch.count') do
      post :create, cloud_match: @cloud_match.attributes
    end

    assert_redirected_to cloud_match_path(assigns(:cloud_match))
  end

  test "should show cloud_match" do
    get :show, id: @cloud_match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cloud_match
    assert_response :success
  end

  test "should update cloud_match" do
    put :update, id: @cloud_match, cloud_match: @cloud_match.attributes
    assert_redirected_to cloud_match_path(assigns(:cloud_match))
  end

  test "should destroy cloud_match" do
    assert_difference('CloudMatch.count', -1) do
      delete :destroy, id: @cloud_match
    end

    assert_redirected_to cloud_matches_path
  end
end
