  get "/?" do
    login_required
    #logger.info "Calling the index page"
    #redirect "/employees/search"
    if logged_in? & current_user.admin?
      redirect "/companies"
    elsif logged_in? & !current_user.admin?
      redirect "/companies/logo"
    
    end
  end

  get "/companies/logo?" do
      login_required
      response['Cache-Control'] = "public, max-age=0, must-revalidate"
      @title = "Welkom in de Spinnerijstraat 12, 9240 Zele"
      @subtitle = "Druk op een logo om je contactpersoon te kiezen"
      @companies = Company.all(:order => :name)
      haml :"company/logo"
  end

  get "/companies/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      @companies = Company.all(:order => :name)
      haml :"company/index"
    else
      redirect '/error_403'
    end
  end

  get "/companies/new/?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      @title = "New Company"
      haml :"/company/new"
    else
      redirect '/error_403'
    end
  end

  get "/public/uploads/:name?" do
    login_required
    if current_user.site_admin? | current_user.admin?
      haml :"/company/new"
    else
      redirect '/error_403'
    end
  end

  #post "/companies/?" do
  #  login_required
  #  File.open('public/uploads/' + params[:file][:filename], "w") do |f|
  #    f.write(params[:file][:tempfile].read)
  #  end
    
  #  if current_user.site_admin? | current_user.admin?
  #    company = Company.new(:name => params[:name], :logo => params[:file][:filename],:created_at => Time.now,:updated_at => Time.now)
      
  #    if company.save
  #      flash[:notice] = "Company saved successfully."
  #      redirect '/'
  #     logger.info "Company saved successfully with id " + params[:id].to_s + ": " + params[:name]
  #    else 
  #      flash[:error] = "Company could not be saved."
  #      redirect '/companies'
  #    end
  #  else
  #    redirect '/error_403'
  #  end
  #end
   
  post "/companies/?" do
    login_required
    upload(params[:file][:filename], params[:file][:tempfile])
    
    
    if current_user.site_admin? | current_user.admin?
      company = Company.new(:name => params[:name], :logo => params[:file][:filename],:created_at => Time.now,:updated_at => Time.now)
      
      if company.save
        flash[:notice] = "Company saved successfully."
        redirect '/'
        logger.info "Company saved successfully with id " + params[:id].to_s + ": " + params[:name]
      else 
        flash[:error] = "Company could not be saved."
        redirect '/companies'
      end
    else
      redirect '/error_403'
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
      redirect '/error_403'
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
      redirect '/error_403'
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
      redirect '/error_403'
    end
  end
   
  get '/companies/:id/delete/?' do
    login_required  
    if current_user.site_admin? | current_user.admin? 
      @company = Company.get(params[:id])
      logger.info "Company deleted with id " + params[:id].to_s
      haml :"company/delete"
    else
      redirect '/error_403'
    end
  end

  delete '/companies/:id/delete/?' do
    login_required  
    if current_user.site_admin? | current_user.admin?
      Company.get(params[:id]).destroy
      redirect '/companies' 
    else
      redirect '/error_403'
    end
  end

  #post '/companies/:id/upload' do
  #  unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
  #    return haml(:"company/upload")
  #  end
  #  File.open('public/uploads/' + params[:file][:filename], "w") do |f|
  #    f.write(params[:file][:tempfile].read)
  #  end
    
  #  CSV.foreach('public/uploads/' + params[:file][:filename].to_s, :headers => true) do |csv_obj|
  #    employee = Employee.new(:company_id => 1, :firstname => csv_obj['firstname'], :lastname => csv_obj['lastname'], :phone => csv_obj['phone'], :created_at => Time.now,:updated_at => Time.now)
  #    employee.save
  #  end

  #  flash[:success] = "Employees inserted successfully"
  #  redirect '/'
  #end
 
