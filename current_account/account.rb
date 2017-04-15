class Account
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end

  def display_balance
    "Your balance is £#{@balance}."
  end

  def transfer(amount, account)
    self.withdraw(amount)
    account.deposit(amount)
  end

end
