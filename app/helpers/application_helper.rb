module ApplicationHelper
    def name(user)
      "#{user.first_name} #{user.last_name}"
    end
end
