require 'test_helper'

class DivisionRepsControllerTest < ActionController::TestCase
  setup do
    @division_rep = division_reps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:division_reps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create division_rep" do
    assert_difference('DivisionRep.count') do
      post :create, division_rep: { division_id: @division_rep.division_id, user_id: @division_rep.user_id }
    end

    assert_redirected_to division_rep_path(assigns(:division_rep))
  end

  test "should show division_rep" do
    get :show, id: @division_rep
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @division_rep
    assert_response :success
  end

  test "should update division_rep" do
    put :update, id: @division_rep, division_rep: { division_id: @division_rep.division_id, user_id: @division_rep.user_id }
    assert_redirected_to division_rep_path(assigns(:division_rep))
  end

  test "should destroy division_rep" do
    assert_difference('DivisionRep.count', -1) do
      delete :destroy, id: @division_rep
    end

    assert_redirected_to division_reps_path
  end
end
