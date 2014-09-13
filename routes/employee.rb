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

  get "/employees/edit/:id/?" do
    login_required  
    @employee = Employee.get(params[:id])
    logger.info "Employee updated form loaded for employee with id " + params[:id].to_s 
    @title = "Edit Employee Info"
    haml :"employee/edit"
  end
   
  put "/employees/:id/?" do
    login_required  
    employee = Employee.get(params[:id])
    logger.info "Employee updated with id " + params[:id].to_s
    employee.update(:firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone])
    redirect "/employees"
  end
   
  get '/employees/delete/:id/?' do
    login_required  
    @employee = Employee.get(params[:id])
    logger.info "Employee deleted with id " + params[:id].to_s
    haml :"employee/delete"
  end

  delete '/employees/delete/:id/?' do
    login_required  
    Employee.get(params[:id]).destroy
    redirect '/employees'  
  end