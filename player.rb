class Player
  attr_accessor :name, :value, :salary

  def initialize(opts)
    @name = opts.fetch(:name)
    @value = opts.fetch(:value)
    @salary = opts.fetch(:salary)
  end

  def self.randomly_generated_player
    salary = rand(8000..20000).to_i
    rating = rand(35..95).to_i
    name = "Random Player - #{salary}"
    opts = { name: name, salary: salary, value: rating }
    new(opts)
  end
end
