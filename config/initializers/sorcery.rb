# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:remember_me, :reset_password]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  # -- core --
  # config.not_authenticated_action = :not_authenticated              # what controller action to call for
                                                                      # non-authenticated users.
                                                                      # You can also override 'not_authenticated'
                                                                      # instead.

  # config.save_return_to_url = true                                  # when a non logged in user tries to enter
                                                                      # a page that requires login,
                                                                      # save the URL he wanted to reach,
                                                                      # and send him there after login, using
                                                                      # 'redirect_back_or_to'.

  # config.cookie_domain = nil                                        # set domain option for cookies
                                                                      # Useful for remember_me submodule

  # -- session timeout --
  # config.session_timeout = 3600                                     # how long in seconds to keep the session alive.
  # config.session_timeout_from_last_action = false                   # use the last action as the beginning of
                                                                      # session timeout.

  # -- http_basic_auth --
  # config.controller_to_realm_map = {"application" => "Application"} # What realm to display for which controller name.
                                                                      # For example {"My App" => "Application"}
  
  # -- activity logging --
  # config.register_login_time = true                                 # will register the time of last user login, every login.
  # config.register_logout_time = true                                # will register the time of last user logout, every logout.
  # config.register_last_activity_time = true                         # will register the time of last user action, every action.
                                                                                                                                          
  # -- external --
  # config.external_providers = []                                    # What providers are supported by this app,
                                                                      # i.e. [:twitter, :facebook, :github] .
  # config.ca_file = 'path/to/ca_file'                                # Path to ca_file. By default use a internal ca-bundle.crt.
                                                                      # You can change it by your local ca_file.
                                                                      # i.e. '/etc/pki/tls/certs/ca-bundle.crt'

  # config.twitter.key = "eYVNBjBDi33aa9GkA3w"
  # config.twitter.secret = "XpbeSdCoaKSmQGSeokz5qcUATClRW5u08QWNfv71N8"
  # config.twitter.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=twitter"
  # config.twitter.user_info_mapping = {:email => "screen_name"}
  #
  # config.facebook.key = "34cebc81c08a521bc66e212f947d73ec"
  # config.facebook.secret = "5b458d179f61d4f036ee66a497ffbcd0"
  # config.facebook.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=facebook"
  # config.facebook.user_info_mapping = {:email => "name"}
  #
  # config.github.key = ""
  # config.github.secret = ""
  # config.github.callback_url = "http://0.0.0.0:3000/oauth/callback?provider=github"
  # config.github.user_info_mapping = {:email => "name"}

  # --- user config ---
  config.user_config do |user|
    # -- core --
    # user.username_attribute_names = [:username]                                     # specify username
                                                                                      # attributes, for example:
                                                                                      # [:username, :email].

    # user.password_attribute_name = :password                                        # change *virtual* password
                                                                                      # attribute, the one which is used
                                                                                      # until an encrypted one is
                                                                                      # generated.

    # user.email_attribute_name = :email                                              # change default email attribute.

    # user.crypted_password_attribute_name =  :crypted_password                       # change default crypted_password
                                                                                      # attribute.

    # user.salt_join_token = ""                                                       # what pattern to use to join the
                                                                                      # password with the salt

    # user.salt_attribute_name = :salt                                                # change default salt attribute.

    # user.stretches = nil                                                            # how many times to apply
                                                                                      # encryption to the password.

    # user.encryption_key = nil                                                       # encryption key used to encrypt
                                                                                      # reversible encryptions such as
                                                                                      # AES256.
                                                                                      #
                                                                                      # WARNING:
                                                                                      #
                                                                                      # If used for users' passwords, changing this key 
                                                                                      # will leave passwords undecryptable!

    # user.custom_encryption_provider = nil                                           # use an external encryption
                                                                                      # class.

    # user.encryption_algorithm = :bcrypt                                             # encryption algorithm name. See
                                                                                      # 'encryption_algorithm=' for
                                                                                      # available options.

    # user.subclasses_inherit_config = false                                          # make this configuration
                                                                                      # inheritable for subclasses.
                                                                                      # Useful for ActiveRecord's STI.
    # -- reset_password --
    user.remember_me_for                              = 20.years
	  user.reset_password_mailer                        = UserMailer
    user.reset_password_expiration_period             = 1.day
    user.reset_password_time_between_emails           = nil

    # user.reset_password_token_attribute_name = :reset_password_token                          # reset password code
                                                                                                # attribute name.

    # user.reset_password_token_expires_at_attribute_name = :reset_password_token_expires_at    # expires at attribute
                                                                                                # name.

    # user.reset_password_email_sent_at_attribute_name = :reset_password_email_sent_at          # when was email sent,
                                                                                                # used for hammering
                                                                                                # protection.

    # user.reset_password_mailer = nil                                                          # mailer class. Needed.

    # user.reset_password_email_method_name = :reset_password_email                             # reset password email
                                                                                                # method on your mailer
                                                                                                # class.

    # user.reset_password_expiration_period = nil                                               # how many seconds
                                                                                                # before the reset
                                                                                                # request expires. nil
                                                                                                # for never expires.

    # user.reset_password_time_between_emails = 5 * 60                                          # hammering protection,
                                                                                                # how long to wait
                                                                                                # before allowing
                                                                                                # another email to be
                                                                                                # sent.
  end

  # This line must come after the 'user config' block.
  config.user_class = "User"                                       # define which model authenticates
                                                                                      # with sorcery.
end
