class LcClass < ApplicationRecord
	belongs_to :lc_comp, foreign_key: 'lc_comp_id'
	has_many :lc_result, dependent: :destroy
	
	validates :class_name, presence: true
end
