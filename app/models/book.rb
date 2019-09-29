class Book < ApplicationRecord
	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
		#user_idはbookのid、user.idはuserのidを特定するため？
		#bookにつけられた「favorite」に自分が含まれるかを判断する為につけている
	end

	validates :title, presence: true
	validates :body, presence: true,
	           length: { maximum: 200 }
end
