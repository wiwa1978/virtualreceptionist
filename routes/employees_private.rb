  get "/employees/new/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      @title = "New Employee"
      haml :"/employee/new"
    else
      haml :"error_403"
    end
  end

  post "/employees/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      employee = Employee.new(:firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone],:email => params[:email], :created_at => Time.now,:updated_at => Time.now)
      if employee.save
        flash[:notice] = "Employee saved successfully."
        redirect '/'
      else 
        flash[:error] = "Employee could not be saved."
        redirect '/'
      end
    else
      haml :"error_403"
    end
  end
  
  get "/employees/:id/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      @employee = Employee.get(params[:id])
      @title = "Employee Info"
      haml :"employee/show"
    else
      haml :"error_403"
    end
  end
   
  

 