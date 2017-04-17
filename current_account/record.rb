class Record
  attr_reader :payees, :transaction_history, :statement


  def initialize
    @transaction_history = []
    @payees = []
    @formatted_rows = []
    @statement_header = "Transaction type |  Amount  |         Date          |  Balance"
  end

  def print_statement
    generate_statement
    puts @statement_header
    puts @formatted_rows
  end

  def print_payees
    puts @payees
  end

  private

  def generate_statement
    @transaction_history.each do |transaction|
      @formatted_rows << statement_row_formatter(transaction) if transaction[:type] == 'Deposit' || transaction[:type] == 'Withdrawal'
      @formatted_rows << statement_row_formatter(transaction) + "\nTransferred to #{transaction[:payee]}" if transaction[:type] == 'Transfer'
    end
  end

  def statement_row_formatter(transaction)
    "#{transaction[:type]}" + transaction_type_spacer(transaction) + "|  £#{transaction[:amount]}" + amount_spacer(transaction) + "|  #{transaction[:time]}  |  £#{transaction[:balance]}"
  end

  def amount_spacer(transaction)
    (" " * (7 - transaction[:amount].to_s.length))
  end

  def transaction_type_spacer(transaction)
    (" " * (17 - transaction[:type].length))
  end


end
