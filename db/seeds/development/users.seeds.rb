print 'Generating users samples '

FactoryBot.create_list(:user, 30)

puts " #{User.count} DONE!"