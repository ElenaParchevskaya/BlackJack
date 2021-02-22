class Game
  STAKE = 10

  attr_reader :bank, :master, :slave, :players

  def initialize(name)
    @slave = Player.new(name, :showed)
    @master = Player.new('Крупье', :hidden)
    @players = [@master, @slave]
  end

  def turn_new_init
    @deck = Deck.new
    @players.each(&:clear_hand)
    2.times do
      @players.each { |p| p.give_card @deck }
    end
    @bank = 0
    @players.each do |p|
      @bank += p.change_money -STAKE
    end
  end

  def turn_slave
    slave_add_card
  end

  def slave_add_card?
    !@slave.max_cards?
  end

  def turn_master
    if @master.calc_hand < 17 && !@master.max_cards?
      @master.give_card @deck
      true
    end
  end

  def turn_stop?
    max_cards? || master_overscore? || slave_overscore?
  end

  def change_master_view
    @master.type = :showed
  end

  def turn_end
    master_score = @master.calc_hand
    slave_score = @slave.calc_hand
    if master_score == slave_score
      @slave.change_money @bank / 2
      @master.change_money @bank / 2
      return nil
    elsif master_overscore? || (master_score < slave_score && !slave_overscore?)
      @slave.change_money @bank
      return @slave
    else
      @master.change_money @bank
      return @master
    end
    @bank = 0
  end

  def master_overscore?
    @master.overscore?
  end

  def slave_overscore?
    @slave.overscore?
  end

  private

  def slave_add_card
    @slave.give_card @deck
  end

  def max_cards?
    @slave.max_cards? && @master.max_cards?
  end
end
