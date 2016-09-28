class User < ActiveRecord::Base
  enum user_type: { mentee: 0, mentor: 1, both: 2 }
  enum gender: { male: 'male', female: 'female' }
  
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
