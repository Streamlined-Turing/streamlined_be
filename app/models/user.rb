class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :media_lists, through: :lists
  has_many :user_medias, through: :media_lists

  validates_presence_of :email, :sub, :picture, :name

  after_create :create_default_lists


  def media_ids_for(list_name)
    list_medias = user_medias.where('lists.name ILIKE ?', list_name).pluck(:media_id)
  end

  def has_list_name?(list_name)
    if lists.find_by('name ILIKE ?', list_name)
      true
    else 
      false
    end
  end

  def currently_watching
    lists.find_by('name = ?', "Currently Watching").user_medias
  end

  def want_to_watch
    lists.find_by('name = ?', "Want to Watch").user_medias
  end

  def watched
    lists.find_by('name = ?', "Watched").user_medias
  end

  private

  def create_default_lists
    lists.create(name: 'Want to Watch')
    lists.create(name: 'Currently Watching')
    lists.create(name: 'Watched')
  end
end
