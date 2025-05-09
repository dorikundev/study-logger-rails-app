class StudySubject < ApplicationRecord
    # 科目が削除された場合、関連する学習記録も削除
    has_many :study_sessions, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :color, presence: true

    # アクティブ科目を取得
    scope :active, -> { where(archived: false) }
    # アーカイブ科目を取得
    scope :archived, -> { where(archived: true) }
    
    # 科目の総学習時間を計算
    def total_duration_in_minutes
      study_sessions.sum(:duration)
    end

    # 時間単位部分を計算
    def total_hours
      total_duration_in_minutes / 60
    end
    
    # 時間単位部分を計算
    def total_minutes
      total_duration_in_minutes % 60
    end
end
