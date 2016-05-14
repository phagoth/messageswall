class User < ActiveRecord::Base

  def self.find_or_create_from_auth_hash(auth_hash)
    User.where(provider: auth['provider'],
                      uid: auth['uid'].to_s).first || User.create_with_omniauth(auth_hash)
  end

  def self.create_with_omniauth(auth_hash)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end