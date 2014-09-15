  get "/companies/:id/employees/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      logger.info "Calling the index page"
      @companies = Company.get(params[:id])
      haml :"company_employee/index"
    else
      haml :"error_404"
    end
  end

  get "/companies/:id/employees/new/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      @title = "New Company"
      @id = params[:id]
      haml :"/company_employee/new"
    else
      haml :"error_404"
    end
  end

  post "/companies/:id/employees/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      employee = Employee.new(:company_id => params[:company_id], :firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone], :created_at => Time.now,:updated_at => Time.now)
      logger.info "Test " + params[:company_id].to_s
      if employee.save
        flash[:notice] = "Employee saved successfully."
        redirect '/companies'
      else 
        flash[:error] = "Employee could not be saved."
        redirect '/companies'
      end
    else
      haml :"error_404"
    end
  end
  