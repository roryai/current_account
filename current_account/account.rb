require_relative 'record.rb'

class Account
  attr_reader :balance
  attr_accessor :record

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
    @record.payees << account.object_id
    @balance -= amount
    account.deposit(amount)
    @record.transaction_history << {type: 'Transfer', amount: amount, payee: account.object_id, time: Time.new.strftime("%F %T"), balance: @balance}
  end

  def display_balance
    "\nYour balance is £#{@balance}.\n"
  end


end
