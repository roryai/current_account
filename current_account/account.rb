class Account
  attr_reader :balance, :payees, :transaction_history

  def initialize
    @balance = 0
    @payees = []
    @transaction_history = []
  end

  def deposit(amount)
    @balance += amount
    @transaction_history << [{deposit: amount}, {time: Time.new.strftime("%F %T")}]
  end

  def withdraw(amount)
    @balance -= amount
    @transaction_history << [{withdrawal: amount}, {time: Time.new.strftime("%F %T")}]
  end

  def display_balance
    "Your balance is £#{@balance}."
  end

  def transfer(amount, account)
    @payees << account.to_s
    @balance -= amount
    # this gives accounts too much visibility and control of each other. Transfers would ideally be carried out by a Bank class, rather than directly between the accounts.
    account.deposit(amount)
    @transaction_history << [{transfer: amount}, {payee: account.to_s}, {time: Time.new.strftime("%F %T")}]
  end

  def print_payees
    print @payees
  end


end
