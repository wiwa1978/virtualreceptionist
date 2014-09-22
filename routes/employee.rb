
  get "/employees/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      @employees = Employee.all(:order => :id.desc)
      haml :"employee/index"
    else
      redirect '/error_403'
    end
  end

  #get "/employees/search/?"  do
  #  haml :"employee/search"
  #end


  # post "/employees/search"  do
  #  @results = Employee.all(:lastname.like => "%#{params[:query]}%") | Employee.all(:firstname.like => "%#{params[:query]}%")
  #  haml :"employee/results"
  # end

  get "/employees/:id/edit/?" do
    login_required 
    if current_user.site_admin? | current_user.admin?
      @employee = Employee.get(params[:id])
      @title = "Edit Employee Info"
      haml :"employee/edit"
    else
      redirect '/error_403'
    end
  end
   
  put "/employees/:id/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      employee = Employee.get(params[:id])
      employee.update(:firstname => params[:firstname], :lastname => params[:lastname], :phone => params[:phone], :email => params[:email])
      redirect "/employees"
    else
      redirect '/error_403'
    end
  end
   
  get '/employees/:id/delete/?' do
    login_required
    if current_user.site_admin? | current_user.admin?
      @employee = Employee.get(params[:id])
      haml :"employee/delete"
    else
      redirect '/error_403'
    end
  end

  delete '/employees/:id/delete/?' do
    login_required 
    if current_user.site_admin? | current_user.admin? 
      Employee.get(params[:id]).destroy
      redirect '/employees' 
    else
      redirect '/error_403'
    end 
  end


    
 