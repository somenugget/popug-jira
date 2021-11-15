class Task < ApplicationRecord
  include HasPublicId

  belongs_to :assignee, optional: true, class_name: 'User'
end
