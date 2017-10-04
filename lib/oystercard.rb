class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  attr_accessor
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station
    @journey_history = []
  end

  def top_up(amount)
    raise "You cannot exceed max balance of #{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'You need to top up!' if @balance < MIN_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey_history << {entry_station: @entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  def in_use?
    !!entry_station
  end

  private
    def deduct(fare)
      @balance -= fare
    end
end
