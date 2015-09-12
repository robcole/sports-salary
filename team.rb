require_relative 'player'
require_relative 'roster'
require_relative 'player_selector'

class Team
  attr_accessor :roster, :salary_cap, :max_players

  def initialize(**opts)
    @salary_cap = opts.fetch(:salary_cap, 50000)
    @max_players = opts.fetch(:max_players, 5)
    @roster = Roster.generate_with_random_players(150)
    @players = []
  end

  def add_player(player)
    remaining_players > 0 ? @players.push(player) : @players
  end

  def players
    @players
  end

  def salary_paid
    players.map(&:salary).inject(&:+).to_i
  end

  def total_value
    players.map(&:value).inject(&:+).to_i
  end

  def cap_space
    salary_cap - salary_paid
  end

  def remaining_players
    max_players - players.size
  end

  def add_best_player
    players = PlayerSelector.new(roster: roster, team: self)
    bpa = players.with_salary_below(cap_space).not_on_team.best
    bpa.nil? ? players :
  end

  def self.generate_with_random_lineup
    roster = Roster.generate_with_random_players(150)
    team = new(salary_cap: 50000, max_players: 5)
    roster.find_random_players_for(team, 5).each do |player|
      team.add_player(player)
    end
    team
  end
end
