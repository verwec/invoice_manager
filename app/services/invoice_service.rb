class InvoiceService < Struct.new(:order)

  def generate
    formated_date = I18n.l(order_date)
    year = order_date.year
    subject = "Rechnungs-Nr.: #{order_uid}/#{year}"
    gross_price = '%.2f' % (price/100.0)
    net_price   = '%.2f' % (price/107.0)
    interests = '%.2f' % (price/107.0*0.07)

    order = "1x #{product} <br><br>"\
      "Nettobetrag:       #{net_price} € <br>"\
      "7% MwSt.:             #{interests} € <br><br>"\
      "Gesamtbetrag:    #{gross_price} € "

      params = {
        date: formated_date,
        subject: subject,
        sender_name: 'Silke Gassert',
        sender_address: 'Gorkistr. 63',
        sender_zipcode: '13509',
        sender_city: 'Berlin',
        recipient_name: "#{customer.first_name} #{customer.last_name}",
        recipient_address: customer.address,
        recipient_zipcode: customer.zipcode,
        recipient_city: customer.city,
        order_date: formated_date,
        total: "#{gross_price} €",
        bank: 'netbank',
        sender_iban: 'DE23200905000002277670',
        sender_bic: 'GENODEF1S15',
        reference: subject,
        order: order,
        sender_commercial_register_number: '',
        sender_district_court: 'Finanzamt Berlin',
        sender_tax_number: '17/301/00608',
        salutation: 'Sehr geehrte Damen und Herren,',
        farewell: 'Vielen Dank!<br>Mit freundlich Grüßen<br>'
      }
      InvoiceGenerator.generate_invoice("Rechung #{order_uid}.pdf", params).render
  end

  def method_missing(method_name, *arguments, &block)
    if order.send method_name.to_sym
      order.send method_name.to_sym
    else
      super
    end
  end
end
