class User < ApplicationRecord
  include SoftDeletable

  # ------ associations ------
  has_many :habits, dependent: :destroy
  has_many :habit_logs

  #------- regex ----------
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  # ------ validations ------

  has_secure_password
  validates :password,
            presence: true,
            format: {
              with: PASSWORD_FORMAT,
              message: 'should contain uppercase, lowercase, digit and a symbol. Between 6 and 40 characters long'
            },
            length: { within: 6..40, message: 'password too short' },
            on: :create

  validates :password,
            format: {
              with: PASSWORD_FORMAT,
              message: 'should contain uppercase, lowercase, digit and a symbol. Between 6 and 40 characters long'
            },
            length: { within: 6..40 },
            allow_blank: true,
            on: :update

  validates :email, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX }


  validates_presence_of :first_name

  before_save :to_lowercase

  def as_json(options = {})
    options[:except] ||= %i[password_digest deleted]
    super(options)
  end

  private

  def to_lowercase
    email.downcase!
  end
end
