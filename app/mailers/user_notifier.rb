class UserNotifier < ApplicationMailer
  def invoice(order)
    @order = order
    @customer = order.customer
    @course_description = "1x #{@order.product} (#{I18n.l(@order.course_start)} - #{I18n.l(@order.course_end)})"
    subject = "Ihre Rechnung: #{order.product}"
    attachments["Rechnung_#{@order.order_uid}.pdf"] = order.to_invoice_pdf
    order.update(invoice_sent_at: Time.now)
    mail(to: @customer.email,
         subject: subject,
         bcc: ENV['BCC_RECIPIENT']
        )
  end
end
