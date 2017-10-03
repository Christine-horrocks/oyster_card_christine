class Oystercard
  attr_reader :balance, :entry_station
  attr_accessor :in_use
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_use = false
    @entry_station
  end

  def top_up(amount)
    raise "You cannot exceed max balance of #{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'You need to top up!' if @balance < MIN_BALANCE
    @entry_station = entry_station
    @in_use = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_use = false
  end

  private
    def deduct(fare)
      @balance -= fare
    end
end
