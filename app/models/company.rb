class Company < ActiveRecord::Base
  include Contact
  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
