module DomainSources
  class Base
    attr_accessor :seed_domain

    BACKENDS = [
      DomainSources::CrtSh
    ].map(&:new)

    def self.domains_for(seed:)
      BACKENDS.map do |backend|
        Rails.logger.debug("[#{self.name}] Using #{backend} to search domains for #{seed}")
        backend.domains(seed: seed)
      end
    end

    def initialize(seed_domain:)
      self.seed_domain = seed_domain
    end

    def add_domain(attributes_hash)
      DomainStorerJob.perform_later(attributes_hash)
    end

    def domains
      raise "Implement the `domains` method"
    end
  end
end
