  get "/history/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      @histories = History.all(:order => :created_at.desc)
      haml :"history/index"
    else
      redirect '/error_403'
    end
  end