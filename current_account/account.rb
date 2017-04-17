class Account
  attr_reader :balance, :payees, :transaction_history

  def initialize
    @balance = 0
    @payees = []
    @transaction_history = []
  end

  def deposit(amount)
    @balance += amount
    @transaction_history << {type: 'Deposit', amount: amount, time: Time.new.strftime("%F %T")}
  end

  def withdraw(amount)
    @balance -= amount
    @transaction_history << {type: 'Withdrawal', amount: amount, time: Time.new.strftime("%F %T")}
  end

  def display_balance
    "Your balance is £#{@balance}."
  end

  def transfer(amount, account)
    @payees << account.to_s
    @balance -= amount
    # this gives accounts too much visibility and control of each other. Transfers would ideally be carried out by a Bank class, rather than directly between the accounts.
    account.deposit(amount)
    @transaction_history << {type: 'Transfer', amount: amount, payee: account.to_s, time: Time.new.strftime("%F %T")}
  end

  def print_payees
    print @payees
  end

  def generate_statement
    @transaction_history.each do |transaction|
      if transaction[:type] == 'Deposit'
        deposit_formatter(transaction)
      elsif transaction[:type] == 'Withdrawal'
        withdrawal_formatter(transaction)
      elsif transaction[:type] == 'Transfer'
        transfer_formatter(transaction)
      end
    end
  end



  def deposit_formatter(transaction)
    p 'deposit'
  end

  def withdrawal_formatter(transaction)

  end

  def transaction_formatter(transaction)
    p 'transaction'
  end

end
