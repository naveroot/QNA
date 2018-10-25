# frozen_string_literal: true

require 'rails_helper'

feature 'User Sign in', '
  In order to be able to ask questions
  As an user
  I want to sign in
  ' do
  scenario('Registred user try to sign in') do
    User.create! email: 'test@test.ru', password: '123456'

    visit new_user_session_path
    save_and_open_page
    fill_in 'Email', with: 'test@test.ru'
    fill_in 'Password', with: '123456'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfully'
    expect(current_page).to eq root_path
  end

  scenario('UNregistred user try to sign in') do
    User.create! email: 'test@test.ru', password: '123456'

    visit new_user_session_path
    fill_in 'Email', with: 'invalid@test.ru'
    fill_in 'Password', with: '123456'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_page).to eq new_user_session_path
  end
end
