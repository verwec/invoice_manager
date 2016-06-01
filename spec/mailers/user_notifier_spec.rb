require "rails_helper"

describe UserNotifier, type: :mailer do
  let(:order) { build :order }
  let(:mail) { ActionMailer::Base.deliveries.first }

  before do
    Timecop.freeze
    UserNotifier.invoice(order).deliver
  end

  after do
    Timecop.return
  end

  it 'has the right recipient' do
    expect(mail.to).to eq ([order.customer.email])
  end

  it 'has the right subject' do
    expect(mail.subject).to eq "Ihre Rechnung: #{order.product}"
  end

  it 'has an attachment' do
    expect(mail.attachments.count).to be > 0
  end

  it 'logs the delivery' do
    expect(order.invoice_sent_at).to eq Time.now
  end
end
