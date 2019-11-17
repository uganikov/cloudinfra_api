class User < ApplicationRecord
  after_initialize :set_pkey, if: :new_record?
  has_secure_password
  has_secure_token

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :token, uniqueness: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def identity_pub()
    pubkey = nil
    Dir.mktmpdir{|dir|
      File.open("#{dir}/pkey", "w", 0600) do |f|
        f.write(self.pkey)
      end
      pubkey = `ssh-keygen -y -f #{dir}/pkey`
    }
    pubkey
  end

private
  def set_pkey()
    Dir.mktmpdir{|dir|
      system("ssh-keygen -N '' -q -f #{dir}/pkey")
      File.open("#{dir}/pkey", "r") do |f|
        self.pkey ||= f.read
      end
    }
  end
end
