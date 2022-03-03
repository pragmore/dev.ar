class CreateDomain < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.string :name
      t.string :redirect_to

      t.timestamps
    end
  end
end
