# require "ibm_watson/authenticators"
# require "ibm_watson/text_to_speech_v1"
# include IBMWatson

module RailsAdmin
  module Config
    module Actions
      class Watson < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :breadcrumb_parent do
          nil
        end

        register_instance_option :auditing_versions_limit do
          100
        end
        
        register_instance_option :link_icon do
          'icon-music'
        end

        register_instance_option :statistics? do
          true
        end
      end
    end
  end
end