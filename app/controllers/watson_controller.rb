require "ibm_watson"
require "ibm_watson/authenticators"
require "ibm_watson/text_to_speech_v1"
include IBMWatson


class WatsonController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def speak
  
        authenticator = Authenticators::IamAuthenticator.new(
            apikey: ENV["TEXT_TO_SPEECH_IAM_APIKEY"]
        )
        text_to_speech = TextToSpeechV1.new(
            authenticator: authenticator
        )
        text_to_speech.service_url = ENV['TEXT_TO_SPEECH_URL']
            
        message = "Greetings user #{current_user.id}. There are currently #{Elevator.count} elevators deployed in the #{Building.count} 
        buildings of your #{Customer.count} customers. Currently, #{Elevator.where(status: 'Inactive').count} elevators are not in Running Status 
        and are being serviced. You currently have #{Quote.count} quotes awaiting processing. You currently have #{Lead.count} leads in your contact 
        requests. #{Battery.count} Batteries are deployed across #{Address.where(id: Building.select(:address_id).distinct).select(:city).distinct.count} cities."

        response = text_to_speech.synthesize(
            text: message,
            accept: "audio/wav",
            voice: "en-GB_KateV3Voice"
        ).result

        File.open("#{Rails.root}/public/watson.wav", "wb") do |audio_file|
            audio_file.write(response)
        end 

        redirect_back fallback_location: root_path
           
    end
end
