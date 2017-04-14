require_relative '../account.rb'

describe Account do
  subject(:account) {described_class.new}

  context 'balance' do

    it 'has a balance' do
      expect(account.balance).to be 0
    end

  end
end
