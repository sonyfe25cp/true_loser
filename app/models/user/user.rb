# -*- encoding: utf-8 -*-
require Rails.root.join('lib', 'devise', 'encryptors', 'sha1')

class User::User

  include DataMapper::Resource
  include DataMapper::Searcher

  include Gravtastic

  gravtastic

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :encryptable,
    :recoverable, :rememberable, :trackable, :omniauthable

  ## Database authenticatable
  property :email,              String, :required => true, :default => "", :length => 255, :unique => true,
    :format => :email_address,
    :messages => {
      :presence => '邮箱不能为空',
      :is_unique => '邮箱已经存在'
    }
  property :encrypted_password, String, :required => true, :default => "", :length => 255
  property :password_salt, String

  ## Recoverable
  property :reset_password_token,   String
  property :reset_password_sent_at, DateTime

  ## Rememberable
  property :remember_created_at, DateTime

  ## Trackable
  property :sign_in_count,      Integer, :default => 0
  property :current_sign_in_at, DateTime
  property :last_sign_in_at,    DateTime
  property :current_sign_in_ip, String
  property :last_sign_in_ip,    String

  ## Encryptable
  # property :password_salt, String

  ## Confirmable
  # property :confirmation_token,   String
  # property :confirmed_at,         DateTime
  # property :confirmation_sent_at, DateTime
  # property :unconfirmed_email,    String # Only if using reconfirmable

  ## Lockable
  # property :failed_attempts, Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # property :unlock_token,    String # Only if unlock strategy is :email or :both
  # property :locked_at,       DateTime

  ## Token authenticatable
  # property :authentication_token, String, :length => 255

  ## Invitable
  # property :invitation_token, String, :length => 255

  property :id, Serial
  property :username, String, required: true, unique: true, messages: {
    presence: '用户名不能为空',
    is_unique: '用户名已经存在'
  }
  property :realname, String
  property :area_code, String
  property :address, String
  property :phone, String
  property :promised, Boolean, default: false
  property :user_img, String
  property :user_weibo, String


  validates_with_block :promised do
    @promised ? true : [false, '需要您的承诺']
  end

  validates_presence_of :password, :message => '密码不能为空'
  validates_confirmation_of :password, :message => '两次输入的密码不匹配'

  attr_accessor :login

  def update_without_password(attrs, *options)
    self.attributes = attrs
    result = save(:validate => false)

    clean_up_passwords
    result
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login).downcase
      (all(conditions || {}).all(:username => login) | all(:email => login)).first
    else
      all(conditions || {}).first
    end
  end

  def self.find_for_weibo(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User::User.search('username' => data["name"]).first

    unless user
      user = User::User.create!(username: data["name"],
                         user_img: data['image'],
                         user_weibo: data['urls']['Weibo'],
                         email: data['name'] + '@example.com',
                         password: Devise.friendly_token[0,20],
                         promised: true
                        )
    end
    user
  end

  def self.find_for_renren(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User::User.search('username' => data["name"]).first

    unless user
      user = User::User.create!(username: data["name"],
                         #email: data["email"],#这就是别的网站都需要再次注册的根本原因，没有邮箱信息
                         email: data['name'] + '@example.com',
                         password: Devise.friendly_token[0,20],
                         promised: true
                        )
    end
    user
  end

end
