require 'ulid'

module HasPublicId
  extend ActiveSupport::Concern

  included do
    after_initialize :generate_public_id
  end

  def generate_public_id
    self.public_id = ULID.generate if public_id.blank?
  end

  def public_id=(ulid)
    super if public_id.blank?
  end
end
