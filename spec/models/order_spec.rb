require 'rails_helper'

describe Order do
  describe '.import' do
    before do
      file = File.open('./spec/data/import.csv')
      Order.import(file)
    end

    it 'creates a new order' do
      expect(Order.count).to eq(1)
    end

    describe 'the created order' do
      let(:order) { Order.first }

      it 'has an uid' do
        expect(order.order_uid).to eq 1
      end

      it 'has a course_start' do
        expect(order.course_start.to_s).to eq '2016-02-15'
      end

      it 'has a course_end' do
        expect(order.course_end.to_s).to eq '2016-04-24'
      end

      it 'has a price' do
        expect(order.price).to eq 9900
      end

      it 'has a product' do
        expect(order.product).to eq 'Schwimmen Montag'
      end

      it 'has an order date' do
        expect(order.order_date.to_s).to eq '2015-12-29'
      end

      it 'has a payment date' do
        expect(order.payment_date.to_s).to eq '2016-02-01'
      end
    end
  end
end
