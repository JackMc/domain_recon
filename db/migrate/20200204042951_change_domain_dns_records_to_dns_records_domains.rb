class ChangeDomainDnsRecordsToDnsRecordsDomains < ActiveRecord::Migration[6.0]
  def change
    rename_table :domain_dns_records, :dns_records_domains
  end
end
