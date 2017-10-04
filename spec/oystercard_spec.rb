require 'oystercard'

describe Oystercard do
  let (:entry_station) {double :entry_station}
  let (:exit_station) {double :exit_station}

  describe 'balance' do
    it 'every new card has a balance of 0' do
      expect(subject.balance).to eq(0)
    end

    it 'changes balance when top_up' do
      expect { subject.top_up 2 }.to change { subject.balance }.by 2
    end

    it 'prevents balance exceeding 90' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up(4) }.to raise_error "You cannot exceed max balance of #{max_balance}"
    end
  end

  describe 'in_use' do

    it 'in_use is true when touch_in' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.in_use?).to eq(true)
    end

    it 'in_use is false when touch_out' do
      subject.touch_out(exit_station)
      expect(subject.in_use?).to eq(false)
    end
  end

    it 'registers which station you have touch_in at' do
      subject.top_up(2)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end

    it 'deducts min_fare when touch_out' do
      min_fare = Oystercard::MIN_FARE
      subject.top_up(2)
      expect { subject.touch_out(exit_station) }.to change { subject.balance}.by(-min_fare)
    end

    it 'sets entry_station to nil on touch_out' do
      subject.top_up(2)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq(nil)
    end

    describe 'journey_history'do
      it 'journey_history is empty in ceation of an instance'do
        expect(subject.journey_history).to eq([])
      end

      it 'journey_history recods all touch_in and touch_out 'do
        subject.top_up(2)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journey_history).to eq([{entry_station: entry_station, exit_station: exit_station}])
      end
    end

    it 'raises an error if balance is less than 1 when touch_in' do
      expect { subject.touch_in(entry_station) }.to raise_error 'You need to top up!'
    end
end
