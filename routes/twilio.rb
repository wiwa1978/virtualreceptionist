require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
 


 
default_client = "virtualreceptionist"
 
get '/client' do
    TWILIO_ACCOUNT_SID  =   ENV['TWILIO_ACCOUNT_SID'] || TWILIO_ACCOUNT_SID
    TWILIO_AUTH_TOKEN   =   ENV['TWILIO_AUTH_TOKEN'] || TWILIO_AUTH_TOKEN
    TWILIO_APP_SID      =   ENV['TWILIO_APP_SID'] || TWILIO_APP_SID
    TWILIO_CALLER_ID    =   ENV['TWILIO_CALLER_ID'] || TWILIO_CALLER_ID

    if !(TWILIO_ACCOUNT_SID && TWILIO_AUTH_TOKEN && TWILIO_APP_SID)
        return "Please run configure.rb before trying to do this!"
    end

    capability = Twilio::Util::Capability.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    # Create an application sid at twilio.com/user/account/apps and use it here
    capability.allow_client_outgoing(TWILIO_APP_SID)
    capability.allow_client_incoming default_client
    token = capability.generate
    erb :"twilio/index", :locals => {:token => token}
end
 
caller_id = "+14846624263"
 
post '/voice' do
    number = params[:PhoneNumber]
    response = Twilio::TwiML::Response.new do |r|
        # Should be your Twilio Number or a verified Caller ID
        r.Dial :callerId => caller_id do |d|
            # Test to see if the PhoneNumber is a number, or a Client ID. In
            # this case, we detect a Client ID by the presence of non-numbers
            # in the PhoneNumber parameter.
            if /^[\d\+\-\(\) ]+$/.match(number)
                d.Number(CGI::escapeHTML number)
            else
                d.Client default_client
            end
        end
    end
    response.text
end




