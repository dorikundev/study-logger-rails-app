class CreateStudySessions < ActiveRecord::Migration[7.1]
  def change
    create_table :study_sessions do |t|
      t.date :date
      t.integer :duration
      t.text :notes
      t.references :study_subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
