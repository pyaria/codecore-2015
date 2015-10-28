require 'sinatra'
require 'sinatra/reloader'

enable :sessions

get "/" do
  session[:numbers] = @team_numbers
  session[:team] = @team_names

  erb :index, layout: :layout
end

post "/" do
  @team_names = params["names"].split(",")
  @team_numbers = params["number"].to_i
  if @team_numbers > @team_names.length
    return @errormessage = "ERROR. Please enter a lower number of teams or give me more names"
  else
    @team_names.shuffle!
  end

  session[:numbers] = @team_numbers
  session[:team] = @team_names
  erb :index, layout: :layout
end
#
# <% for i in 1..@team_names.length do %>
#   <table>
#     <tr>
#     <% for i in 1..@team_numbers do %>
#       <td><%= @team_names.pop %></td>
#     <% end %>
#     </tr>
#   </table>
# <% end %>
