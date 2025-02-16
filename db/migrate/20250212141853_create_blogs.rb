class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs do |t|
      t.string :slug, null: false, index: {unique: true}
      t.string :content
      t.string :author

      t.timestamps
    end
  end
end
