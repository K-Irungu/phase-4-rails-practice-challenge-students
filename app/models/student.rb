class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    validates :age, numericality: { greater_tha_or_equal_to: 18 }
end
