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
#  provider                 :string
#  uid                      :string
#  mentor_status            :boolean          default(TRUE)
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
  has_many :follows
  has_many :ratings
  has_many :courses
  has_many :payments
  has_many :transactions
  has_many :notifications
  has_many :courses_user_relations

  belongs_to :default_payment, class_name: 'Payment'

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

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
  
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email
      user = User.where(:email => email).first if email

      user_info = auth.extra.raw_info.name.split(' ')


      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          username: auth.uid,
          first_name: user_info[0],
          last_name: user_info[1],
          terms_of_service: true,
          email: email,
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def self.search(search)
    time = 6.month.ago
    User.joins("LEFT JOIN courses ON courses.user_id = users.id
            LEFT JOIN categories ON courses.categories_id = categories.id 
            LEFT JOIN ratings ON users.id = ratings.user_id AND ratings.updated_at >= '#{time}'")
    .where("lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(categories.name) LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    .group("users.id")
    .order("avg(ratings.value) ASC")
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def booked_number
    CoursesUserRelation.where(owner: self).where('created_at >= ?', 2.week.ago).count
  end

  def compatibility(user)
    a = []
    CategorysUsersRelation.where(user: user).each { |r| a << r.category_id } 
    
    a2 = []
    Course.where(user: self).each { |d| a2 << d.categories_id }

    com_count = 0

    a.each do |v| 
      com_count += 1 if a2.include?(v)
    end
    
    unless a.length == 0
      (com_count.to_f / a.length ) * 100
    else
      0
    end
  end

  def hold_transaction(course_id, payment_id)
    course = Course.find(course_id)
    payment = Payment.find(payment_id)
    BraintreeApi.new.hold_amount(course, payment)
  end

  def collect_transaction(transaction, noticification)
    BraintreeApi.new.collect_amount(transaction, noticification)
  end

  def release_transaction(transaction, noticification)
    BraintreeApi.new.release_amount(transaction, noticification)
  end

  def mentor_area_exist?(category)
    categories = Category.where(parent_id: category)
    Course.where(user: self, categories: categories).present?
  end

end
