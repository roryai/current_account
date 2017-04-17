require_relative 'record.rb'

class Account
  attr_reader :balance, :record

  def initialize
    @balance = 0
    @record = Record.new
  end

  def deposit(amount)
    @balance += amount
    @record.transaction_history << {type: 'Deposit', amount: amount, time: Time.new.strftime("%F %T"), balance: @balance}
  end

  def withdraw(amount)
    @balance -= amount
    @record.transaction_history << {type: 'Withdrawal', amount: amount, time: Time.new.strftime("%F %T"), balance: @balance}
  end

  def transfer(amount, account)
    @record.payees << account.to_s
    @balance -= amount
    # this gives accounts too much visibility and control of each other. Transfers would ideally be carried out by a Bank class, rather than directly between the accounts.
    account.deposit(amount)
    @record.transaction_history << {type: 'Transfer', amount: amount, payee: account.to_s, time: Time.new.strftime("%F %T"), balance: @balance}
  end

  def display_balance
    "Your balance is £#{@balance}."
  end


end
