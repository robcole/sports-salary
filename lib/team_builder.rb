require "team_builder/version"
require_relative "team_builder/team.rb"
require_relative "team_builder/player"
require_relative "team_builder/roster"
require_relative "team_builder/player_selector"

module TeamBuilder
  class Lineup
    attr_accessor :players, :teams

    def initialize(players: nil, salary_cap: 50000, max_players: 5)
      @players = players
      team_opts = { salary_cap: salary_cap,
                    max_players: max_players,
                    roster: roster }
      new_team = Team.optimal_team_for_roster(team_opts)
      @teams = Array.new(1, new_team)
    end

    def optimal_lineup
      teams.first.players
    end

    def players_for_roster
      @players = Player.create_players(@players) unless @players.nil?
      @players || default_players
    end

    def roster
      Roster.new(players: players_for_roster)
    end

    def default_players
      Roster.generate_with_random_players(150).players
    end
  end
end
