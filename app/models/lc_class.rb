class LcClass < ApplicationRecord
	belongs_to :lc_comp, foreign_key: 'lc_comp_id'
	validates :class_name, presence: true
end
