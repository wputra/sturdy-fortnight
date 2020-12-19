class AddLocationToResources < ActiveRecord::Migration[6.1]
  def change
    add_column :resources, :location, :string
  end
end
