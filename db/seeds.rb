# Create a 'siteadmin' user
DmUser.first_or_create(:email => 'wauterw@gmail.com', :hashed_password => '9fbbf0de07b456a89e60b65ec0d617fb66f694f0', :salt => 'qb373EYltC', :created_at => Time.now, :permission_level => '1' )
