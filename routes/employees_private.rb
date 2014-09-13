  get "/employees/new/?" do
    login_required  
    logger.info "Employee create form loaded"
    @title = "New Employee"
    haml :"/employee/new"
  end

  post "/employees/?" do
    login_required  
    employee = Employee.new(:firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone], :created_at => Time.now,:updated_at => Time.now)
    logger.info "New employee created with id " + params[:id].to_s
    if employee.save
      flash[:notice] = "Employee saved successfully."
      redirect '/'
    else 
      flash[:error] = "Employee could not be saved."
      redirect '/'
    end
  end
  
  get "/employees/:id/?" do
    login_required  
    @employee = Employee.get(params[:id])
    logger.info "Employee information for employee with id " + params[:id].to_s
    @title = "Employee Info"
    haml :"employee/show"
  end
   
  

 