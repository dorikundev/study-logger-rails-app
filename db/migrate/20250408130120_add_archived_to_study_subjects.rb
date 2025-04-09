class AddArchivedToStudySubjects < ActiveRecord::Migration[7.1]
  def change
    add_column :study_subjects, :archived, :boolean, default: false, null: false
  end
end
