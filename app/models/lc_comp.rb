class LcComp < ApplicationRecord
	has_many :lc_classes, dependent: :destroy

	validates :id, :name, :date, :lc_link, presence: true
end
