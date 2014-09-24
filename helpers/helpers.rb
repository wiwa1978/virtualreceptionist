helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      "#{@title} -- Virtual Reception"
    else
      "Virtual Reception"
    end
  end
 
  # Format the Ruby Time object returned from a post's created_at method
  # into a string that looks like this: 06 Jan 2012
  def pretty_date(time)
   time.strftime("%d %b %Y") unless time==nil
  end

  def logger
      # Create the log file if it doesn't exist,
      # otherwise just start appending to it,
      # preserving the previous content
      log_file = File.open('logs/my_app.log', 'a+')
      # Don't buffer writes to this file. Recommended for development.
      log_file.sync = true
      logger = Logger.new(log_file)
  end

  def log_to_db(level, event)
    if current_user.site_admin? | current_user.admin?
        history = History.new(:level => level, :event => event,:created_at => Time.now)
        history.save
      end
  end

  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-danger"
        when :alert then "alert alert-error"
    end
  end


  def companyname(id)
    @company = Company.get(id)
    companiename = @company.name
  end


  def upload(filename, file)
    bucket = 'be.wymedia.customers.vminvest.images'
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['ACCESS_KEY_ID'] ||  
      :secret_access_key => ENV['SECRET_ACCESS_KEY'] ||  
    )
    AWS::S3::S3Object.store(
      filename,
      open(file.path),
      bucket
    )
    return filename
  end


end