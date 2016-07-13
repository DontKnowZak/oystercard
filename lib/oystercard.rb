class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  MIN_AMOUNT = 1

  attr_reader :balance
  attr_reader :journeys

  def initialize
    @balance = 0
    @journey = {}
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAX_BALANCE} exceeded" if (@balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Card needs at least £#{MIN_AMOUNT} to touch in" if @balance < MIN_AMOUNT
    deduct_fare(MIN_FARE)
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    @journey[:exit_station] = exit_station
    @journeys << @journey
  end

  def in_journey?
    @journeys
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end
end
