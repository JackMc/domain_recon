class CreateDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :domains do |t|
      t.string :fqdn
      t.json :sources
      t.text :notes

      t.timestamps
    end
  end
end
