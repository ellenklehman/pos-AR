class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :product
      t.float :total
      t.timestamp
    end
  end
end
