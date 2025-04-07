class CreateStudySubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :study_subjects do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
