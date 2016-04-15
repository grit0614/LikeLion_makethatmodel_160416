require 'mailgun'

class HomeController < ApplicationController
  
  def index
    
  end
  
  def write
    write_post = Post.new
    write_post.email = params[:email] 
    write_post.title = params[:title]
    write_post.content = params[:content]
    
    mg_client = Mailgun::Client.new("key-8eeac9ac9b7aeb89b7c08e688bdfba47")

    message_params =  {
                 from: 'no-reply@pickme.up',
                 to:   params[:email],
                 subject: params[:title],
                 text:    params[:content]
                }

    result = mg_client.send_message('sandbox525c248fee904feba716a989e9b7b3ad.mailgun.org', message_params).to_h!

    message_id = result['id']
    message = result['message']
    
    puts message_id
    puts message
    
    write_post.save
    
    # 위에 있는것들 다 마치고 "/list"로 자동이동
    redirect_to "/list"
  end
  
    def list
      
      @every_post = Post.all
      
    end

end
