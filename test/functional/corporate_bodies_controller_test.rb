require 'test_helper'

class CorporateBodiesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:corporate_bodies)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_corporate_body
    assert_difference('CorporateBody.count') do
      post :create, :corporate_body => { }
    end

    assert_redirected_to corporate_body_path(assigns(:corporate_body))
  end

  def test_should_show_corporate_body
    get :show, :id => corporate_bodies(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => corporate_bodies(:one).id
    assert_response :success
  end

  def test_should_update_corporate_body
    put :update, :id => corporate_bodies(:one).id, :corporate_body => { }
    assert_redirected_to corporate_body_path(assigns(:corporate_body))
  end

  def test_should_destroy_corporate_body
    assert_difference('CorporateBody.count', -1) do
      delete :destroy, :id => corporate_bodies(:one).id
    end

    assert_redirected_to corporate_bodies_path
  end
end
