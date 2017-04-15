class Account
  attr_reader :balance, :payees

  def initialize
    @balance = 0
    @payees = []
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
    @payees << account.to_s
    withdraw(amount)
    account.deposit(amount)
  end

  def print_payees

    print @payees
  end


end
