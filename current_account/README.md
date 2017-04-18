# Current Account

This program simulates some functions of a current account.

To run the program, download the repo and in your terminal navigate into the directory containing 'run_me.rb'. Then run the following command:

`ruby run_me.rb`

An interactive menu will appear that allows you to perform various functions (listed below) with your account. The transfer method is currently not working via the interactive menu (please see design notes for further info).

To run the tests, make sure you have the rspec gem installed and run `rspec` in the project directory. If you have bundler installed then run `bundle install`in the project directory to install rspec.

The account functionality allows for: deposits, withdrawals, transfers to other accounts, a printed balance, to see saved payees, and to see a formatted statement.

Please see the [user stories](https://github.com/roryai/current_account/blob/master/current_account/user_stories.md) used to drive the development, the [tests](https://github.com/roryai/current_account/tree/master/current_account/spec) and the [design notes](https://github.com/roryai/current_account/blob/master/current_account/design_notes.md) for details on a couple of design decisions encountered whilst writing this.
