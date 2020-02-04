class DnsRecordsDomains < ApplicationRecord
  belongs_to :dns_record
  belongs_to :domain
end
