require_relative 'interface.rb'

account1 = Account.new
account2 = Account.new
account3 = Account.new

account1.record.payees << account2.object_id
account1.record.payees << account3.object_id

interface = Interface.new(account1)
interface.menu
