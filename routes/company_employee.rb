  get "/companies/:id/employees/?" do
    login_required  
    logger.info "Calling the index page"

    @companies = Company.get(params[:id])
    haml :"company_employees/index"
  end

  get "/companies/:id/employees/new/?" do
    login_required  
    @title = "New Company"
    @id = params[:id]
    haml :"/company_employees/new"
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

  get '/search'  do
   erb :"company_employees/search"
  end

  post '/search'  do
   @results = Employee.all(:lastname.like => "%#{params[:query]}%") | Employee.all(:firstname.like => "%#{params[:query]}%")
   erb :"company_employees/results"
  end
  