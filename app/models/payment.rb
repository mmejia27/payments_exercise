class Payment < ActiveRecord::Base
  belongs_to :loan

  validate :validate_amount

  def validate_amount
    self.errors.add(:amount, "should be less than the balance remaining on the loan.") unless self.loan.balance >= self.amount
  end

end
