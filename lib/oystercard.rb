class Oystercard
attr_reader :balance
attr_accessor :in_journey
  MAX_BALANCE = 90

  def initialize(balance = 0, max_balance = MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @in_journey = false
  end

  def top_up(amount)
    raise "You cannot exceed max balance of #{:max_balance}" if (@balance + amount) > @max_balance
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

end
