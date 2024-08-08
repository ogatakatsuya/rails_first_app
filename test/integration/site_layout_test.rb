# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path
  end

  test 'layout links when logged in' do
    log_in_as(users(:michael))
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', user_path(users(:michael))
    assert_select 'a[href=?]', edit_user_path(users(:michael))
  end

  test 'should get signup' do
    get signup_path
    assert_template 'users/new'
  end

  test 'should get login' do
    get login_path
    assert_template 'sessions/new'
  end

  test 'should get users with login' do
    log_in_as(users(:michael))
    get users_path
    assert_template 'users/index'
  end

  test 'should get user with login' do
    log_in_as(users(:michael))
    get user_path(users(:michael))
    assert_template 'users/show'
  end

  test 'should get edit with login' do
    log_in_as(users(:michael))
    get edit_user_path(users(:michael))
    assert_template 'users/edit'
  end
end
