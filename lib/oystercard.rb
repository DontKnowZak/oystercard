require_relative 'journey'

class Oystercard

  LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  attr_reader :journey

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    (@balance + amount) > LIMIT ? (fail "Exceeded balance limit of £#{LIMIT}") : @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient balance. Minimum £#{MINIMUM_FARE}" if  @balance < MINIMUM_FARE
    @journey = Journey.new
    @journey.entry(entry_station)
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey.end(exit_station)
    @exit_station = exit_station
    store_journey
    clear_stations
  end

  def in_journey?
    !!@entry_station
  end

  def store_journey
    @journeys << @journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def clear_stations
    @entry_station = nil
    @exit_station = nil
  end

end
