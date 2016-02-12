class AddIndexesToQuestions < ActiveRecord::Migration
  def change
    # this will add an index (not unique) to the questions table and the title column
    add_index :questions, :title
    add_index :questions, :body

    # This would create a unique index
    # add_index :questions, :body, unique: true

    # To create composite index we can:
    # add_index :questions, [:title, :body]
  end
end
