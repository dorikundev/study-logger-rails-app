class StudySubject < ApplicationRecord
    has_many :study_sessions

    validates :name, presence: true, uniqueness: true
    validates :color, presence: true
end
