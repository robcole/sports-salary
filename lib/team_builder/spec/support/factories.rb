# Normally we'd define factories (in a Rails project) in their own respective
# factories under spec/factories, but since we're using a standalone gem,
# declaring them all here and requiring the file works well for our uses.
FactoryGirl.define do
  factory :player do
    name { Faker::Name.name }
    salary { rand(9000..20000).to_i }
    value { rand(35..95).to_i }

    initialize_with { new(name: name, salary:salary, value: value) }
  end

  factory :roster do
    trait :bottom_heavy do
      SALARIES = [35000,10000,10000,10000,10000,10000,5000,5000,5000]
      RATINGS = [100, 99, 99, 99, 99, 99, 50, 50, 50]
      players do
        SALARIES.zip(RATINGS).map do |pair|
          FactoryGirl.build_stubbed :player, salary: pair[0], value: pair[1]
        end
      end
    end
  end

  factory :team do
    roster { FactoryGirl.build_stubbed :roster }
    salary_cap { 50000 }
    max_players { 5 }
    initialize_with { new(roster: roster,
                          salary_cap: salary_cap,
                          max_players: max_players) }
  end
end
