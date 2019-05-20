require 'oystercard'

describe Oystercard do
  let(:station) { double(:station) }
  it 'has a balance of 0 as default' do
    expect(subject.balance).to eq(0)
  end
  it 'should initialize with in_journey false' do
    expect(subject.in_journey?).to eq(false)
  end
  it 'should throw insufficient balance error where applicable' do
    expect { subject.touch_in(station) }.to raise_error 'Insufficient balance to travel'
  end
  describe 'Card has money on it' do
    before(:each) { subject.top_up(subject.limit) }
    it 'should charge people for their journey' do
      subject.touch_in(station)
      expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end
    it 'should change in_journey to false when touch_out' do
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
    it 'should error if try to top up balance above limit' do
      expect { subject.top_up(1) }.to raise_error "You cannot top up beyond the limit of £#{subject.limit}"
    end
    it 'should change in_journey to true when touch_in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it 'should remember the entry station' do
      subject.touch_in(station)
      expect(subject.journey_entry).to eq(station)
    end
    it 'should forget the entry station on touch_out' do
    subject.touch_in(station)
    subject.touch_out
    expect(subject.journey_entry).to be_nil
    
    end
  end
  
end
