class CreateBookLists < ActiveRecord::Migration[6.0]
  def change
    create_table :book_lists, id: :uuid do |t|
      t.references :user, type: :uuid, null: false
      t.string :file, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
