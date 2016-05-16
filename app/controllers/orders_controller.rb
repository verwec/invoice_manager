class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def create
    Order.import(params[:file])
    redirect_to root_url
  end

  def download
    order = Order.find(params[:id])
    send_data order.to_invoice_pdf, filename: "#{order.order_uid}.pdf", type: 'application/pdf'
  end
end
