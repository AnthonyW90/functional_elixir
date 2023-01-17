defmodule TaskListWithImport do
  # Import the File module so that we can use its functions without having to prefix them with File.
  # The number after the function name indicates the number of arguments that the function takes.
  # This is also known as the arity of the function.
  import File, only: [write: 3, read: 1]

  @file_name "task_list.txt"

  def add_task(task_name) do
    task = "[ ] " <> task_name <> "\n"
    write(@file_name, task, [:append])
  end

  def show_list do
    read(@file_name)
  end
end
