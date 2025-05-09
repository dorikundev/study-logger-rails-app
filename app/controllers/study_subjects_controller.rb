class StudySubjectsController < ApplicationController
  before_action :set_study_subject, only: [:show, :edit, :update, :destroy, :archive, :unarchive]
  
  # 科目一覧を表示
  def index
    # モデルで定義したスコープを使用して取得
    @active_subjects = StudySubject.active
    @archived_subjects = StudySubject.archived
    @study_subject = StudySubject.new
  end
  
  # 科目詳細表示
  def show
    # @study_subjectはbefore_actionで設定済み
  end
  
  # 新規科目作成フォーム
  def new
    @study_subject = StudySubject.new
  end
  
  # 科目作成
  def create
    @study_subject = StudySubject.new(study_subject_params)
    
    if @study_subject.save
      redirect_to study_subjects_path, notice: '科目が作成されました'
    else
      # ここでrenderする際に@study_subjectのエラー情報が保持されていることを確認
      render :new, status: :unprocessable_entity
    end
  end
  
  # 科目編集フォーム
  def edit
    # @study_subjectはbefore_actionで設定済み
  end
  
  # 科目更新
  def update
    if @study_subject.update(study_subject_params)
      redirect_to study_subject_path(@study_subject), notice: "#{@study_subject.name}を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # 科目削除
  def destroy
    subject_name = @study_subject.name
    @study_subject.destroy
    redirect_to study_subjects_path, notice: "#{subject_name}を削除しました"
  end

  # 科目をアーカイブ
  def archive
    @study_subject.update(archived: true)
    redirect_to study_subject_path(@study_subject), notice: "#{@study_subject.name}をアーカイブしました"
  end

  # 科目のアーカイブを解除
  def unarchive
    @study_subject.update(archived: false)
    redirect_to study_subject_path(@study_subject), notice: "#{@study_subject.name}のアーカイブを解除しました"
  end
  
  private
  
  # パラメータから科目を取得するヘルパーメソッド
  def set_study_subject
    @study_subject = StudySubject.find(params[:id])
  end
  
  # ストロングパラメータ
  def study_subject_params
    params.require(:study_subject).permit(:name, :color)
  end
end