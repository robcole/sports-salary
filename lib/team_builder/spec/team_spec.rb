require 'spec_helper'

describe Team do
  describe ".optimal_team_for_roster" do
    context "when the roster is intentionally bottom-heavy" do
      let(:roster) { build_stubbed :roster, :bottom_heavy }
      let(:player) { build_stubbed :player }
      let(:team)   { Team.optimal_team_for_roster(roster: roster) }

      it "should construct the correct roster" do
        expect(team.total_value).to eq 99*5
      end
    end

    context "when the roster is normalized" do
    end
  end
end
