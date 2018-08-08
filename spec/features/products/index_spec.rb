require 'rails_helper'

RSpec.describe 'Product list', :type => :feature  do
 it 'unauthenticated user' do
  category = Category.create!(name:'transport')
  visit category_products_path(category)
  within '#content' do
   expect(find('h1')).to have_content('transport')
  end
 end

 describe "viewing the index of each category" do
  it 'list all of the products' do
    # 1. create test data
    category = Category.create!(name:'transport')
    product = Product.create!(title: 'Toyota', description: 'car')
    product = Product.create!(title: 'Alienware', description: 'computer')
    # 2. interact with the app
    visit category_products_path(category)
    # 3. expect something to happen
    expect(page).to have_content('Toyota')
    expect(page).to have_content('Alienware')
  end
 end

 context 'create new product' do
  before(:each) do
    category = Category.create!(name:'transport')
    visit new_category_product_path(category)
    within('form') do
      fill_in 'title', with: 'Ford'
    end
  end
  scenario 'should be successful' do
    within('form') do
      fill_in 'description', with: 'bus'
    end
    click_button 'Create Product'
    expect(page).to have_content('Ford Description: bus')
  end

  scenario 'should fail' do
    click_button 'Create Product'
    expect(page).to_not have_content('bus')
    category = Category.create!(name:'transport')
    visit new_category_product_path(category)
    within('form') do
      fill_in 'title', with: 'Ford'
      fill_in 'description', with: ''
    end
  end
 end

 context 'update product' do
  before(:each) do
    category = Category.create!(name:'transport')
    product = Product.create!(title: 'Toyota', description: 'car')
    visit edit_category_product_path(category, product)
    within('form') do
      fill_in 'title', with: 'Toyota'
      fill_in 'description', with: 'car'
    end
  end

  scenario 'should be successful' do
    within('form') do
      fill_in 'title', with: 'Alienware'
      fill_in 'description', with: 'gaming laptop'
    end
    click_button 'Update Product'
    expect(page).to have_content('Alienware gaming laptop')
  end

  scenario 'should be fail' do
    within('form') do
      fill_in 'title', with: '.'
    end
    click_button 'Update Product'
    expect(page).to_not have_content('. gaming laptop')
  end
 end

 context 'destroy product' do
  scenario 'should be successfull' do
    category = Category.create!(name:'transport')
    product = Product.create!(title: 'Toyota', description: 'car')
    visit category_products_path(category, product)
    expect{ click_link 'Remove product' }.to change(Product, :count).by(-1)
  end
 end
end