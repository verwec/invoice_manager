class Order < ActiveRecord::Base
  require 'csv'
  belongs_to :customer

  def to_invoice_pdf
    InvoiceService.new(self).generate
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      order_uid = row[0]

      reg = /(\d\d\.\d\d\.\d\d).*(\d\d\.\d\d\.\d\d)/
      matches = reg.match(row[5])

      from = Date.strptime(matches[1], '%d.%m.%y')
      to = Date.strptime(matches[2], '%d.%m.%y')

      payment_date = from.advance(days: -14)

      customer = Customer.create(
        first_name: row[21],
        last_name: row[19],
        address: row[23],
        zipcode: row[24],
        city: row[25]
      )

      year = Date.parse(row[2]).year
      price = row[14].to_i * 100
      customer.orders.create(
        order_uid: order_uid,
        invoice_number: "#{order_uid}/#{year}",
        course_start: from,
        course_end: to,
        price: price,
        product: row[4],
        order_date: row[2],
        payment_date: payment_date
      )
    end
  end
end
