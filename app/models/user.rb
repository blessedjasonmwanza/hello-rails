class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :likes
  validates :name, presence: true
  validates :bio, presence: true
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  
  Roles = [ :admin, :default]

  def is?(requested_role)
    self.role == requested_role.to_s
  end
  def recent_posts
    posts.limit(3).order(created_at: :desc)
  end
end
