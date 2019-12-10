print 'Generating administrator samples '

FactoryBot.create(:administrator,
                  email: 'test@test.com',
                  password: '12345678',
                  password_confirmation: '12345678')

puts " #{Administrator.count} DONE!"