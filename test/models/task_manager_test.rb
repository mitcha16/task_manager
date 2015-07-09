require_relative '../test_helper'

class TaskManagerTest < Minitest::Test

  def test_it_creates_a_task
    TaskManager.create({ :title => "a title",
      :description => "a description"})
      task = TaskManager.all.first
      assert_equal "a title", task.title
      assert_equal "a description", task.description
    end

    def test_it_can_find_all_tasks
      3.times do
        TaskManager.create({:title => "a title",
          :description => "a description"})
        end
        assert_equal 3, TaskManager.all.size
      end

      def test_it_can_find_a_task_by_id
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        assert_equal "new title", TaskManager.find(TaskManager.all[1].id).title
      end

      def test_it_can_update_a_task
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        new_task = {:title => "newer title",
            :description => "another description"}
        TaskManager.update(TaskManager.all.first.id, new_task)
        assert_equal "newer title", TaskManager.all.first.title
      end

      def test_it_can_destroy_a_task
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        TaskManager.delete(TaskManager.all.last.id)
        assert_equal 1, TaskManager.all.size
      end

      def test_it_can_destroy_all_tasks
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        TaskManager.delete_all
        assert_equal 0, TaskManager.all.size
      end

end
