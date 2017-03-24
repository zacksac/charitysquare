require 'test_helper'

class MysquaresControllerTest < ActionController::TestCase
  setup do
    @mysquare = mysquares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mysquares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mysquare" do
    assert_difference('Mysquare.count') do
      post :create, mysquare: { info: @mysquare.info, lat: @mysquare.lat, long: @mysquare.long, name: @mysquare.name, square_raiser_id: @mysquare.square_raiser_id }
    end

    assert_redirected_to mysquare_path(assigns(:mysquare))
  end

  test "should show mysquare" do
    get :show, id: @mysquare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mysquare
    assert_response :success
  end

  test "should update mysquare" do
    patch :update, id: @mysquare, mysquare: { info: @mysquare.info, lat: @mysquare.lat, long: @mysquare.long, name: @mysquare.name, square_raiser_id: @mysquare.square_raiser_id }
    assert_redirected_to mysquare_path(assigns(:mysquare))
  end

  test "should destroy mysquare" do
    assert_difference('Mysquare.count', -1) do
      delete :destroy, id: @mysquare
    end

    assert_redirected_to mysquares_path
  end
end
