class PlayerSelector
  attr_accessor :roster, :players, :team
  alias_method :id, :object_id

  def initialize(**opts)
    @roster = opts.fetch(:roster)
    @team = opts.fetch(:team, nil)
    @players = sort_players(@roster.players)
  end

  def sort_players(players)
    players.sort do |p1, p2|
      [p2.value, p1.salary] <=> [p1.value, p2.salary]
    end
  end

  def find_random_players_for(team, player_amount = 1)
    @players.reject do |player|
      team.players.include?(player)
    end.sample(player_amount)
  end

  def with_value_above(value)
    @players = players.select { |player| player.value > value }
    self
  end

  def with_salary_below(price)
    @players = players.select { |player| player.salary < price }
    self
  end

  def not_on_team
    @players = players.reject { |player| team.players.include?(player) }
    self
  end

  def players_by_salary
    @players.sort_by(&:salary).reverse
  end

  def best_player
    @players.first
  end
end
