class Player
  @@id = 1
  attr_accessor :name, :value, :salary

  def initialize(opts)
    @name = opts.fetch(:name)
    @value = opts.fetch(:value)
    @salary = opts.fetch(:salary)
    @@id += 1
  end

  # FactoryGirl requires an object ID, so we create and reference a
  # non-persisted ID that increments each time we create a new class.
  def id
    @@id
  end

  def self.randomly_generated_player
    salary = rand(9000..20000).to_i
    rating = rand(35..95).to_i
    name = "Random Player - #{salary}"
    opts = { name: name, salary: salary, value: rating }
    new(opts)
  end

  def self.create_players(arr)
    arr.map do |player|
      name = opts.fetch(:name, nil)
      value = opts.fetch(:value, nil)
      salary = opts.fetch(:salary, nil)
      skip if [name, value, salary].map(&:nil?).includes?(true)
      new(name: name, value: value, salary: salary)
    end
  end
end
