class HomeController < ApplicationController
  # ヒートマップ用に学習時間レベルを定義
  HEAT_LEVELS = [
      { min: 0, max: 0, level: 0 },      # 学習なし
      { min: 1, max: 30, level: 1 },     # 少し学習
      { min: 31, max: 60, level: 2 },    # 中程度学習
      { min: 61, max: 120, level: 3 },   # 多く学習
      { min: 121, max: Float::INFINITY, level: 4 }  # 最大レベル
    ]

  def index
    @study_sessions = StudySession.order(date: :desc).limit(5)
    @study_session = StudySession.new
    @study_subjects = StudySubject.all
    
    # 現在の年月を取得
    @year = params[:year].present? ? params[:year].to_i : Date.current.year
    @month = params[:month].present? ? params[:month].to_i : Date.current.month

    # 前月と翌月の日付を計算
    current_date = Date.new(@year, @month, 1)
    @previous_month = current_date - 1.month
    @next_month = current_date + 1.month
    
    
    # カレンダーデータを取得
    @calendar_days = get_calendar_data(@year, @month)
    
    # 日付ごとの学習データを取得
    @daily_data = get_daily_data(@calendar_days)
  end
  
  private

  # カレンダーの日付を取得
  def get_calendar_data(year, month)
    # 初日と最終日の日付を取得
    first_day = Date.new(year, month, 1)
    last_day = Date.new(year, month, -1)

    # 週の開始日と最終日を表示する為、前後日曜日の日付を取得
    start_date = first_day.beginning_of_week(:sunday)
    end_date = last_day.end_of_week(:sunday)

    # カレンダー表示の為に範囲を配列に変換
    (start_date..end_date).to_a
  end

  def get_daily_data(calendar_days)
    # カレンダーの表示期間の開始日と終了日
    start_date = calendar_days.first
    end_date = calendar_days.last

    # 期間内の学習セッションを取得
    sessions = if defined?(current_user) && current_user
                 current_user.study_sessions.where(date: start_date..end_date)
              # ログインがない場合は全ての学習セッションを取得(本番環境では削除)
               else
                 StudySession.where(date: start_date..end_date)
               end

    # 日付ごとのデータを格納
    daily_data = {}

    sessions.each do |session|
      # 日付を文字列に変換
      date_str = session.date.to_s
      subject_id = session.study_subject_id.to_s        

      # データがない場合は初期値を設定
      daily_data[date_str] ||= { minutes: 0, subjects: {} }

      # 学習時間を合計
      daily_data[date_str][:minutes] += session.duration
      
      # 科目ごとの情報も記録
      daily_data[date_str][:subjects][subject_id] ||= 0
      daily_data[date_str][:subjects][subject_id] += session.duration
    end
    
    # ヒートマップレベルを計算
    daily_data.each do |date, data|
      data[:heat_level] = calculate_heat_level(data[:minutes])
    end
    
    daily_data
  end
  
  # ヒートマップのレベルを計算
  def calculate_heat_level(minutes)
      HEAT_LEVELS.find { |range| range[:min] <= minutes && minutes <= range[:max] }[:level]
  end
end