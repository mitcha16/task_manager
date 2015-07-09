class TaskManager

  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager_development.sqlite3")
    end
  end

  def self.create(task)
    begin
    data_set.insert(title: task[:title],
                    description: task[:description])
    rescue
      return false
    end
    Task.new(data_set.to_a.last)
  end

  def self.all
    data_set.to_a.map {|data| Task.new(data)}
  end

  def self.find(id)
    Task.new(data_set.where(:id => id).first)
  end

  def self.update(id, task)
    data_set.where(:id => id).update(task)
  end

  def self.delete(id)
    data_set.where(:id => id).delete
  end

  def self.delete_all
    data_set.delete
  end

  def self.data_set
    database.from(:tasks)
  end

end
