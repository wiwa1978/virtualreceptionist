  get "/?" do
    #login_required
    #logger.info "Calling the index page"
    redirect "/employees/search"
  end

  get "/employees/?" do
    login_required  
    logger.info "Calling the index page"
    #@employees = Employee.all(:order => :created_at.desc)
    @companies = Company.all
    haml :"employee/index"
  end

  get "/employees/search/?"  do
    haml :"employee/search"
  end

  post "/employees/search"  do
    @results = Employee.all(:lastname.like => "%#{params[:query]}%") | Employee.all(:firstname.like => "%#{params[:query]}%")
    haml :"employee/results"
  end
