class CreateBookChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :book_chapters do |t|
      t.references :book, null: false, foreign_key: true
      t.references :chapter, null: false, foreign_key: true
      t.integer :order, null: false

      t.timestamps
    end
  end
end
