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

  it 'should error if try to top up balance above limit' do
    subject.top_up(subject.limit)
    expect { subject.top_up(1) }.to raise_error "You cannot top up beyond the limit of £#{subject.limit}"
  end

  it 'should allow money to be deducted' do
    subject.top_up(subject.limit)
    amount = subject.limit / 3
    expect(subject.deduct(amount)).to eq(subject.limit - amount)
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  it 'should initialize with in_journey false' do
    expect(subject.in_journey?).to eq(false)
  end

  it 'should change in_journey to true when touch_in' do
    subject.top_up(subject.limit)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'should change in_journey to false when touch_out' do
    subject.top_up(subject.limit)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'should throw insufficient balance error where applicable' do
    expect { subject.touch_in }.to raise_error 'Insufficient balance to travel'
  end
end
