require 'journey'

describe Journey do
  describe '#initialization' do
    subject { described_class.new }
  end
  let(:start_st) { double(:entry_station) }
  let(:end_st) { double(:exit_station) }

  def set_zone(zone0, zone1)
    allow(start_st).to receive(:zone).and_return(zone0)
    allow(end_st).to receive(:zone).and_return(zone1)
    set_stations
  end

  def set_stations
    subject.start_journey(start_st)
    subject.end_journey(end_st)
  end

  min_fare = Journey::MIN_FARE
  penalty_fare = Journey::PENALTY_FARE

  # describe 'journey' do
  #   it { is_expected.respond_to(:journey) }
  # end

  describe '#start_journey' do
    it { is_expected.to(respond_to(:start_journey).with(1).argument) }

    it 'stores the entry station' do
      subject.start_journey(:entry_station)
      expect(subject.entry_station).to eq(:entry_station)
    end
  end

  describe '#end_journey' do
    it { is_expected.to(respond_to(:end_journey).with(1).argument) }

    it 'stores the exit station' do
      subject.end_journey(:exit_station)
      expect(subject.exit_station).to eq(:exit_station)
    end
  end

  describe '#in_journey' do
    it { is_expected.to(respond_to(:in_journey?)) }

    it 'not in journey when entry_station = nil' do
      expect(subject).not_to(be_in_journey)
    end

    it 'is in journey when entry_station has value' do
      subject.start_journey(:entry_station)
      expect(subject).to(be_in_journey)
    end

    it 'is not in journey when journey is complete' do
      set_stations
      expect(subject).not_to(be_in_journey)
    end
  end

  describe '#fare' do

    it { is_expected.to(respond_to(:fare)) }




    it 'should return penalty fare for incomplete journey' do
      subject.start_journey(:start_station)
      expect(subject.fare).to eq(penalty_fare)
    end

    it 'should return penalty fare for incomplete journey' do
      subject.end_journey(:end_station)
      expect(subject.fare).to eq(penalty_fare)
    end

    context 'when travelling from zone 1 to zone 1' do
      it 'returns a fair of 1' do
        set_zone(1,1)
        expect(subject.fare).to eq 1
      end
    end
    context 'when travelling from zone 1 to zone 2' do
      it 'returns a fair of 2' do
        set_zone(1,2)
        expect(subject.fare).to eq 2
      end
    end
    context 'when travelling from zone 1 to zone 3' do
      it 'returns a fair of 3' do
        set_zone(1,3)
        expect(subject.fare).to eq 3
      end
    end
    context 'when travelling from zone 1 to zone 4' do
      it 'returns a fair of 4' do
        set_zone(1,4)
        expect(subject.fare).to eq 4
      end
    end
    context 'when travelling from zone 1 to zone 5' do
      it 'returns a fair of 5' do
        set_zone(1,5)
        expect(subject.fare).to eq 5
      end
    end
    context 'when travelling from zone 1 to zone 6' do
      it 'returns a fair of 6' do
        set_zone(1,6)
        expect(subject.fare).to eq 6
      end
    end
    context 'when travelling from zone 4 to zone 1' do
      it 'returns a fair of 4' do
        set_zone(4,1)
        expect(subject.fare).to eq 4
      end
    end
    context 'when travelling from zone 3 to zone 3' do
      it 'returns a fair of 1' do
        set_zone(3,3)
        expect(subject.fare).to eq 1
      end
    end
  end

end
