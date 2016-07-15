require_relative 'station'

class Journey
	# attr_reader :journey
	MIN_FARE = 1
	PENALTY_FARE = 6
	attr_reader :entry_station
	attr_reader :exit_station

	def start_journey(entry_station)
		@entry_station = entry_station
	end

	def end_journey(exit_station)
		@exit_station = exit_station
	end

	def in_journey?
		!!entry_station && !exit_station
	end

	def fare
		return zone_fare if !entry_station.nil? && !exit_station.nil?
		return PENALTY_FARE
	end

private

  def zone_fare
    (@entry_station.zone - @exit_station.zone).abs + 1
  end

end
