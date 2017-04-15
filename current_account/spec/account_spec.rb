require_relative '../account.rb'

describe Account do
  subject(:account) {described_class.new}

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
end
