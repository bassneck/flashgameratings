class AddIndexesToForeignKeys < ActiveRecord::Migration
  def change
    add_index :games, :user_id
    add_index :games, :updated_at, order: { updated_at: :desc}
    add_index :requests, :game_id
    add_index :requests, :portal_id
    add_index :requests, [:game_id, :portal_id], unique: true
    add_index :user_portal_accounts, :user_id
    add_index :user_portal_accounts, :portal_id
    add_index :user_votes, :user_id
    add_index :user_votes, :request_id
    add_index :users, :points, order: { points: :desc }
    add_index :users, :username
    add_index :users, :email
  end
end
