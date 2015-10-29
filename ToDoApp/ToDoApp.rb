#/* gem */
require "sinatra"
require "sinatra/reloader"
require "data_mapper"

# Dir.pwd -> gives us current directory of this file (SinatraApp.rb)
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/tasks.db")

class Task
  #uses DataMapper to map class Task to table in database
  include DataMapper::Resource

  #Serial => INTEGER PRIMARY KEY AUTOINCREMENT
  property(:id, Serial)

  property(:taskname, Text)
  property(:complete, String)
  property(:created_at, DateTime)

end

DataMapper.auto_upgrade!

get "/" do
  erb :index, layout: :app_layout
end

get "/tasks" do
  @tasklist = []
  @completetasks = []
  @alltasks = Task.all
  @alltasks.each do |task|
    if task.complete == "Incomplete"
      @tasklist.push(task)
    elsif task.complete == "Complete"
      @completetasks.push(task)
    end
  end
  erb :tasks, layout: :app_layout
end

post "/tasks" do
  task=Task.create({
    taskname: params["taskname"],
    complete: "Incomplete",
    created_at: Time.now,
    })
  @newtask=task.taskname
  @tasklist = []
  @completetasks = []
  @alltasks = Task.all
  @alltasks.each do |task|
    if task.complete == "Incomplete"
      @tasklist.push(task)
    elsif task.complete == "Complete"
      @completetasks.push(task)
    end
  end
  erb :tasks, layout: :app_layout
end

post "/update" do
  @task = Task.get(params["_method"])
  @task.update(complete: "Complete")
  @tasklist = []
  @completetasks = []
  @alltasks = Task.all
  @alltasks.each do |task|
    if task.complete == "Incomplete"
      @tasklist.push(task)
    elsif task.complete == "Complete"
      @completetasks.push(task)
    end
  end
  erb :tasks, layout: :app_layout
end

post "/change" do
  @task = Task.get(params["_method"])
  @task.update(complete: "Incomplete")
  @tasklist = []
  @completetasks = []
  @alltasks = Task.all
  @alltasks.each do |task|
    if task.complete == "Incomplete"
      @tasklist.push(task)
    elsif task.complete == "Complete"
      @completetasks.push(task)
    end
  end
  erb :tasks, layout: :app_layout
end
