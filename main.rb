require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'terminal.rb'

class BlackJack
  def initialize
    term = TerminalInterface.new
    name = term.input_name
    loop do
      game = Game.new(name)
      term.game = game
      term.start_game
      break if term.break_game
    end
  rescue StandardError => e
    term.show_error(e)
  end
end

BlackJack.new
