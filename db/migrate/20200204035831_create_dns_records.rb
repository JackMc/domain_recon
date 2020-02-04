class CreateDnsRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :dns_records do |t|
      t.string :record_type
      t.string :record_value

      t.timestamps
    end
  end
end
