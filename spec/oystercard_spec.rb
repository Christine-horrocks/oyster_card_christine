require 'oystercard'

describe Oystercard do
  it 'every new card has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'oystercard can be top_up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'changes balance when top_up' do
    expect{ subject.top_up 2 }.to change{ subject.balance }.by 2
  end

  it 'prevents balance exceeding 90' do
    max_balance = Oystercard::MAX_BALANCE
    subject.top_up(max_balance)
    expect { subject.top_up(4) }.to raise_error "You cannot exceed max balance of #{:max_balance}"
  end

  it 'reduces balance when deduct' do
    expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
  end

  it 'when initialized in_use is false' do
    expect(subject.in_use).to eq(false)
  end

  it 'in_use is true when touch_in' do
    subject.touch_in
    expect(subject.in_use).to eq(true)
  end

  it 'in_use is false when touch_out' do
    subject.touch_out
    expect(subject.in_use).to eq(false)
  end

end
