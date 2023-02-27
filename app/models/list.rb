class List < ApplicationRecord
  belongs_to :user
  has_many :media_lists, dependent: :destroy
  has_many :user_medias, through: :media_lists

  validates_presence_of :name, :user_id
end
