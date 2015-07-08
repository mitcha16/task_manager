require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def test_it_creates_a_task
    TaskManager.create({ :title => "a title",
      :description => "a description"})
      task = TaskManager.find(1)
      assert_equal "a title", task.title
      assert_equal "a description", task.description
      assert_equal 1, task.id
    end

    def test_it_can_find_all_tasks
      3.times do
        TaskManager.create({:title => "a title",
          :description => "a description"})
        end
        assert_equal 3, TaskManager.all.size
      end

      def test_it_can_find_all_task
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        assert_equal "new title", TaskManager.find(2).title
      end

      def test_it_can_update_a_task
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        new_task = {:title => "newer title",
            :description => "another description"}
        TaskManager.update(2, new_task)
        assert_equal "newer title", TaskManager.find(2).title
      end

      def test_it_can_destroy_a_task
        TaskManager.create({:title => "a title",
          :description => "a description"})
        TaskManager.create({:title => "new title",
          :description => "another description"})
        TaskManager.delete(2)
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
