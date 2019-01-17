class AddNoteToIntegralRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :integral_records, :note, :string
  end
end
