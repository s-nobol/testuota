class AddReproductionUrlToEventposts < ActiveRecord::Migration[5.2]
  def change
    add_column :eventposts, :reproduction_url, :string
  end
end
