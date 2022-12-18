class GrossIncome < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :gross_income, :float
  end
end
