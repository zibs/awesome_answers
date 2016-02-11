class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      # the t.references :question will generate an integer field that is called: question_id (rails convention) and also adds an index and a foreign key for us.
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
