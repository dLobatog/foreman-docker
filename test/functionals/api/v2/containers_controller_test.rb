require 'test_plugin_helper'

class ContainersControllerTest < ActionController::TestCase
  test 'index returns a list of all containers' do
    get :index, {}, set_session_user
    assert_response :success
    assert_template 'index'
  end

  test 'show returns information about container'  do
  end

  test 'delete removes a container in foreman and in Docker host' do
  end

  test 'power call turns on/off container in Docker host' do
  end

  test 'log returns latest lines of container log' do
  end
end
