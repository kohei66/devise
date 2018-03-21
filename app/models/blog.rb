class Blog < ApplicationRecord
  enum status: {on_hold: 0, Unapproved: 1, approved: 2 }
  belongs_to :user
end
