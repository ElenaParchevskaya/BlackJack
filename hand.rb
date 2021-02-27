require_relative 'player.rb'

class Hand
  MAX_SCORE = 21
  MAX_CARDS = 3

  def max_cards?
    @hand.count == MAX_CARDS
  end

  def overscore?
    calc_hand > MAX_SCORE
  end

  def give_card(deck)
    @hand = []
    @hand << deck.take_card if !max_cards?
  end

  def clear_hand(type_default)
    @hand = []
    @type = @type_default
  end

  def calc_hand
    score = @hand.sum(&:cost)
    @hand.each do |card|
      score -= 10 if card.ace? && (score > MAX_SCORE)
    end
    score
  end

  def show_score
    @type == :showed ? calc_hand : '***'
  end
end
