class FullDatabase < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :first_name
      t.string :last_name

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true
      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])

    create_table :brands do |t|
      t.string :name
      t.timestamps
    end

    create_table :product_sellers do |t|
      t.string :website
      t.string :url
      t.string :price
      t.string :name
      t.string :thumbnail
      t.integer :product_id
      t.timestamps
    end

    create_table :favorite_products do |t|
      t.integer :user_id
      t.integer :product_seller_id
      t.timestamps
    end

    create_table :products do |t|
      t.string :reference
      t.integer :brand_id
      t.timestamps
    end

    create_table :product_options do |t|
      t.string :name
      t.timestamps
    end

    create_table :options do |t|
      t.string :name
      t.timestamps
    end

    create_table :product_option_details do |t|
      t.integer :product_option_id
      t.integer :option_id
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :categorizations do |t|
      t.integer :category_id
      t.integer :product_seller_id
      t.timestamps
    end

    create_table :admin_dashboards do |t|
      t.integer :nb_users
      t.integer :nb_products
      t.integer :nb_login
      t.integer :nb_products_amazon
      t.integer :nb_products_ebay
      t.integer :nb_products_amazon_visited
      t.integer :nb_products_ebay_visited
      t.timestamps
    end

    create_table :user_logins do |t|
      t.integer  :user_id
      t.inet     :user_ip
      t.timestamps
    end

    create_table :admin_block_charts do |t|
      t.string :name
      t.integer :x, default: 0
      t.integer :y, default: 0
      t.integer :width, default: 4
      t.integer :height, default: 3
      t.string :title
      t.boolean :presence, default: true
      t.timestamps
    end

    create_table :user_keywords do |t|
      t.string :name
      t.integer :counter, default: 0
      t.timestamps
    end

    create_table :visits do |t|
      t.string :visit_token
      t.string :visitor_token

      # the rest are recommended but optional
      # simply remove the columns you don't want

      # standard
      t.string :ip
      t.text :user_agent
      t.text :referrer
      t.text :landing_page

      # user
      t.integer :user_id
      # add t.string :user_type if polymorphic

      # traffic source
      t.string :referring_domain
      t.string :search_keyword

      # technology
      t.string :browser
      t.string :os
      t.string :device_type
      t.integer :screen_height
      t.integer :screen_width

      # location
      t.string :country
      t.string :region
      t.string :city
      t.string :postal_code
      t.decimal :latitude
      t.decimal :longitude

      # utm parameters
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign

      # native apps
      # t.string :platform
      # t.string :app_version
      # t.string :os_version

      t.timestamp :started_at
    end

    add_index :visits, [:visit_token], unique: true
    add_index :visits, [:user_id]

    create_table :ahoy_events do |t|
      t.integer :visit_id

      # user
      t.integer :user_id
      # add t.string :user_type if polymorphic

      t.string :name
      t.json :properties
      t.timestamp :time
    end

    add_index :ahoy_events, [:visit_id, :name]
    add_index :ahoy_events, [:user_id, :name]
    add_index :ahoy_events, [:name, :time]

    reversible do |dir|
      dir.up do
        Category.create_translation_table!({
                                               :name => :string
                                           }, {
                                               :migrate_data => true,
                                               :remove_source_columns => true
                                           })
      end

      dir.down do
        Category.drop_translation_table! :migrate_data => true
      end
    end
  end

  def self.up
    change_table :users do |t|
      t.attachment :avatar
      t.attachment :cover_banner
    end
  end

  def self.down
    drop_attached_file :users, :avatar
    drop_attached_file :users, :cover_banner
  end
end
