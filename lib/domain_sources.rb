module DomainSources
  BACKENDS = [CrtSh]

  def domains(seed)
    BACKENDS.map do |backend|
      backend.new(seed).domains
    end
  end
end
