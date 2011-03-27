require 'test_helper'

class FrbrObjectsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:frbr_objects)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_frbr_object
    assert_difference('FrbrObject.count') do
      post :create, :frbr_object => { }
    end

    assert_redirected_to frbr_object_path(assigns(:frbr_object))
  end

  def test_should_show_frbr_object
    get :show, :id => frbr_objects(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => frbr_objects(:one).id
    assert_response :success
  end

  def test_should_update_frbr_object
    put :update, :id => frbr_objects(:one).id, :frbr_object => { }
    assert_redirected_to frbr_object_path(assigns(:frbr_object))
  end

  def test_should_destroy_frbr_object
    assert_difference('FrbrObject.count', -1) do
      delete :destroy, :id => frbr_objects(:one).id
    end

    assert_redirected_to frbr_objects_path
  end
end
