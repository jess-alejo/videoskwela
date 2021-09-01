class AddWorkflowStateToCourses < ActiveRecord::Migration[6.1]
  def up
    add_column :courses, :workflow_state, :string
    add_index :courses, :workflow_state

    Course.update_all(workflow_state: 'draft')
  end

  def down
    remove_column :courses, :workflow_state
  end
end
