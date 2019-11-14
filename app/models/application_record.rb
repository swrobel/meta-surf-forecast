# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include Memery

  self.abstract_class = true

  def self.raise_not_implemented_error
    raise NotImplementedError, "Subclass should override method '#{caller_locations(1, 1)[0].label}'"
  end
  private_class_method :raise_not_implemented_error
end
