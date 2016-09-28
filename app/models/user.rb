# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  username                 :string
#  first_name               :string
#  middle_name              :string
#  last_name                :string
#  address                  :string
#  city                     :string
#  state                    :string
#  zipcode                  :string
#  birthdate                :date
#  country                  :string(2)
#  prefered_language        :string(2)
#  user_type                :integer
#  mobile_phone             :string
#  terms_of_service         :boolean
#  default_payment_id       :integer
#  gender                   :string
#  security_question_id     :integer
#  security_question_answer :string
#  avatar_file_name         :string
#  avatar_content_type      :string
#  avatar_file_size         :integer
#  avatar_updated_at        :datetime
#  education                :string
#  about                    :string
#  program                  :string
#  terms                    :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  enum user_type: { mentee: 0, mentor: 1, both: 2 }
  enum gender: { male: 'male', female: 'female' }
  
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  has_many :categorys, through: :categorys_users_relations 
  has_many :categorys_users_relations
  has_many :feed_messages, class_name: 'FeedMessage', foreign_key: :reciever_id
  has_many :payments

  belongs_to :default_payment, class_name: 'Payment'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :username

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "images/:style/avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_acceptance_of :terms_of_service, allow_nil: false, accept: true, on: :create
  validates :email, uniqueness: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { maximum: 32 }
  validates :username, format: { with: /\A[a-zA-Z0-9._-]+\z/, message: "is invalid" }
  validates :security_question_id, presence: true
  validates :security_question_answer, presence: true

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
