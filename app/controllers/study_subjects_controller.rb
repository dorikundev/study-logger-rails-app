class StudySubjectsController < ApplicationController
    before_action :set_study_subject, only: [:show, :edit, :update, :destroy]
  
    def index
      @study_subjects = StudySubject.all
      @study_subject = StudySubject.new
    end
  
    def show
    end
  
    def new
      @study_subject = StudySubject.new
    end
  
    def create
      @study_subject = StudySubject.new(study_subject_params)
  
      if @study_subject.save
        redirect_to study_subjects_path
      else
        @study_subjects = StudySubject.all
        render :index
      end
    end
  
    def edit
        @study_subject = StudySubject.find(params[:id])
        @study_subjects = StudySubject.all 
      
    end
  
    def update
      if @study_subject.update(study_subject_params)
        redirect_to study_subjects_path
      else
        render :edit
      end
    end
  
    def destroy
    end
  
    private
  
    def set_study_subject
      @study_subject = StudySubject.find(params[:id])
    end
  
    def study_subject_params
      params.require(:study_subject).permit(:name, :color)
    end
  end