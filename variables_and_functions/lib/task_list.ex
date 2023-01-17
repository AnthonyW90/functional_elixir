defmodule TaskList do
  # @file_name is a module attribute. It is a constant that is available to all functions in the module.
  @file_name "task_list.txt"

  def add_task(task_name) do
    task = "[ ] " <> task_name <> "\n"
    File.write(@file_name, task, [:append])
  end

  def show_list do
    File.read(@file_name)
  end
end
