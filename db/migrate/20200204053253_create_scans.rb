class CreateScans < ActiveRecord::Migration[6.0]
  def change
    create_table :scans do |t|
      t.references :parent_domain, foreign_key: { to_table: :domains }
      t.references :domains_scan
      t.json :sources
    end

    create_table :domains_scans do |t|
      t.references :scan, foreign_key: true
      t.references :domain, foreign_key: true
    end

    add_foreign_key :scans, :domains_scans
  end
end
