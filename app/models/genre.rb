class Genre < ApplicationRecord
    has_many :post, dependent: :destroy
end
