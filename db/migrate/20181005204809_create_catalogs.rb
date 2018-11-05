class CreateCatalogs < ActiveRecord::Migration[5.2]
  def change
    create_table :catalogs do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
