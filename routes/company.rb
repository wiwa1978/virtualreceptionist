  get "/companies/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      logger.info "Calling the index page"
      @companies = Company.all(:order => :name)
      haml :"company/index"
    else
      haml :"error_404"
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

  post "/companies/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      company = Company.new(:name => params[:name], :created_at => Time.now,:updated_at => Time.now)
      logger.info "New company created with id " + params[:id].to_s
      if company.save
        flash[:notice] = "Company saved successfully."
        redirect '/'
      else 
        flash[:error] = "Company could not be saved."
        redirect '/companies'
      end
    else
       haml :"error_404"
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
       haml :"error_404"
    end
  end
   
  get "/companies/edit/:id/?" do
    login_required  
    if current_user.site_admin? | current_user.admin?
      @company = Company.get(params[:id])
      logger.info "Company updated form loaded for company with id " + params[:id].to_s 
      @title = "Edit Company Info"
      haml :"company/edit"
     else
       haml :"error_404"
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
       haml :"error_404"
    end
  end
   
  get '/companies/delete/:id/?' do
    login_required  
    if current_user.site_admin? | current_user.admin? 
      @employee = Company.get(params[:id])
      logger.info "Company deleted with id " + params[:id].to_s
      haml :"company/delete"
    else
       haml :"error_404"
    end
  end

  delete '/companies/delete/:id/?' do
    login_required  
    if current_user.site_admin? | current_user.admin?
      Company.get(params[:id]).destroy
      redirect '/companies'  
    else
       haml :"error_404"
    end
  end

 