## Design notes

#### Transferring funds

The Account.transfer method gives too much power of one account class over another: it allows accounts to call each other's deposit methods. In a larger program this function would be carried out by the Bank class.

#### Testing @transaction_history

Whilst testing the @transfer_history array I encountered a problem: the time in the expected string does not have double quotes surrounding it, whilst the received string does.

At the time this test was written, the transaction was stored like this:

`[{transfer: amount}, {payee: account.to_s}, {time: Time.new.strftime("%F %T")}]`

This is the test:

`it 'keeps a record of payments' do`

  `account.transfer(9, account2)`

  `expect(account.transaction_history).to eq "[[{:deposit=>10}, {:time=>#{Time.new.strftime("%F %T")}}],`

   `[{:transfer=>9}, {:payee=>\"#<Account:0x007fa0bb057b30>\"}, {:time=>#{Time.new.strftime("%F %T")}}]]"`

`end`

This is the output from rspec:

`expected: "[[{:deposit=>10}, {:time=>2017-04-17 10:04:12}], [{:transfer=>9},`

`{:payee=>\"#<Account:0x007fa0bb057b30>\"}, {:time=>2017-04-17 10:04:12}]]"`


`got: [[{:deposit=>10}, {:time=>"2017-04-17 10:04:12"}], [{:transfer=>9},`

`{:payee=>"#<Account:0x007ff8df045198>"}, {:time=>"2017-04-17 10:04:12"}]]`


The time was listed in both the Account.transfer method and the rspec tests as `Time.new.strftime("%F %T")`. In the rspec test I used string interpolation to insert the time at which the test was run into the string the matcher was testing against the @transfer_history array, which resulted in the lack of double quotes. In the @transfer_history array the time is stored as a string, which is then interpolated into the string created by rspec.

Note: I was aware that comparing the time in the array to the time generated when the tests ran was flawed and made the tests brittle.

My next attempt was to read the time directly from the array and interpolate it into the string expected by rspec. This resulted in more formatting issues and isn't an effective test. In the end I decided on the unit test below, which reads the deposit and transfer amounts only. This is not perfect but it is an improvement on the above test.

`it 'keeps a record of payments' do`

  `account.transfer(9, account2)``

  `expect(account.transaction_history[0][0][:deposit]).to eq 10`

  `expect(account.transaction_history[1][0][:transfer]).to eq 9`

`end`

The best test for this aspect of the program would be a feature test of the output of the transaction history as seen by the user (this method has not yet been built), rather than a unit test of the array contents.

#### Payee selector

I wanted to be able to keep a list of payees (instances of the Account class) in an array using the string representation of the Account, rather than storing the Account itself in the array, as this is a bad design practice.

My intention was to take the string representation of the account class, use that to obtain

#### Refactoring Interface methods

In the withdrawal_handler, deposit_handler and transfer_handler methods there is a fair amount of repetition with some if/else statements. Because each method calls itself at the end of the else statement I didn't have time to DRY this code by storing the if/else in a separate method and making it call the method that called it at the end of the else statement using the code below:

`caller_locations(1,1)[0].label`

#### Interface transfer method

The get_object_by_id method doesn't work currently. I suspect it's a scope issue with local_variables not being able to see account2 or account3. Would like to discuss further at interview.


#### Further features

Calculate interest- this would be calculated on the closing balance each day and deducted from the closing balance at the end of the month.

Standing order- allows the user to set up a fixed payment to take place on a certain day of each month

Include Bank class that would take over transaction between accounts, and possibly withdraw and deposit methods also.
