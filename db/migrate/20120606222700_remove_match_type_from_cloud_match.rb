class RemoveMatchTypeFromCloudMatch < ActiveRecord::Migration
  def change
    remove_column  :cloud_matches, :and_match
  end
end
