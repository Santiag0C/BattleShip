require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def test_does_it_exsist
    game = Game.new()

    assert_instance_of Game, game
  end

end
