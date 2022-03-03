class User < ApplicationRecord
  has_many :domains

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable, :recoverable, :validatable
  devise :database_authenticatable, :rememberable, :confirmable, :recoverable, :registerable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  include SoftDelete

  scope :order_by_name, -> { order(:last_name, :first_name) }

  scope :role_filter, ->(name) do
    case name
    when 'user'  then where(owner: false)
    when 'owner' then where(owner: true)
    else all
    end
  end

  scope :search, ->(query) do
    if query.present?
      where(
        "first_name ILIKE :query OR
         last_name  ILIKE :query OR
         email      ILIKE :query",
        query: "%#{query}%"
      )
    else
      all
    end
  end

  def name
    "#{last_name}, #{first_name}"
  end

end
