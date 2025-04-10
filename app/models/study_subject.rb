class StudySubject < ApplicationRecord
    has_many :study_sessions, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :color, presence: true
end
