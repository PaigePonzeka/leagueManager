require 'test_helper'

class TeamDivisionsControllerTest < ActionController::TestCase
  setup do
    @team_division = team_divisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_divisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_division" do
    assert_difference('TeamDivision.count') do
      post :create, team_division: { division_id: @team_division.division_id, team_id: @team_division.team_id }
    end

    assert_redirected_to team_division_path(assigns(:team_division))
  end

  test "should show team_division" do
    get :show, id: @team_division
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_division
    assert_response :success
  end

  test "should update team_division" do
    put :update, id: @team_division, team_division: { division_id: @team_division.division_id, team_id: @team_division.team_id }
    assert_redirected_to team_division_path(assigns(:team_division))
  end

  test "should destroy team_division" do
    assert_difference('TeamDivision.count', -1) do
      delete :destroy, id: @team_division
    end

    assert_redirected_to team_divisions_path
  end
end
