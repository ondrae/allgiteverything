class RemoveLabelsFromIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :labels
  end
end
