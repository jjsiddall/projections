require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { attempts: @player.attempts, completions: @player.completions, fpoints: @player.fpoints, fumble_recoveries: @player.fumble_recoveries, interceptions: @player.interceptions, kicking_attempts_1_to_39: @player.kicking_attempts_1_to_39, kicking_attempts_40_to_49: @player.kicking_attempts_40_to_49, kicking_attempts_XP: @player.kicking_attempts_XP, kicking_attempts_over_50: @player.kicking_attempts_over_50, kicking_attempts_total: @player.kicking_attempts_total, kicking_completions_1_to_39: @player.kicking_completions_1_to_39, kicking_completions_40_to_49: @player.kicking_completions_40_to_49, kicking_completions_XP: @player.kicking_completions_XP, kicking_completions_over_50: @player.kicking_completions_over_50, kicking_completions_total: @player.kicking_completions_total, name: @player.name, pass_tds: @player.pass_tds, pass_yards: @player.pass_yards, picture_url: @player.picture_url, points_against: @player.points_against, position: @player.position, receiving_tds: @player.receiving_tds, receiving_yards: @player.receiving_yards, receptions: @player.receptions, rush_tds: @player.rush_tds, rush_yards: @player.rush_yards, rushes: @player.rushes, sacks: @player.sacks, stat_year: @player.stat_year, targets: @player.targets, team: @player.team, yards_against: @player.yards_against }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player
    assert_response :success
  end

  test "should update player" do
    put :update, id: @player, player: { attempts: @player.attempts, completions: @player.completions, fpoints: @player.fpoints, fumble_recoveries: @player.fumble_recoveries, interceptions: @player.interceptions, kicking_attempts_1_to_39: @player.kicking_attempts_1_to_39, kicking_attempts_40_to_49: @player.kicking_attempts_40_to_49, kicking_attempts_XP: @player.kicking_attempts_XP, kicking_attempts_over_50: @player.kicking_attempts_over_50, kicking_attempts_total: @player.kicking_attempts_total, kicking_completions_1_to_39: @player.kicking_completions_1_to_39, kicking_completions_40_to_49: @player.kicking_completions_40_to_49, kicking_completions_XP: @player.kicking_completions_XP, kicking_completions_over_50: @player.kicking_completions_over_50, kicking_completions_total: @player.kicking_completions_total, name: @player.name, pass_tds: @player.pass_tds, pass_yards: @player.pass_yards, picture_url: @player.picture_url, points_against: @player.points_against, position: @player.position, receiving_tds: @player.receiving_tds, receiving_yards: @player.receiving_yards, receptions: @player.receptions, rush_tds: @player.rush_tds, rush_yards: @player.rush_yards, rushes: @player.rushes, sacks: @player.sacks, stat_year: @player.stat_year, targets: @player.targets, team: @player.team, yards_against: @player.yards_against }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_redirected_to players_path
  end
end
