require 'oystercard'

describe Oystercard do

  it 'has a balance of 0 as default' do
    expect(subject.balance).to eq(0)
  end

  it 'should error if try to top up balance above limit' do
    subject.top_up(subject.limit)
    expect { subject.top_up(1) }.to raise_error "You cannot top up beyond the limit of £#{subject.limit}"
  end

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

  it 'should charge people for their journey' do
    subject.top_up(subject.limit)
    subject.touch_in
    expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end
end
