class Domain < ApplicationRecord
  after_create :create_dns_records!
  has_and_belongs_to_many :dns_records
  has_and_belongs_to_many :scans

  def sources
    attributes[:sources] || []
  end

  def create_dns_records!
    DomainDnsRecordJob.perform_later(domain: self)
  end
end
