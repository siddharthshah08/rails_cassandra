class VolumeUsage < CassandraMigrations::Migration
  def up
     create_table :volume_usage, primary_keys: [:id] do |t|
        t.integer   :id
        t.text      :uuid
     end 
  end
  
  def down
     drop_table :volume_usage 
  end
end
