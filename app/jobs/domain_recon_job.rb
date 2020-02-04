class DomainReconJob < ApplicationJob
  queue_as :default

  def perform(domain:)
    Rails.logger.info("[#{self.class.name}] Searching domains for seed #{domain}")

    DomainSources::Base.domains_for(seed: domain)
  end
end
