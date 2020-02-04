class Scan < ApplicationRecord
  has_and_belongs_to_many :domains
  belongs_to :parent_domain, class_name: 'Domain'

  def sources
    attributes[:sources] || []
  end
end
