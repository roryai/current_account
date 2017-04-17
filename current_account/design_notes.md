## Design notes

#### Testing @transaction_history

Whilst testing the @transfer_history array I encountered a problem: the time in the expected string does not have double quotes surrounding it, whilst the received string does.

At the time this test was written, the transaction was stored like this:

`[{transfer: amount}, {payee: account.to_s}, {time: Time.new.strftime("%F %T")}]`

This is the test:

`it 'keeps a record of payments' do
  account.transfer(9, account2)
  expect(account.transaction_history).to eq "[[{:deposit=>10}, {:time=>#{Time.new.strftime("%F %T")}}], [{:transfer=>9}, {:payee=>\"#<Account:0x007fa0bb057b30>\"}, {:time=>#{Time.new.strftime("%F %T")}}]]"
end`

This is the output from rspec:

`expected: "[[{:deposit=>10}, {:time=>2017-04-17 10:04:12}], [{:transfer=>9}, {:payee=>\"#<Account:0x007fa0bb057b30>\"}, {:time=>2017-04-17 10:04:12}]]"``


`got: [[{:deposit=>10}, {:time=>"2017-04-17 10:04:12"}], [{:transfer=>9}, {:payee=>"#<Account:0x007ff8df045198>"}, {:time=>"2017-04-17 10:04:12"}]]`


The time was listed in both the Account.transfer method and the rspec tests as `Time.new.strftime("%F %T")`. In the rspec test I used string interpolation to insert the time at which the test was run into the string the matcher was testing against the @transfer_history array, which resulted in the lack of double quotes. In the @transfer_history array the time is stored as a string, which is then interpolated into the string created by rspec.

Note: I was aware that comparing the time in the array to the time generated when the tests ran was flawed and made the tests brittle.

My next attempt was to read the time directly from the array and interpolate it into the string expected by rspec. This resulted in more formatting issues and isn't an effective test. In the end I decided on the unit test below, which reads the deposit and transfer amounts only. This is not perfect but it is an improvement on the above test.

`it 'keeps a record of payments' do`

  `account.transfer(9, account2)``

  `expect(account.transaction_history[0][0][:deposit]).to eq 10`

  `expect(account.transaction_history[1][0][:transfer]).to eq 9`

`end`

The best test for this aspect of the program would be a feature test of the output of the transaction history as seen by the user (this method has not yet been built), rather than a unit test of the array contents.

##Further features

Calculate interest- this would be calculated on the closing balance each day and deducted from the closing balance at the end of the month.
Include Bank class that would take over transaction between accounts, and possibly withdraw and deposit methods also.
Include interactive menu to allow people to use the program in the command line to add and withdraw funds, see their account etc.
