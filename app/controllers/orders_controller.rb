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
    order.to_invoice_pdf
  end
end
