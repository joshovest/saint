require 'test_helper'

class BrandMatchesControllerTest < ActionController::TestCase
  setup do
    @brand_match = brand_matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brand_matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brand_match" do
    assert_difference('BrandMatch.count') do
      post :create, brand_match: @brand_match.attributes
    end

    assert_redirected_to brand_match_path(assigns(:brand_match))
  end

  test "should show brand_match" do
    get :show, id: @brand_match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brand_match
    assert_response :success
  end

  test "should update brand_match" do
    put :update, id: @brand_match, brand_match: @brand_match.attributes
    assert_redirected_to brand_match_path(assigns(:brand_match))
  end

  test "should destroy brand_match" do
    assert_difference('BrandMatch.count', -1) do
      delete :destroy, id: @brand_match
    end

    assert_redirected_to brand_matches_path
  end
end
