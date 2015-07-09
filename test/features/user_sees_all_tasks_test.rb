require_relative '../test_helper'

class UserSeesAllTasksTest < FeatureTest

  def test_home_page_displays_welcome_message
    visit("/")
    assert page.has_content?("Welcome to the Task Manager")
  end

  def test_user_can_fill_in_task_form
    visit("/")
    click_link("New Task")
    assert_equal  "/tasks/new", current_path
    fill_in("task[title]", with: "pizza")
    fill_in("task[description]", with: "more pizza")
    click_button("create")
    assert_equal "/tasks", current_path
    within(".container") do
      assert page.has_content?("pizza")
    end
  end

  def test_user_can_edit_a_task
    visit("/")
    click_link("New Task")
    assert_equal  "/tasks/new", current_path
    fill_in("task[title]", with: "pizza")
    fill_in("task[description]", with: "more pizza")
    click_button("create")
    visit("/tasks")
    click_link("edit")
    fill_in("task[title]", with: "sandwich")
    fill_in("task[description]", with: "lalala")
    click_button("edit")
    visit("/tasks")
    within(".container") do
      assert page.has_content?("sandwich")
    end
  end

  def test_user_can_delete_a_task
    visit("/")
    click_link("New Task")
    assert_equal  "/tasks/new", current_path
    fill_in("task[title]", with: "pizza")
    fill_in("task[description]", with: "more pizza")
    click_button("create")
    visit("/tasks")
    click_button("delete")
    assert_equal "/tasks", current_path
    within(".container") do
      refute page.has_content?("pizza")
    end
  end

end
