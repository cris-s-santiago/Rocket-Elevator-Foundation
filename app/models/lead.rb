class Lead < ApplicationRecord
    # SendGrid
    require 'sendgrid-ruby'
    include SendGrid
end
