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
    #@results = Employee.all(:lastname.ilike => "%#{params[:query]}%") | Employee.all(:firstname.ilike => "%#{params[:query]}%")
    @results = Employee.find(:conditions => ["lower(lastname) = ?", params[:query].downcase ]) 
    haml :"employee/results"
  end
