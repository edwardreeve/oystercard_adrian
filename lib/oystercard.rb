class Oystercard
  attr_reader :balance, :limit

  LIMIT = 90
  TOP_UP_ERROR = "You cannot top up beyond the limit of £#{LIMIT}"
  def initialize(balance = 0)
    @balance = balance
    @limit = LIMIT
  end

  def top_up(amount)
    fail TOP_UP_ERROR if @balance + amount > @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
