class StudySession < ApplicationRecord
  belongs_to :study_subject

  validates :date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :study_subject_id, presence: true
end
