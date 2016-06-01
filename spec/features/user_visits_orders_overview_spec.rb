require 'rails_helper'

feature 'User visits orders overview' do

  let!(:order) { create :order }
  let(:customer) { order.customer }

  scenario 'they see the full customer name' do
    visit '/'
    formated_name = "#{customer.first_name} #{customer.last_name}"
    expect(page).to have_text(formated_name)
  end

  scenario 'they see the full customer email' do
    visit '/'
    expect(page).to have_text(customer.email)
  end

  scenario 'they see the orders order-date' do
    visit '/'
    formatted_date = I18n.l(order.order_date)
    expect(page).to have_text(formatted_date)
  end

  scenario 'they see the course range' do
    visit '/'
    course_range = "#{I18n.l(order.course_start)} - #{I18n.l(order.course_end)}"
    expect(page).to have_text(course_range)
  end

  scenario 'they see the orders product' do
    visit '/'
    expect(page).to have_text(order.product)
  end

  scenario 'they see the orders price' do
    visit '/'
    expect(page).to have_text('99,00 €')
  end

  # context 'When an invoice already has been sent' do
  #   scenario 'they see a marked order row' do
  #     order.update(invoice_sent_at: Time.now)
  #     visit '/'
  #     expect(page).to have_selector('table tr.warning')
  #   end
  # end
  #
  # context 'When no invoice has been sent' do
  #   scenario 'they see no marked order rows' do
  #     visit '/'
  #     expect(page).not_to have_selector('table tr.warning')
  #   end
  # end
end
