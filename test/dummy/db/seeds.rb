[:admin, :company, :trainer].each do |role|
  Role.find_or_create_by({ name: role })
end
roles = Role.all

puts "Seed finished"
puts "#{Role.count} roles created"
