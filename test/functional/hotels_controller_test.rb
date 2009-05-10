require 'test_helper'

class HotelsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:hotels)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_hotel
    assert_difference('Hotel.count') do
      post :create, :hotel => { }
    end

    assert_redirected_to hotel_path(assigns(:hotel))
  end

  def test_should_show_hotel
    get :show, :id => hotels(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => hotels(:one).id
    assert_response :success
  end

  def test_should_update_hotel
    put :update, :id => hotels(:one).id, :hotel => { }
    assert_redirected_to hotel_path(assigns(:hotel))
  end

  def test_should_destroy_hotel
    assert_difference('Hotel.count', -1) do
      delete :destroy, :id => hotels(:one).id
    end

    assert_redirected_to hotels_path
  end
end
