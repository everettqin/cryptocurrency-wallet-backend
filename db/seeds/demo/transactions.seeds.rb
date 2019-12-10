after 'development:users' do
  print 'Generating transaction samples '
  User.all.each do |source_user|
    rand(1..10).times do |i|
      target_user = User.where.not(id: source_user.id).shuffle[0..29].first
      FactoryBot.create(:transaction, source_user: source_user, target_user: target_user)
    end
  end

  puts " #{Transaction.count} DONE!"
end