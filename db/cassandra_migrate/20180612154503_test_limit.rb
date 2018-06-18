class TestLimit < CassandraMigrations::Migration
  def up
    create_table :test_limit, primary_keys: [:id] do |t|
        t.integer   :id, limit: 8
        t.text      :uuid
     end
  end
  
  def down
  
  end
end
