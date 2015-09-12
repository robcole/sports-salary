class Roster
  attr_accessor :players

  def initialize(**opts)
    @players = []
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

  def min_salary_required(num)
    players = PlayerSelector.new(roster: self).players_by_salary.last(num)
    players.map(&:salary).inject(&:+)
  end
end
