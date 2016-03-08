class AddOauthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :twitter_token, :string
    add_column :users, :twitter_secret, :string
    add_column :users, :twitter_raw_data, :text
    # we use a composite index since we will be searching for folks with a uid and a provider
    add_index :users, [:uid, :provider]
  end
end
