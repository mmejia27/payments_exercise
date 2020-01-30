class PaymentsController < ActionController::API
  before_action :get_loan
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: @loan.payments
  end

  def show
    render json: Payment.find(params[:id])
  end

  def create
    @payment = @loan.payments.build(payment_params)

    if @payment.save
      render json: @payment, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  private

  def get_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_payment
    @payment = @loan.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :date_received, :loan_id)
  end
end
