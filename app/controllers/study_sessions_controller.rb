# app/controllers/study_sessions_controller.rb
class StudySessionsController < ApplicationController
  before_action :set_study_session, only: [:show, :edit, :update, :destroy]
  before_action :load_subjects, only: [:new, :create, :edit, :update]

  def index
    @study_sessions = StudySession.includes(:study_subject).order(date: :desc)
  end

  def show
  end

  def new
    @study_session = StudySession.new
    @study_session.date = Date.today
  end

  def create
    @study_session = StudySession.new(study_session_params)

    if @study_session.save
      redirect_to home_index_path
    else
      redirect_to home_index_path(study_session: study_session_params)
    end
  
  end

  def edit
  end

  def update
    @study_session = StudySession.find(params[:id])
    if @study_session.update(study_session_params)
      redirect_to @study_session, notice: '学習記録が更新されました。'
    else
      @study_subjects = StudySubject.all
      render :edit
    end
  end

  def destroy
    @study_session.destroy
    redirect_to study_sessions_path, notice: '学習記録を削除しました'
  end

  private

  def set_study_session
    @study_session = StudySession.find(params[:id])
  end

  def load_subjects
    @study_subjects = StudySubject.all.order(:name)
  end

  def study_session_params
    params.require(:study_session).permit(:date, :duration, :notes, :study_subject_id)
  end
end