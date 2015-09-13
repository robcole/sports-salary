class Roster
  attr_accessor :players

  def initialize(**opts)
    @players = opts.fetch(:players, [])
  end

  def players
    @players
  end

  def add_player(player)
    @players.push(player)
  end

  def self.generate_with_random_players(num)
    roster = new
    random_player = -> { Player.randomly_generated_player }
    num.times { roster.add_player(random_player.call) }
    roster
  end
end
