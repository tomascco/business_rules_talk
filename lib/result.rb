class Result
  attr_reader :type, :data
  delegate_missing_to :data

  def self.success(**data)
    new(:success, data)
  end

  def self.failure(**data)
    new(:failure, data)
  end

  def initialize(type, data)
    @type = type
    @data = data
  end

  def success?
    type == :success
  end

  def failure?
    !success?
  end
end
