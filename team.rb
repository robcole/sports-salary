require_relative 'player'
require_relative 'roster'
require_relative 'player_selector'

class Team
  attr_accessor :roster, :salary_cap, :max_players

  def initialize(**opts)
    @salary_cap = opts.fetch(:salary_cap)
    @max_players = opts.fetch(:max_players)
    @roster = opts.fetch(:roster)
    @players = []
  end

  def self.optimal_team_for_roster(**opts)
    salary_cap = opts.fetch(:salary_cap, 50000)
    max_players = opts.fetch(:max_players, 5)
    default_roster = Roster.generate_with_random_players(150)
    roster = opts.fetch(:roster, default_roster)
    team = new(salary_cap: salary_cap, max_players: max_players, roster: roster)
    team.add_best_players(max_players)
  end

  def add_best_players(num)
    num.times { add_best_player }
    self
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

  def required_capspace
    [cap_space, min_salary_required(players_after_selection)].min
  end

  def cap_space
    salary_cap - salary_paid
  end

  def remaining_players
    max_players - players.size
  end

  def players_after_selection
    remaining = remaining_players - 1
    remaining >= 0 ? remaining : 0
  end

  def best_player_available
    player_list = PlayerSelector.new(roster: roster, team: self)
    player_list.with_salary_below(required_capspace).not_on_team.best_player
  end

  def add_best_player
    bpa = best_player_available
    bpa.nil? ? players : players.push(bpa)
  end

  # Prevent selecting players that won't leave enough cap space to field
  # a full team.
  def min_salary_required(num)
    players = PlayerSelector.
                new(roster: roster, team: self).
                not_on_team.
                players_by_salary.
                last(num)
    salary = cap_space - players.map(&:salary).inject(&:+).to_i
    players_after_selection == 0 ? cap_space : salary
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
