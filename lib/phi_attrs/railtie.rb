# frozen_string_literal: true

require 'phi_attrs'
require 'rails'

module PhiAttrs
  class Railtie < Rails::Railtie
    initializer 'phi_attrs.initialize' do |_app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.extend PhiAttrs::Model
        ActionController::Base.include PhiAttrs::Controller
      end
    end
  end
end
