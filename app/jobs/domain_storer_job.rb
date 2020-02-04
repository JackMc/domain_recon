class DomainStorerJob < ApplicationJob
  queue_as :default

  def perform(**domain_attributes)
    Domain.find_or_create_by(fqdn: domain_attributes.delete(:fqdn)).tap do |domain|
      domain_created_at = domain_attributes.delete(:created_at)
      domain.created_at = domain_created_at if domain_created_at && domain_created_at < domain.created_at
      domain_updated_at = domain_attributes.delete(:updated_at)
      domain.updated_at = domain_created_at if domain_updated_at && domain_updated_at < domain.updated_at
      domain.sources.append(domain_attributes.delete(:source))
      domain.save!
    end
  end
end
