require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'terminal.rb'

class BlackJack
  def initialize
    term = TerminalInterface.new
    name = term.input_name
    game = Game.new(name)
    term.game = game
    loop do
      term.start_game
      break unless term.continue_game
    end
  rescue StandardError => e
    term.show_error(e)
  end
end

BlackJack.new
