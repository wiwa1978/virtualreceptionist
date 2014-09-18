  #get "/employees/search/?"  do
  #  haml :"employee/search"
  #end

  get "/employees/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      logger.info "Calling the index page"
      #@employees = Employee.all(:order => :created_at.desc)
      @companies = Company.all
      haml :"employee/index"
    else
      haml :"error_404"
    end
  end

  # post "/employees/search"  do
  #  @results = Employee.all(:lastname.like => "%#{params[:query]}%") | Employee.all(:firstname.like => "%#{params[:query]}%")
  #  haml :"employee/results"
  # end

  get "/employees/:id/edit/?" do
    login_required 
    if current_user.site_admin? | current_user.admin?
      @employee = Employee.get(params[:id])
      logger.info "Employee updated form loaded for employee with id " + params[:id].to_s 
      @title = "Edit Employee Info"
      haml :"employee/edit"
    else
      haml :"error_404"
    end
  end
   
  put "/employees/:id/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      employee = Employee.get(params[:id])
      logger.info "Employee updated with id " + params[:id].to_s
      employee.update(:firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone])
      redirect "/employees"
    else
      haml :"error_404"
    end
  end
   
  get '/employees/:id/delete/?' do
    login_required
    if current_user.site_admin? | current_user.admin?
      @employee = Employee.get(params[:id])
      logger.info "Employee deleted with id " + params[:id].to_s
      haml :"employee/delete"
    else
      haml :"error_404"
    end
  end

  delete '/employees/:id/delete/?' do
    login_required 
    if current_user.site_admin? | current_user.admin? 
      Employee.get(params[:id]).destroy
      redirect '/employees' 
    else
      haml :"error_404"
    end 
  end


    
 