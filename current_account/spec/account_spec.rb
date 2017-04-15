require_relative '../account.rb'

describe Account do
  subject(:account) {described_class.new}

  before :each do
    account.deposit(10)
  end

  acc2 = Account.new


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
      expect(account.display_balance).to eq "Your balance is £10."
    end

    it 'can make a payment to another account' do
      account.transfer(6, acc2)
      expect(account.balance).to be 4
      expect(acc2.balance).to be 6
    end
end
