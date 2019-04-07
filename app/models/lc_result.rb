class LcResult < ApplicationRecord
	belongs_to :lc_class, foreign_key: 'lc_class_id'

	validates :name, presence: true
end
