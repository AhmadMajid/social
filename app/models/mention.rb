class Mention < ApplicationRecord
  belongs_to :vibration
  belongs_to :mentioned_user, class_name: "User"
end
