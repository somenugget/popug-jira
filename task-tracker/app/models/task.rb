class Task < ApplicationRecord
  include HasPublicId

  belongs_to :assignee, optional: true, class_name: 'User'

  def todo?
    status == 'todo'
  end

  def completed?
    status == 'completed'
  end

  def assigned_on?(user)
    assignee == user
  end
end
