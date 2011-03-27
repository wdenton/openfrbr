require 'test_helper'

class FamiliesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:families)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_family
    assert_difference('Family.count') do
      post :create, :family => { }
    end

    assert_redirected_to family_path(assigns(:family))
  end

  def test_should_show_family
    get :show, :id => families(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => families(:one).id
    assert_response :success
  end

  def test_should_update_family
    put :update, :id => families(:one).id, :family => { }
    assert_redirected_to family_path(assigns(:family))
  end

  def test_should_destroy_family
    assert_difference('Family.count', -1) do
      delete :destroy, :id => families(:one).id
    end

    assert_redirected_to families_path
  end
end
