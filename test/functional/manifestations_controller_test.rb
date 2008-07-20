require 'test_helper'

class ManifestationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:manifestations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_manifestation
    assert_difference('Manifestation.count') do
      post :create, :manifestation => { }
    end

    assert_redirected_to manifestation_path(assigns(:manifestation))
  end

  def test_should_show_manifestation
    get :show, :id => manifestations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => manifestations(:one).id
    assert_response :success
  end

  def test_should_update_manifestation
    put :update, :id => manifestations(:one).id, :manifestation => { }
    assert_redirected_to manifestation_path(assigns(:manifestation))
  end

  def test_should_destroy_manifestation
    assert_difference('Manifestation.count', -1) do
      delete :destroy, :id => manifestations(:one).id
    end

    assert_redirected_to manifestations_path
  end
end
