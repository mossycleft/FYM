


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



Capistrano::Configuration.instance(:must_exist).load do
  _cset(:whenever_roles)        { :db }
  _cset(:whenever_options)      { {:roles => fetch(:whenever_roles)} }
  _cset(:whenever_command)      { "whenever" }
  _cset(:whenever_identifier)   { fetch :application }
  _cset(:whenever_environment)  { fetch :rails_env, "production" }
  _cset(:whenever_variables)    { "environment=#{fetch :whenever_environment}" }
  _cset(:whenever_update_flags) { "--update-crontab #{fetch :whenever_identifier} --set #{fetch :whenever_variables}" }
  _cset(:whenever_clear_flags)  { "--clear-crontab #{fetch :whenever_identifier}" }

  # Disable cron jobs at the begining of a deploy.
  after "deploy:update_code", "whenever:clear_crontab"
  # Write the new cron jobs near the end.
  before "deploy:restart", "whenever:update_crontab"
  # If anything goes wrong, undo.
  after "deploy:rollback", "whenever:update_crontab"

  namespace :whenever do
    desc <<-DESC
      Update application's crontab entries using Whenever. You can configure \
      the command used to invoke Whenever by setting the :whenever_command \
      variable, which can be used with Bundler to set the command to \
      "bundle exec whenever". You can configure the identifier used by setting \
      the :whenever_identifier variable, which defaults to the same value configured \
      for the :application variable. You can configure the environment by setting \
      the :whenever_environment variable, which defaults to the same value \
      configured for the :rails_env variable which itself defaults to "production". \
      Finally, you can completely override all arguments to the Whenever command \
      by setting the :whenever_update_flags variable. Additionally you can configure \
      which servers the crontab is updated on by setting the :whenever_roles variable.
    DESC
    task :update_crontab do
      options = fetch(:whenever_options)

      if find_servers(options).any?
        on_rollback do
          if fetch :previous_release
            run "cd #{fetch :previous_release} && #{fetch :whenever_command} #{fetch :whenever_update_flags}", options
          else
            run "cd #{fetch :release_path} && #{fetch :whenever_command} #{fetch :whenever_clear_flags}", options
          end
        end

        run "cd #{fetch :current_path} && #{fetch :whenever_command} #{fetch :whenever_update_flags}", options
      end
    end

    desc <<-DESC
      Clear application's crontab entries using Whenever. You can configure \
      the command used to invoke Whenever by setting the :whenever_command \
      variable, which can be used with Bundler to set the command to \
      "bundle exec whenever". You can configure the identifier used by setting \
      the :whenever_identifier variable, which defaults to the same value configured \
      for the :application variable. Finally, you can completely override all \
      arguments to the Whenever command by setting the :whenever_clear_flags variable. \
      Additionally you can configure which servers the crontab is cleared on by setting \
      the :whenever_roles variable.
    DESC
    task :clear_crontab do
      options = fetch(:whenever_options)
      run "cd #{fetch :latest_release} && #{fetch :whenever_command} #{fetch :whenever_clear_flags}", options if find_servers(options).any?
    end
  end
end

###### END DEPLOY.RB ######
