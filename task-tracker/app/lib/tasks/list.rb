module Tasks
  class List
    ORDER_CONDITION = Arel.sql(" CASE WHEN status = 'todo'::varchar THEN 0 ELSE 1 END, created_at DESC")

    def call(user: nil)
      Task.order(ORDER_CONDITION).then do |tasks|
        user ? tasks.where(assignee: user) : tasks
      end
    end
  end
end
