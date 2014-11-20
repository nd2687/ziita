set :deploy_to, "/home/ziita/ziita_production"
set :branch, "master"
set :user, "ziita"
set :resettable, true

# productionは不要、staging等の場合でもproductionになるのでその際は指定が必要
#set :rails_env, "production"

role :app, %w{ziita@153.121.77.43}
role :web, %w{ziita@153.121.77.43}
role :db,  %w{ziita@153.121.77.43}

role :migrator, "ziita@153.121.77.43"
set :ssh_options, {
  keys: %w(/Users/kawanotakashi/.ssh/id_rsa),
  forward_agent: true
}

set :bundle_cmd, "/opt/rubies/2.1.2/bin/bundle"
set :default_environment, {
  "PATH" => "/opt/rubies/2.1.2/bin:$PATH"
}
