require_relative '../account.rb'

describe Account do
  subject(:account) {described_class.new}
  subject(:account2) {described_class.new}

  before :each do
    account.deposit(10)
  end

  it 'keeps a record of payees' do
    account.transfer(3, account2)
    expect(account.record.payees[0]).to eq account2.to_s
  end

  it 'displays a list of previous payees' do
    account.transfer(3, account2)
    expect{account.record.print_payees}.to output("#{account2.to_s}\n").to_stdout
  end

  # refactor this into multiple tests
  it 'keeps a record of payments' do
    account.transfer(9, account2)
    expect(account.record.transaction_history[1][:amount]).to eq 9
    expect(account.record.transaction_history[1][:type]).to eq 'Transfer'
  end

  it 'can output the transaction history in a readable format' do
        account.transfer(9, account2)
        expect{account.record.print_statement}.to output("Deposit     |  £10  |  #{Time.new.strftime("%F %T")}  |  £10\nTransfer     |  £9  |  #{Time.new.strftime("%F %T")}  |  £1\nTransferred to #{account2.to_s}\n").to_stdout
  end


end
