class CreateUsers < ActiveRecord::Migration[5.2]
    def up
        create_table :users do |t|
            t.string :first_name
            t.string :last_name
            t.string :username
            t.string :email
            t.string :password_digest
            t.boolean :over_12
            t.datetime :created_at
        end
    end

    def down
        drop_table :users
    end
end
