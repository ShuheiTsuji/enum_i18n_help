ActiveRecord::Base.configurations = { "test"=> {"adapter"=>"sqlite3", "database"=>":memory:"} }
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :sex, null: false, limit: 1

      t.timestamps
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.new.change
