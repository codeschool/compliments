desc "Update Slack avatars"
task :update_slack_avatars => [:dependent, :tasks] do
  users_with_broken_avatars = User.all.reject do |user|
    Faraday.get(user.image).status == 200
  end

  users_with_broken_avatars.each do |user|
    user.image = Slacker.find_by_id(user.slack_id).image
    user.save
  end
end
