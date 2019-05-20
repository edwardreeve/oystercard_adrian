require 'oystercard'

describe Oystercard do
  it 'is a type of Oystercard' do
    expect(subject).to be_a_kind_of(Oystercard)
  end

  it 'has a balance of 0 as default' do
    expect(subject.balance).to eq(0)
  end

  it 'should be possible to top it up' do
    subject.top_up(3)
    expect(subject.balance).to eq(3)
  end
end
