require_relative 'account.rb'

class Interface

  def initialize(account)
    @account = account
  end

  def menu
    puts "\nHello, welcome to Example Bank.\n\nWhat would you like to do today?\n
    Type 'deposit' and 'enter' to deposit funds into your account.
    Type 'withdraw' and 'enter' to withdraw funds from your account.
    Type 'transfer' and 'enter' to transfer money to another account.
    Type 'balance' and 'enter' to display your balance.
    Type 'statement' and 'enter' to print a statement.
    Type 'payees' and 'enter' to see a list of your payees.\n"
    input = gets.chomp
    case input
    when 'deposit'
      deposit_handler
      menu
    when 'withdraw'
      withdrawal_handler
      menu
    when 'transfer'
      transfer_handler
      menu
    when 'balance'
      puts @account.display_balance
      menu
    when 'statement'
      @account.record.print_statement
      menu
    when 'payees'
      @account.record.print_payees
      menu
    else
      puts "\nPlease enter a valid command.\n"
      menu
    end

  end

  def deposit_handler
    puts "\nHow much would you like to deposit in your account?\n"
    amount_input = gets.chomp.to_i
      if amount_input.is_a? Integer
        @account.deposit(amount_input)
      else
        puts "\nPlease enter a number.\n"
        deposit_handler
      end
  end

  def withdrawal_handler
    puts "\nHow much would you like to withdraw from your account?\n"
    amount_input = gets.chomp.to_i
      if amount_input.is_a? Integer
        @account.withdraw(amount_input)
      else
        puts "\nPlease enter a number.\n"
        withdrawal_handler
      end
  end

  def transfer_handler
    puts "\nHow much would you like to transfer today?\n"
    amount_input = gets.chomp.to_i
      if amount_input.is_a? Integer
        @account.withdraw(amount_input)
      else
        puts "\nPlease enter a number.\n"
        transfer_handler
      end
      puts "\nWho would you like to transfer #{amount_input.to_s} to?\n"
        display_payees
        # needs to check if input is valid Integer
        payee_input = gets.chomp
        payee_input_checker(amount_input, payee_input.to_i)
  end

  def display_payees
    counter = 1
    @account.record.payees.each do |payee|
      puts "\n#{counter.to_s}. #{payee.to_s}"
      counter = counter + 1
    end
  end

  def payee_input_checker(amount_input, payee_input)
    if payee_input <= @account.record.payees.length
      payee_handler(amount_input, payee_input)
    else
      puts "\nPlease enter a valid number.\n"
      payee_input_checker(amount_input, payee_input)
    end
  end

  def payee_handler(amount_input, payee_input)
    account = account_selector(payee_input)
    @account.transfer(amount_input, account)
  end

  def account_selector(payee_input)
    x = payee_input - 1
    # this doesn't work as expected: the array returned is empty
    get_by_object_id(x)
  end

# this returns an array of symbols of variable names matching the given object id
  def get_by_object_id(x)
    local_variables.select do |e|
      binding.local_variable_get(e).object_id == @account.record.payees[x]
    end
  end

end
