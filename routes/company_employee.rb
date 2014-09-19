  get "/companies/:id/employees/results?" do
    @results = Company.get(params[:id])
    haml :"company_employee/results"
  end

  get "/companies/:id/employees/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      logger.info "Calling the index page"
      @companies = Company.get(params[:id])
      haml :"company_employee/index"
    else
      redirect '/error_403'
    end
  end

  get "/companies/:id/employees/new/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      @title = "New Company"
      @id = params[:id]
      @company = Company.get(params[:id])
      haml :"/company_employee/new"
    else
      redirect '/error_403'
    end
  end

  post "/companies/:id/employees/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      employee = Employee.new(:company_id => params[:company_id], :firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone], :created_at => Time.now,:updated_at => Time.now)
      if employee.save
        flash[:notice] = "Employee saved successfully."
        redirect '/companies'
      else 
        flash[:error] = "Employee could not be saved."
        redirect '/companies'
      end
    else
      redirect '/error_403'
    end
  end

  get '/companies/:id/employees/upload' do
    login_required 
    @id = params[:id]
    @company = Company.get(params[:id])
    haml :"company_employee/upload"
  end

  post '/companies/:id/employees/upload' do
    login_required 
    unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
      return haml(:"employee/upload")
    end
    File.open('public/uploads/' + params[:file][:filename], "w") do |f|
      f.write(params[:file][:tempfile].read)
    end
    
    CSV.foreach('public/uploads/' + params[:file][:filename].to_s, :headers => true) do |csv_obj|
      employee = Employee.new(:company_id => params[:id], :firstname => csv_obj['firstname'], :lastname => csv_obj['lastname'], :phone => csv_obj['phone'], :created_at => Time.now,:updated_at => Time.now)
      employee.save
    end

    flash[:success] = "Employees inserted successfully"
    redirect '/'
  end

  get '/companies/:id/employees/delete/all/?' do
    login_required 
    employees = Employee.all
    
    employees.each do |employee|
      puts employee[:firstname]
      employee.destroy
    end
    redirect '/'

  end

  