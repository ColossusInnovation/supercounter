class Counter
  include Mongoid::Document
  field :name, type: String
  field :count, type: Integer, default: 0

  validates :name, presence: true
  validates :count, presence: true

  def increment
    self.count += 1
  end

  def increment!
    increment
    save
  end
end
