require 'journey_log'

describe JourneyLog do

  let(:journey) { double(:journey) }

  describe '#start_journey' do

    it 'responds to start_journey' do
      expect(subject).to respond_to(:start_journey).with(1).argument
    end

    it 'should store the entry station in journey' do
      subject.start_journey("asd")
      expect(subject.journey.entry_station).to eq "asd"
    end
  end

  describe '#end_journey' do

    it 'responds to start_journey' do
      expect(subject).to respond_to(:end_journey).with(1).argument
    end

    it 'should store the exit station' do
      subject.end_journey("asd")
      expect(subject.journey.exit_station).to eq "asd"
    end
  end

  describe 'in_journey?' do
    it 'responds to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end

    it 'not in journey when entry_station = nil' do
      expect(subject).not_to(be_in_journey)
    end
    it 'is in journey when entry_station has value' do
      subject.start_journey(:entry_station)
      expect(subject).to(be_in_journey)
    end
      it 'is not in journey when journey is complete' do
      subject.start_journey(:entry_station)
      subject.end_journey(:exit_station)
      expect(subject).not_to(be_in_journey)
    end
  end

  describe '#fare' do
    let(:start_st) { double(:entry_station) }
    let(:end_st) { double(:exit_station) }

    it 'responds to fare' do
      expect(subject).to respond_to(:fare)
    end

    it 'returns a fare' do
      allow(start_st).to receive(:zone).and_return(1)
      allow(end_st).to receive(:zone).and_return(1)
      subject.start_journey(start_st)
      subject.end_journey(end_st)
      expect(subject.fare).to eq 1
    end
  end

  describe '#store_journey' do
    it 'should store a journey into journeys' do
      allow(Journey).to receive(:new).and_return(journey)
      expect{ subject.store_journey }.to change{ subject.journeys }.to [journey]
    end
  end

  describe '#journeys' do
    it 'should return journeys list' do
      expect(subject.journeys).to eq []
    end
  end
end
