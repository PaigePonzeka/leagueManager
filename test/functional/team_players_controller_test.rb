require 'test_helper'

class TeamPlayersControllerTest < ActionController::TestCase
  setup do
    @team_player = team_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_player" do
    assert_difference('TeamPlayer.count') do
      post :create, team_player: { player_id: @team_player.player_id, team_id: @team_player.team_id }
    end

    assert_redirected_to team_player_path(assigns(:team_player))
  end

  test "should show team_player" do
    get :show, id: @team_player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_player
    assert_response :success
  end

  test "should update team_player" do
    put :update, id: @team_player, team_player: { player_id: @team_player.player_id, team_id: @team_player.team_id }
    assert_redirected_to team_player_path(assigns(:team_player))
  end

  test "should destroy team_player" do
    assert_difference('TeamPlayer.count', -1) do
      delete :destroy, id: @team_player
    end

    assert_redirected_to team_players_path
  end
end
