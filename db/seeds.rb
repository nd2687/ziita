table_names0 = %w(accounts)

table_names0.each do |table_name|
  path = "#{Rails.root}/db/seeds/#{Rails.env}/#{table_name}.rb"
  if File.exist?(path)
    puts "Creating #{table_name}....."
    require(path)
  end
end

table_names = %w(administrators articles comments)

table_names.each do |table_name|
  path = "#{Rails.root}/db/seeds/#{Rails.env}/#{table_name}.rb"
  if File.exist?(path)
    puts "Creating #{table_name}....."
    require(path)
  end
end
