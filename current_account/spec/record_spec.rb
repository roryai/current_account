require_relative '../account.rb'

describe Account do
  subject(:account) {described_class.new}
  subject(:account2) {described_class.new}

  before :each do
    account.deposit(10)
  end

  context 'Record Tests' do
    it 'keeps a record of payees' do
      account.transfer(3, account2)
      expect(account.record.payees[0]).to eq account2.object_id
    end

    it 'displays a list of previous payees' do
      account.transfer(3, account2)
      expect{account.record.print_payees}.to output("#{account2.object_id}\n").to_stdout
    end

    # this has two matchers but as it is checking two results of the same method I decided to have it like this.
    it 'keeps a record of payments' do
      account.transfer(9, account2)
      expect(account.record.transaction_history[1][:amount]).to eq 9
      expect(account.record.transaction_history[1][:type]).to eq 'Transfer'
    end

    it 'can output the transaction history in a readable format' do
      account.transfer(9, account2)
      expect{account.record.print_statement}.to output("Transaction type |  Amount  |         Date          |  Balance\nDeposit          |  £10     |  #{Time.new.strftime("%F %T")}  |  £10\nTransfer         |  £9      |  #{Time.new.strftime("%F %T")}  |  £1\nTransferred to #{account2.object_id}\n").to_stdout
    end
  end

end
