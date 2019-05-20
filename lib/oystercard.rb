class Oystercard
  attr_reader :balance, :limit

  LIMIT = 90
  MINIMUM_FARE = 1
  TOP_UP_ERROR = "You cannot top up beyond the limit of £#{LIMIT}".freeze
  INSUFFICIENT_BALANCE_ERROR = 'Insufficient balance to travel'.freeze

  def initialize(balance = 0)
    @balance = balance
    @limit = LIMIT
    @in_journey = false
  end

  def top_up(amount)
    raise TOP_UP_ERROR if @balance + amount > @limit

    @balance += amount
  end

  def touch_in
    raise INSUFFICIENT_BALANCE_ERROR if @balance < MINIMUM_FARE

    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
