
# Sendgrid
# require 'sendgrid-ruby'
# include SendGrid

# data = JSON.parse(%Q[{
#     "personalizations": [
#       {
#         "to": [
#           {
#             "email": "#{@lead.email}"
#           }
#         ],
#         "dynamic_template_data":{
#           "full_name":"#{@lead.full_name}",
#           "project_name":"#{@lead.project_name}"
#         },
#         "subject": "Greetings from Team Rocket!"
#       }
#     ],
#     "from": {
#       "email": "Rocket@example.com"
#     },
#     "template_id":"d-28033aca18914f9d875a7a233454197a"
#   }])
#   sg = SendGrid::API.new(api_key: ENV["SENDGRID_API"])
#   response = sg.client.mail._("send").post(request_body: data)
# puts response.status_code
# puts response.body
# puts response.parsed_body
# puts response.headers




# # using SendGrid's Ruby Library
# # https://github.com/sendgrid/sendgrid-ruby
# require 'sendgrid-ruby'
# include SendGrid

# from = Email.new(email: 'test@example.com')
# to = Email.new(email: 'ahsantime1@gmail.com')
# subject = 'Sending with SendGrid is Fun'
# content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
# mail = Mail.new(from, subject, to, content)

# sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
# response = sg.client.mail._('send').post(request_body: mail.to_json)
# puts response.status_code
# puts response.body
# puts response.headers


