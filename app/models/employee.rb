class Employee < ApplicationRecord
  has_closure_tree

  belongs_to :user, optional: true

  validates :user_id, uniqueness: true, if: -> { user_id.present? }
  validates :name, presence: true
  validates :title, presence: true
end
