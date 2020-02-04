require 'resolv'

class DomainDnsRecordJob < ApplicationJob
  queue_as :default

  RECORD_TYPES = [
    ['CNAME', Resolv::DNS::Resource::IN::CNAME, :name],
    ['A', Resolv::DNS::Resource::IN::A, :address],
    ['AAAA', Resolv::DNS::Resource::IN::AAAA, :address],
    ['MX', Resolv::DNS::Resource::IN::MX, :exchange],
    ['TXT', Resolv::DNS::Resource::IN::TXT, :strings]
  ]

  def perform(domain:)
    RECORD_TYPES.each do |friendly_type, type, method|
      records = Resolv::DNS.new.getresources(domain.fqdn, type)
      records.each do |record|
        record_values = record.try(method)
        record_values = [record_values] unless record_values.is_a?(Array)

        record_values.each do |subrecord|
          next unless subrecord

          domain.dns_records.find_or_create_by(record_type: friendly_type, record_value: subrecord.to_s)
        end
      end
    end
  end
end
