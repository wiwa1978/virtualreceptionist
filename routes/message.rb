before do
  account_sid = "AC2b99feef2c2fcaad4bea74b969cfb35c"
  auth_token = "dab2b9ce1d0b0f61e48982afce151552"
  @twilio_number = "+14846624263"

  #TWILIO_ACCOUNT_SID  =   ENV['TWILIO_ACCOUNT_SID'] || TWILIO_ACCOUNT_SID
  #TWILIO_AUTH_TOKEN   =   ENV['TWILIO_AUTH_TOKEN'] || TWILIO_AUTH_TOKEN
  #TWILIO_CALLER_ID    =   ENV['TWILIO_CALLER_ID'] || TWILIO_CALLER_ID

  
  @client = Twilio::REST::Client.new account_sid, auth_token

  if params[:error].nil?
    @error = false
  else
    @error = true
  end

end


post '/message' do
    login_required
    @phone_number = params[:phone_number]

    @client.account.sms.messages.create(
        :from => @twilio_number,
        :to => @phone_number,
        :body => "Your contact person has arrived. Please go to the reception"
    )
    flash[:notice] = "Your contact person was informed that you are here"
    redirect "/"
end