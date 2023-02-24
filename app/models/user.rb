class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :media_lists, through: :lists
  has_many :user_medias, through: :media_lists

  validates_presence_of :email, :sub, :picture, :name
end
