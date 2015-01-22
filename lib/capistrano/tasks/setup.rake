namespace :deploy do
  desc "Upload stage specific files to the shared/config directory."
  task :setup do
    on roles(:app) do
      unless test "[ -d #{shared_path}/config ]"
        execute "/bin/mkdir -p #{shared_path}/config/"
        skel_path = File.expand_path("../../../../config/skel_for_deploy", __FILE__)
        %w(database.yml secrets.yml application.yml).each do |filename|
          upload! "#{skel_path}/#{filename}", "#{shared_path}/config/#{filename}"
        end
        execute "/bin/mkdir -p #{shared_path}/config/unicorn"
        upload! "#{skel_path}/production.rb", "#{shared_path}/config/unicorn/production.rb"
        execute "/bin/mkdir -p #{shared_path}/vendor/assets/bower_components"
      end
    end
  end
end
