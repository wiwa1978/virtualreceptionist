get "/users/?" do
    login_required  
    @users = DmUser.all
    haml :"authentication/index"
  end