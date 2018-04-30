class CreatePosts < ActiveRecord::Migration[5.2]
    def change
        create_table :posts do |t|
            t.integer :user_id
            t.string :image
            t.string :text
            t.string :tag_list
            t.datetime :created_at
            t.datetime :updated_at
        end
    end
end
