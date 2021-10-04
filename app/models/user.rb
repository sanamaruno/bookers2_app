class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「followed」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :followed
  # ========================================================================================

  # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollowed_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id
  # 中間テーブルを介して「follower」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :follower
  # =======================================================================================

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザーがフォローされているユーザー(つまりpassive)の中から
    # 引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(follower_id: user.id).present?
  end


  attachment :profile_image

  validates :name, {uniqueness: true, length: {minimum:2, maximum:20}}
  validates :introduction, length: {maximum:50}



end
