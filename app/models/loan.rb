class Loan < ActiveRecord::Base
  has_many :payments

  def paid
    payments.map(&:amount).sum
  end

  def balance
    funded_amount - paid
  end
end
