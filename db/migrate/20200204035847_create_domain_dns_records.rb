class CreateDomainDnsRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :domain_dns_records do |t|
      t.references :dns_record, null: false, foreign_key: true
      t.references :domain, null: false, foreign_key: true

      t.timestamps
    end
  end
end
