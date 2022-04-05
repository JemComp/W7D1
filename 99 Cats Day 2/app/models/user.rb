class User < ApplicationRecord
    validates :username, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}
    validates :session_token, presence: true, uniqueness: true
    
    after_initialize :ensure_session_token

    # after_initialize :require_logged_out, only[:new, :create]
    
    attr_reader :password

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def self.find_by_credentials(username, password)
        @user = User_find_by(username: username)
        if user and user.is_password?(password)
            return user
        else
            return nil
        end
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

end