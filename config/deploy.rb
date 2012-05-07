


###### START DEPLOY.RB ######

# Your cPanel/SSH login name

set :user , "ewis"



# The domain name of the server to deploy to, this can be your domain or the domain of the server.

set :server_name, "69.25.137.132"



# Your svn / git login name

set :scm_username , "mossycleft"

set :scm_password, Proc.new { CLI.password_prompt "SVN Password: "}



# Your repository type, by default we use subversion. 

set :scm, :git



# If you are using git, uncomment the following line and comment out the line above.

#set :scm, :git



# The name of your application, this will also be the folder were your application 

# will be deployed to

set :application, "FYM"



# the url for your repository

set :repository,  "git@github.com:mossycleft/FYM.git"





###### There is no need to edit anything below this line ######

set :deploy_to, "/home/#{user}/#{application}"

set :use_sudo, false

set :group_writable, false

default_run_options[:pty] = true 



role :app, server_name

role :web, server_name

role :db,  server_name, :primary => true



# set the proper permission of the public folder

task :after_update_code, :roles => [:web, :db, :app] do

  run "chmod 755 #{release_path}/public"

end



namespace :deploy do



  desc "restart passenger"

  task :restart do

    passenger::restart

  end

   

end



namespace :passenger do

  desc "Restart dispatchers"

  task :restart do

    run "touch #{current_path}/tmp/restart.txt"

  end

end

namespace(:customs) do
  task :config, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
    CMD
  end
end

after "deploy:update_code", "customs:config"


namespace :memcached do
  desc "Flush memcached"
  task :flush, :roles => [:app] do
    run("cd #{current_release} && RAILS_ENV=#{rails_env} /usr/bin/rake memcached:flush")
  end

  desc "Flush memcached if there are any pending migrations (hook this before db:migrate)"
  task :flush_if_pending_migrations, :roles => [:app] do
    output = capture("cd #{current_release} && RAILS_ENV=#{rails_env} /usr/bin/rake db:pending_migration_count"
)
    count = /(\d+) pending migrations/.match(output)
    if count[0] && count[0].to_i > 0
      puts "#{count[0].to_i} migrations will be run! Installing memcached:flush hook"
      after "deploy:migrate", "memcached:flush"
    end
  end
end


###### END DEPLOY.RB ######
