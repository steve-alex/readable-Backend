class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_since_upload
    if self.class.name === "Progress"
      seconds_since_upload = Time.new - self.updated_at
      calculate_time_since_upload(seconds_since_upload)
    else
      seconds_since_upload = Time.new - self.created_at
      calculate_time_since_upload(seconds_since_upload)
    end
  end

  def calculate_time_since_upload(time)
    if (time % 60 == time)
      if (time <= 20)
        return "Just now"
      else
        return "#{time.round} seconds ago"
      end
    elsif (time % 3600 == time)
      if (time == 1)
        return "#{(time / 60).round} minute ago"
      else
        return "#{(time / 60).round} minutes ago"
      end
    elsif (time % 86400 == time)
      if (time == 1)
        return "#{(time / 3600).round} hour ago" 
      else
        return "#{(time / 3600).round} hours ago" 
      end
    elsif (time % 604800 == time)
      return "#{(time / 86400).round} days ago"
    else
      return "#{(time / 604800).round} weeks ago"
    end
  end

end
