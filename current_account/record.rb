class Record
  attr_reader :payees, :transaction_history, :statement


  def initialize
    @transaction_history = []
    @payees = []
    @formatted_rows = []
  end

  def print_statement
    generate_statement
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
    "#{transaction[:type]}     |  £#{transaction[:amount]}  |  #{transaction[:time]}  |  £#{transaction[:balance]}"
  end

end
