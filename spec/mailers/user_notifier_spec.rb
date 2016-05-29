require "rails_helper"

describe UserNotifier, type: :mailer do
  let(:order) { build :order }
  let(:mail) { ActionMailer::Base.deliveries.first }

  before do
    UserNotifier.invoice(order).deliver
  end

  it 'has the right recipient' do
    expect(mail.to).to eq ([order.customer.email])
  end

  it 'has the right subject' do
    expect(mail.subject).to eq "Ihre Rechnung: #{order.product}"
  end
end
