# :ship: :boom: Battleship :boom: :ship:

The objective of this task is to build a battleship game for two players in Ruby in a terminal. Please read all the instructions before you start.

:warning: You should not require any gems aside from ones to help you write any tests (rspec, minitest...). :warning:

## Assumptions

* Each player will look away from the screen when the other player is placing their ships. You don't need to consider privacy.
* One grid per player.

## Objectives

* We prefer a working game with some rough edges to an unfinished masterpiece.
* Your code should be tested by automated tests as much as possible.
* Quality matters. Focus on separation of responsibilities, readability, and modularity.
* Explain how to run your game (and the tests) in a README.md file in the root of your project.
* Software is never really finished. Think about how you'd evolve the codebase if you had unlimited time.

## 1st step - Board setup

The game is played on 5x5 grids. Your first task is to set the game up:

* Players have 2 ships each to place on their grid. A small ship (3x1 size) and large one (4x1 size)
* Players are asked in turn to place their ships on their board (ie: interactively)
* A ship can't be placed out of bounds nor on the same space as another ship.

## 2nd step - Gameplay setup

Once all the ships are placed the game begins! Now you have to set the gameplay mechanisms up:

* Players take turns to shoot at the opponent grid one after the other by selecting coordinates.
* Each shot receives a Hit, Miss or Sink response.
* The winner is the player who sinks all of their opponent's ships first

## 3rd step - Gameplay improvements

At this point the game works and we'd like some improvements of some of its mechanisms:

* Starting player is determined at random.
* If a shot attempt is made out of bounds the game offers a retry.
* When the game is finished it gives the option to play again.

## 4th step - Bonus

This part is here to spice things up! :boom: We'd like to have these features added to the game:

* Ships can now be placed diagonally.
* If a player misses a shot 3 times in a row the game gives a hint of a valid shot.
* The game now works in a "Best of 3" match mode:

> If player 1 wins the first game, the match is not over yet because player 2 can still win the 2 other games and win the match.

> If player 1 wins first 2 consecutive games, then the other player can possibly win 1 game maximum, which is not sufficient to beat the 2 games won by player 1.

> If each player won 1 of the first 2 games then the third game is played. Whoever wins the third game is declared winner of the match.
