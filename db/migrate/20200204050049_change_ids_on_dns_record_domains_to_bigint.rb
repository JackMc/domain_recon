class ChangeIdsOnDnsRecordDomainsToBigint < ActiveRecord::Migration[6.0]
  def change
    change_column :dns_records_domains, :dns_record_id, :bigint
    change_column :dns_records_domains, :domain_id, :bigint
  end
end
