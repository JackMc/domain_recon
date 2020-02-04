module DomainSources
  class CrtSh
    include HTTParty
    base_uri 'crt.sh'

    def domains(seed:)
      response = self.class.get("/?q=#{seed}&output=json")
      unless response.code == 200
        Rails.logger.error("crt.sh returned a non-200 response code: #{response.code}, #{response.body}")
      end
      response_json = JSON.parse(response.body)
      Rails.logger.info("Received #{response_json.count} domains from crt.sh")

      response_json.map do |domain_info|
        names, earliest_seen = domain_info["name_value"], domain_info["not_before"]
        names.split("\n").map do |name|
          DomainStorerJob.perform_later(fqdn: name, created_at: earliest_seen, source: self.class.name)
        end
      end.flatten.uniq
    end
  end
end
