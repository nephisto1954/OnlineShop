require 'rails_helper'

RSpec.describe 'Category list', :type => :feature  do
 it 'unauthenticated user' do
  visit ('/')
  within '#content' do
   expect(find('h1')).to have_content('Categories')
  end
 end

 describe "viewing the index" do
  it 'list all of the categories' do
    # 1. create test data
    Category.create!(name: 'transport')
    Category.create!(name: 'tv')
    # 2. interact with the app
    visit('/')
    # 3. expect something to happen
    expect(page).to have_content('transport')
    expect(page).to have_content('tv')
  end
 end

 context 'create new category' do
  before(:each) do
    visit new_category_path
  end
  scenario 'should be successful' do
    within('form') do
      fill_in 'name', with: 'boat'
    end
    click_button 'Create Category'
    expect(page).to have_content('boat')
  end

  scenario 'should fail' do
    click_button 'Create Category'
    expect(page).to_not have_content('boat')
  end
 end

 context 'update category' do
  let!(:category){ Category.create(name:'boat') }
  before(:each) do
    visit edit_category_path(category)
  end

  scenario 'should be successful' do
    within('form') do
      fill_in 'name', with: 'food'
    end
    click_button 'Update Category'
    expect(page).to have_content('food')
  end

  scenario 'should be fail' do
    within('form') do
      fill_in 'name', with: ''
    end
    click_button 'Update Category'
    expect(page).to have_content('boat')
  end
 end

 context 'destroy category' do
  scenario 'should be successfull' do
    category = Category.create(name: 'boat')
    visit categories_path
    expect{ click_link 'Remove category' }.to change(Category, :count).by(-1)
  end
 end
end