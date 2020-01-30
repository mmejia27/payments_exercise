require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    it 'responds with a 200' do
      get :index, params: {:loan_id => loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { loan.payments.create!(amount: 20.0) }

    it 'responds with a 200' do
      get :show, params: { id: payment.id, loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000, loan_id: loan.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    context 'if the payment is less than or equal to the balance' do
      it 'responds with a 201' do
        post :create, params: { loan_id: loan.id, payment: { amount: 20.0 } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'if the payment is greater than the balance' do
      let(:payment) { loan.payments.create!(amount: 80.0) }
      xit 'responds with a 422' do
        post :create, params: { loan_id: loan.id, payment: { amount: 21.0 } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

