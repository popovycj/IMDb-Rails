class User < ApplicationRecord
  has_many :ratings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  def rating(movie_id)
    ratings.find_by(movie_id: movie_id)&.score || 0
  end
end
