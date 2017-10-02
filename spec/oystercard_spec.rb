require 'oystercard'

describe Oystercard do
  it 'every new card has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'oystercard can be top_up to change balance' do
    expect(subject).to respond_to(:top_up)
  end

end
