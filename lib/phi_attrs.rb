# frozen_string_literal: true

require 'rails'
require 'active_support'
require 'request_store'

require 'phi_attrs/version'
require 'phi_attrs/configure'
require 'phi_attrs/railtie' if defined?(Rails)
require 'phi_attrs/formatter'
require 'phi_attrs/logger'
require 'phi_attrs/exceptions'
require 'phi_attrs/phi_record'

module PhiAttrs
  def phi_model(with: nil, except: nil)
    include PhiRecord
    logger = ActiveSupport::Logger.new(PhiAttrs.log_path)
    logger.formatter = Formatter.new
    file_logger = ActiveSupport::TaggedLogging.new(logger)

    PhiAttrs::Logger.logger = file_logger
  end

  @@log_path = nil

  def self.configure
    yield self if block_given?
  end

  def self.log_path
    @@log_path
  end

  def self.log_path=(value)
    @@log_path = value
  end
end
