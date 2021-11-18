class Task < ApplicationRecord
  belongs_to :assignee, optional: true, class_name: 'User'
end
