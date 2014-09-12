  get "/companies/:id/employees/?" do
    login_required  
    logger.info "Calling the index page"

    @companies = Company.get(params[:id])
    haml :"company_employee/index"
  end

  get "/companies/:id/employees/new/?" do
    login_required  
    @title = "New Company"
    @id = params[:id]
    haml :"/company_employee/new"
  end

  post "/companies/:id/employees/?" do
    login_required  
    employee = Employee.new(:company_id => params[:company_id], :firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone], :created_at => Time.now,:updated_at => Time.now)
    logger.info "Test " + params[:company_id].to_s
    if employee.save
      flash[:notice] = "Employee saved successfully."
      redirect '/'
    else 
      flash[:error] = "Employee could not be saved."
      redirect '/companies/:id/employees'
    end
  end
  