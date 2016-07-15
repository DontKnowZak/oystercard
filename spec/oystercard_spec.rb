require 'oystercard'

describe Oystercard do
  describe '#initialization' do
    subject { described_class.new }
  end

  let(:card_with_money) { described_class.new }
  before(:each) { card_with_money.top_up(Oystercard::MAX_BALANCE) } #any reference to card_with_money will have its balance full
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double(:journey) }

  max_balance = Oystercard::MAX_BALANCE
  min_amount = Oystercard::MIN_AMOUNT
  min_fare = Oystercard::MIN_FARE

  describe '#class methods' do
    context 'these methods should exist in the class:' do
      it { is_expected.to(respond_to(:balance)) }
      it { is_expected.to(respond_to(:top_up).with(1).argument) }
      it { is_expected.to(respond_to(:in_journey?)) }
      it { is_expected.to(respond_to(:touch_in).with(1).argument) }
      it { is_expected.to(respond_to(:touch_out).with(1).argument) }
    end
  end

  describe '#balance' do
    context 'new Oystercard initialized:' do
      it 'with 0 balance' do
        expect(subject.balance).to(eq(0))
      end
    end
  end

  describe '#top_up' do
    context '#top_up should:' do
      it 'top up balance by minimum amount' do
        expect{ subject.top_up(min_amount) }.to change{ subject.balance }.by(min_amount)
      end

      it 'not top up if max balance exceeded' do
        subject.top_up(max_balance)
        expect{ subject.top_up(min_amount) }.to(raise_error("Maximum balance of £#{max_balance} exceeded"))
      end
    end
  end

  describe '#in_journey?' do
    context '#in_journey? should:' do
      it 'initially not be in journey' do
        expect(subject).not_to(be_in_journey)
      end
    end
  end

  describe '#touch_in' do
    context '#touch_in should:' do
      it 'change @journey to true' do
        card_with_money.touch_in(entry_station)
        expect(card_with_money).to(be_in_journey)
      end

      it 'raise error if card does not have minimum amount' do
        expect{ subject.touch_in(entry_station) }.to(raise_error("Card needs at least £#{min_amount} to touch in"))
      end

      # it 'deducts minimum fare from balance' do
      #   expect{card_with_money.touch_in(entry_station) }.to change{ card_with_money.balance}.by(-min_fare)
      # end
    end
  end

  describe '#touch_out' do
    context '#touch_out should:' do
      it 'change @journey to false' do
        allow(entry_station).to receive(:zone).and_return(1)
        allow(exit_station).to receive(:zone).and_return(1)
        card_with_money.touch_in(entry_station)
        card_with_money.touch_out(exit_station)
        expect(card_with_money).not_to(be_in_journey)
      end
    end
  end

  describe '#journeys' do
    it 'is a JourneyLog object' do
      expect(subject.journeys).to be_instance_of(JourneyLog)
    end
  end
end
