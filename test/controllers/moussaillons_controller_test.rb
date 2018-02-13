require 'test_helper'

class MoussaillonsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    @moussaillon = Moussaillon.create(username: "Test", email: "test@free.fr", password: "lolo12345", password_confirmation: "lolo12345", sign_up_code: "GOSSIPTHP2018")
  end

  test "redirect to index if logged in" do
    @moussaillon.save
    get root_path
    post new_moussaillon_session_path, params: { moussaillon: { username: @moussaillon.username, email: @moussaillon.email, password: @moussaillon.password, password_confirmation: @moussaillon.password_confirmation, sign_up_code: @moussaillon.sign_up_code } }
    assert_response :success
  end

  test "redirect to gossip if sign up" do
    get new_moussaillon_registration_path
    post moussaillon_registration_path, params: { moussaillon: { username: @moussaillon.username, email: @moussaillon.email, password: @moussaillon.password, password_confirmation: @moussaillon.password_confirmation, sign_up_code: @moussaillon.sign_up_code } }
    sign_in(@moussaillon)
    get gossips_path

    assert_template "layouts/_head"
    assert_template "layouts/_shim"
    assert_template "gossips/index"
    assert_template "layouts/_header"
    assert_template "layouts/application"
  end

  test "moussaillon should be able to delete his gossips" do
    get new_moussaillon_session_path
    post new_moussaillon_session_path, params: { moussaillon: { username: @moussaillon.username, email: @moussaillon.email, password: @moussaillon.password, password_confirmation: @moussaillon.password_confirmation, sign_up_code: @moussaillon.sign_up_code } }

    assert_select 'a', {:count=>Gossip.find_by(moussaillon_id:1)}
  end

  test "can't sign up without the special code" do
    get new_moussaillon_registration_path
    post moussaillon_registration_path, params: { user: { username: "jasonsanscode", email: "jason@sanscode.com", password: "lolo12345", password_confirmation: "lolo12345" }}

    assert_select 'td.content', {:count=>0}
  end

  test "can subscribe with the special code" do
    get new_moussaillon_registration_path
    post moussaillon_registration_path, params: { moussaillon: { username: @moussaillon.username, email: @moussaillon.email, password: @moussaillon.password, password_confirmation: @moussaillon.password_confirmation, sign_up_code: @moussaillon.sign_up_code } }

    get gossips_path
  end
  
end