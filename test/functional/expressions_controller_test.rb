require 'test_helper'

class ExpressionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:expressions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_expression
    assert_difference('Expression.count') do
      post :create, :expression => { }
    end

    assert_redirected_to expression_path(assigns(:expression))
  end

  def test_should_show_expression
    get :show, :id => expressions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => expressions(:one).id
    assert_response :success
  end

  def test_should_update_expression
    put :update, :id => expressions(:one).id, :expression => { }
    assert_redirected_to expression_path(assigns(:expression))
  end

  def test_should_destroy_expression
    assert_difference('Expression.count', -1) do
      delete :destroy, :id => expressions(:one).id
    end

    assert_redirected_to expressions_path
  end
end
