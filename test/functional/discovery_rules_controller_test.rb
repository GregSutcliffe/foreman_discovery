require 'test_helper'

class DiscoveryRulesControllerTest < ActionController::TestCase
  setup do
    @discovery_rule = discovery_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discovery_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discovery_rule" do
    assert_difference('DiscoveryRule.count') do
      post :create, discovery_rule: {  }
    end

    assert_redirected_to discovery_rule_path(assigns(:discovery_rule))
  end

  test "should show discovery_rule" do
    get :show, id: @discovery_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discovery_rule
    assert_response :success
  end

  test "should update discovery_rule" do
    put :update, id: @discovery_rule, discovery_rule: {  }
    assert_redirected_to discovery_rule_path(assigns(:discovery_rule))
  end

  test "should destroy discovery_rule" do
    assert_difference('DiscoveryRule.count', -1) do
      delete :destroy, id: @discovery_rule
    end

    assert_redirected_to discovery_rules_path
  end
end
