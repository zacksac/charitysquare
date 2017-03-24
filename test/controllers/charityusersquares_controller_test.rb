require 'test_helper'

class CharityusersquaresControllerTest < ActionController::TestCase
  setup do
    @charityusersquare = charityusersquares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charityusersquares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charityusersquare" do
    assert_difference('Charityusersquare.count') do
      post :create, charityusersquare: {  }
    end

    assert_redirected_to charityusersquare_path(assigns(:charityusersquare))
  end

  test "should show charityusersquare" do
    get :show, id: @charityusersquare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @charityusersquare
    assert_response :success
  end

  test "should update charityusersquare" do
    patch :update, id: @charityusersquare, charityusersquare: {  }
    assert_redirected_to charityusersquare_path(assigns(:charityusersquare))
  end

  test "should destroy charityusersquare" do
    assert_difference('Charityusersquare.count', -1) do
      delete :destroy, id: @charityusersquare
    end

    assert_redirected_to charityusersquares_path
  end
end
