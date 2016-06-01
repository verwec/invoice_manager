require 'rails_helper'

feature 'User edits order' do
  let!(:order) { create :order }

  before do
    visit '/'
    click_link 'Rechnung bearbeiten'
  end

  scenario 'they edit the price' do
    fill_in 'order_price', with: '5500'
    click_button 'Order aktualisieren'
    expect(page).to have_content('55,00 €')
  end

  scenario 'they edit the product' do
    fill_in 'order_product', with: 'New product name'
    click_button 'Order aktualisieren'
    expect(page).to have_content('New product name')
  end

  scenario 'they edit the invoice_number' do
    fill_in 'order_invoice_number', with: '001'
    click_button 'Order aktualisieren'
    expect(page).to have_content('001')
  end
end
