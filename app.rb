require 'sinatra'
require 'pony'

configure do
  Pony.options = {
    :headers => { 'Content-Type' => 'text/html' },
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['apikey'],
      :password => ENV['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'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
end

get '/' do
  erb :index
end

post '/' do
  Pony.mail(
    :to => params[:to],
    :from => params[:from],
    :subject => params[:subject],
    :body => nl2br(params[:body])
  )
  @sent = true
  erb :index
end

def nl2br(string)
  string.gsub("\n\r","<br>").gsub("\r", "").gsub("\n", "<br />")
end
