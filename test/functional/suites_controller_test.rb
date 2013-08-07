require 'test_helper'

class SuitesControllerTest < ActionController::TestCase
  setup do
    @suite = suites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create suite" do
    assert_difference('Suite.count') do
      post :create, suite: @suite.attributes
    end

    assert_redirected_to suite_path(assigns(:suite))
  end

  test "should show suite" do
    get :show, id: @suite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @suite
    assert_response :success
  end

  test "should update suite" do
    put :update, id: @suite, suite: @suite.attributes
    assert_redirected_to suite_path(assigns(:suite))
  end

  test "should destroy suite" do
    assert_difference('Suite.count', -1) do
      delete :destroy, id: @suite
    end

    assert_redirected_to suites_path
  end
end
