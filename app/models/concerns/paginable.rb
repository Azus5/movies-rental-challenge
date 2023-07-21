# frozen_string_literal: true

# makes record paginable
module Paginable
  extend ActiveSupport::Concern
  DEFAULT_PAGE_SIZE = 15

  included do
    scope :page, ->(page) { limit(DEFAULT_PAGE_SIZE).offset((page.to_i <= 0 ? 0 : page.to_i - 1) * DEFAULT_PAGE_SIZE) }
  end
end
