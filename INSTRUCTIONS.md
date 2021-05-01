# Instructions for Stuart Battleship Code Challenge

## Abrahan Mendoza

The purpose of this document is to describe how to run the Ruby script approach based in the requirements located in the README.md file.

### Instructions 📄

#### Requirements ⚙️

1. ```Unix based OS```

2. ```ruby >= 2.6.1```

3. ```Bundler version 2.2.16```

#### Steps 🌀

1. Run ```git clone https://github.com/StuartHiring/ruby-test-abrahan92.git``` to get the project locally.

2. Run ```cd ruby-test-abrahan92``` to go on the project root.

3. Run ```git fetch origin battle_ship_game && git checkout battle_ship_game``` to go on the branch requested.

4. Run ```bundle install```  To install the required gems.

#### Run Rspec Tests manually 🔥

  * Run ```bundle exec rspec spec/battleship``` -> For this test we have 24 example scenarios

For the above command you need to have ruby installed on your local machine.

It may be that the bundle version on your local machine is different from the one in this project and a warning is displayed, if so, use this command to update it 
before running the spec task. `bundle update --bundler`

#### Run the script with ruby manually 💥

  * Run ```bundle install``` -> To install the required gems

  * Run ```bundle exec bin/battleship``` -> Keep in mind you must have ruby installed

For the above command you need to have ruby installed on your local machine.

### Description 📋

This project tries to simulate a battleship game with 2 players.
I tried to keep in mind all these things to do a real case for this simple example, but more things can be improved.

The project structure has the follow topics:

* Used classes `[Game, Board, Player, Ship, Cell]` are in lib folder `lib/battleship`.
* `bin` with the exec file to play.
* `spec` with some unit tests for all classes.
* `.rubocop.yml` with clean code and best practices rules.
* `.rspec` to require the rspec helper.
* `Gemfile` inject gemspec file with the gems descriptions.
* `battleship.gemspec` with the used gems for build the tests and colorize the cli strings
* `README.md` has the test rules and instructions.

### Notes 🚩️

I have created the entities that I found relevant to the solution. Game scalability has been contemplated 
in some of them for future improvements.

### Improvements ✈️

* Allow ships to be placed diagonally.
* Create a entity to handle messages with logs.
* Build extra corner cases for other scenarios.
* Refactor and clean some code in game.rb and board.rb class.
* Allow graphical display of game boards.
* Create a metric board for the best of 3 mode with the number of missed, successful and off-board shots
  for each player throughout the round.

### Gems used 💎

* `bundler` To install the exact gems and versions that are needed.
* `colorize` To add beauty color to cli strings.
* `rspec` To build the unit tests.
* `rubocop` To analyze and format code with best practices.
* `rubocop-rspec` To analyze and format specs files.
