# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.raise_not_implemented_error
    raise NotImplementedError, "Subclass should override method '#{caller(1..1).first[/`.*'/][1..-2]}'"
  end
  private_class_method :raise_not_implemented_error
end
