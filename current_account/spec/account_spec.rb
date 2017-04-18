require_relative '../account.rb'

describe Account do
  subject(:account) {described_class.new}
  subject(:account2) {described_class.new}

  before :each do
    account.deposit(10)
  end

    it 'has a balance' do
      expect(account.balance).to be 10
    end

    it 'can receive a deposit' do
      account.deposit(10)
      expect(account.balance).to be 20
    end

    it 'can process a withdrawal' do
      account.withdraw(8)
      expect(account.balance).to be 2
    end

    it 'can display balance' do
      expect(account.display_balance).to eq "\nYour balance is £10.\n"
    end

    it 'accounts can make and receive payments to/from other accounts' do
      account.transfer(6, account2)
      expect(account.balance).to be 4
      expect(account2.balance).to be 6
    end

end
