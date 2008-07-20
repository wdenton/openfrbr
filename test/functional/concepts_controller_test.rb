require 'test_helper'

class ConceptsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:concepts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_concept
    assert_difference('Concept.count') do
      post :create, :concept => { }
    end

    assert_redirected_to concept_path(assigns(:concept))
  end

  def test_should_show_concept
    get :show, :id => concepts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => concepts(:one).id
    assert_response :success
  end

  def test_should_update_concept
    put :update, :id => concepts(:one).id, :concept => { }
    assert_redirected_to concept_path(assigns(:concept))
  end

  def test_should_destroy_concept
    assert_difference('Concept.count', -1) do
      delete :destroy, :id => concepts(:one).id
    end

    assert_redirected_to concepts_path
  end
end
