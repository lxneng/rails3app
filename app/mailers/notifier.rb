class Notifier < ActionMailer::Base
  class <<self
    def smtp_settings
      options = YAML.load_file("#{RAILS_ROOT}/config/action_mailer.yml")['notification']
      @@smtp_settings = {
        :address              => options["address"],
        :port                 => options["port"],
        :domain               => options["domain"],
        :authentication       => options["authentication"],
        :user_name            => options["user_name"],
        :password             => options["password"]
      }
    end
  end

  default :from => "lxneng.py@gmail.com", :host => 'lxneng.com'
  
  def password_reset_instructions(user)
    mail(:to => user.email,
         :subject => "password reset")
    body[:edit_password_reset_url] = edit_password_reset_path(user.perishable_token)
  end
end
