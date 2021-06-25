table_names = %w[
  staff staff_events customers geust
]
table_names.each do |table|
  path = Rails.root.join('db', "#{table}.rb")
  if File.exist?(path)
    puts "Creating... #{table}"
    require(path)
  end
end
