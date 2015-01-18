class InquiryController < ApplicationController
  def index
    @inquiry = InquiryForm.new
    render action: 'index'
  end

  def confirm
    @inquiry = InquiryForm.new(params[:inquiry_form])
    if @inquiry.valid?
      render action: 'confirm'
    else
      flash.now[:alert] = "入力に誤りがあります。"
      render action: 'index'
    end
  end

  def thanks
    @inquiry = InquiryForm.new(params[:inquiry_form])
    InquiryMailer.received_email(@inquiry).deliver_now

    render action: 'thanks'
  end
end
