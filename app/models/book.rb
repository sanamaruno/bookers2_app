class Book < ApplicationRecord

    belongs_to :user

    validates :title, presence: true
    validates :body, {presence:true, lengh: {maximum:200}}

end
