class AddCourseStart < ActiveRecord::Migration
  def change
    add_column :orders, :course_start, :date
    add_column :orders, :course_end, :date
  end
end
