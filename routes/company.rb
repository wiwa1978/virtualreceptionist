  get "/?" do
    #login_required
    #logger.info "Calling the index page"
    #redirect "/employees/search"
    redirect "/companies/logo"
  end

  get "/companies/logo?" do
      @companies = Company.all(:order => :name)
      haml :"company/logo"
  end

  get "/companies/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      logger.info "Calling the index page"
      @companies = Company.all(:order => :name)
      haml :"company/index"
    else
      haml :"error_403"
    end
  end

  get "/companies/new/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      logger.info "Company create form loaded"
      @title = "New Company"
      haml :"/company/new"
    else
       haml :"error_404"
    end
  end

  get "/public/uploads/:name?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      haml :"/company/new"
    else
       haml :"error_403"
    end
  end

  post "/companies/?" do
    login_required
    File.open('public/uploads/' + params[:file][:filename], "w") do |f|
      f.write(params[:file][:tempfile].read)
    end
    
    if current_user.site_admin? | current_user.admin?
      company = Company.new(:name => params[:name], :logo => params[:file][:filename],:created_at => Time.now,:updated_at => Time.now)
      logger.info "New company created with id " + params[:id].to_s
      if company.save
        flash[:notice] = "Company saved successfully."
        redirect '/'
      else 
        flash[:error] = "Company could not be saved."
        redirect '/companies'
      end
    else
       haml :"error_403"
    end
  end
   
  get "/companies/:id/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      @company = Company.get(params[:id])
      logger.info "Company information for company with id " + params[:id].to_s
      @title = "Company Info"
      haml :"company/show"
    else
       haml :"error_403"
    end
  end
   
  get "/companies/:id/edit/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      @company = Company.get(params[:id])
      logger.info "Company updated form loaded for company with id " + params[:id].to_s 
      @title = "Edit Company Info"
      haml :"company/edit"
     else
       haml :"error_403"
    end
  end
   
  put "/companies/:id/?" do
    login_required  
    if current_user.site_admin? | current_user.admin? 
      company = Company.get(params[:id])
      logger.info "Company updated with id " + params[:id].to_s
      company.update(:name => params[:name])
      redirect "/companies"
    else
       haml :"error_403"
    end
  end
   
  get '/companies/:id/delete/?' do
    login_required  
    if current_user.site_admin? | current_user.admin? 
      @company = Company.get(params[:id])
      logger.info "Company deleted with id " + params[:id].to_s
      haml :"company/delete"
    else
       haml :"error_403"
    end
  end

  delete '/companies/:id/delete/?' do
    login_required  
    if current_user.site_admin? | current_user.admin?
      Company.get(params[:id]).destroy
      redirect '/companies'  
    else
       haml :"error_403"
    end
  end

  post '/companies/:id/upload' do
    unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
      return haml(:"employee/upload")
    end
    File.open('public/uploads/' + params[:file][:filename], "w") do |f|
      f.write(params[:file][:tempfile].read)
    end
    
    CSV.foreach('public/uploads/' + params[:file][:filename].to_s, :headers => true) do |csv_obj|
      employee = Employee.new(:company_id => 1, :firstname => csv_obj['firstname'], :lastname => csv_obj['lastname'], :phone => csv_obj['phone'], :created_at => Time.now,:updated_at => Time.now)
      employee.save
    end

    flash[:success] = "Employees inserted successfully"
    redirect '/'
  end
 
