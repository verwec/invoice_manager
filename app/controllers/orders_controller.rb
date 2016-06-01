class OrdersController < ApplicationController
  def index
    @orders = Order.order(:order_date)
  end

  def create
    Order.import(params[:file])
    redirect_to root_url
  end

  def send_mail
    order = Order.find(params[:id])
    UserNotifier.invoice(order).deliver
    redirect_to orders_path
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to orders_path
    else
      render 'edit'
    end
  end

  def download
    order = Order.find(params[:id])
    send_data order.to_invoice_pdf, filename: "#{order.order_uid}.pdf", type: 'application/pdf'
  end

  private

  def order_params
    params
      .require(:order)
      .permit(:price, :product, :course_start, :course_end, :payment_date, :invoice_number)
  end
end
