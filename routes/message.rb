before do
  account_sid = "***"
  auth_token = "***"
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

  set :email_username, ENV['SENDGRID_USERNAME'] || 'wauterw@gmail.com'
  set :email_password, ENV['SENDGRID_PASSWORD'] || 'wauters1978'
  set :email_address, 'wauterw@gmail.com'
  set :email_service, ENV['EMAIL_SERVICE'] || 'gmail.com'
  set :email_domain, ENV['SENDGRID_DOMAIN'] || 'localhost.localdomain'


end


post '/message' do
    #login_required
    @phone_number = params[:phone_number]
    @email = params[:email]
    #puts @email
    @client.account.sms.messages.create(
        :from => @twilio_number,
        :to => @phone_number,
        :body => "Uw bezoeker is aangekomen. Gelieve naar de receptie te gaan"
    )
    flash[:notice] = "Uw contactpersoon werd geinformeerd via SMS"


    Pony.mail(
            :to => @email,
            :from => "Wymedia <" + settings.email_username + ">" ,
            :subject => 'Bezoek aan de receptie',
            :body => 'Uw bezoeker is aangekomen aan de receptie.',

            :via_options => { 
              :address              => 'smtp.' + settings.email_service,
              :port                 => '587', 
              :enable_starttls_auto => true, 
              :user_name            => settings.email_username, 
              :password             => settings.email_password, 
              :authentication       => :plain, 
              :domain               => settings.email_domain
            })

    redirect "/"
end

