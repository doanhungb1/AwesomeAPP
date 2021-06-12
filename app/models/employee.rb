class Employee < ApplicationRecord
  has_closure_tree

  belongs_to :user, optional: true
end
