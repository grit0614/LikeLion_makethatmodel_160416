require 'mailgun'

class HomeController < ApplicationController
  
  def index
    
  end
  
  def write
    @one_post = Post.new
    @one_post.email = params[:email] 
    @one_post.title = params[:title]
    @one_post.content = params[:content]

    # Try sending an e-mail only if checkbox is checked
    # Q. How do I check whether the checkbox has been selected or not??
    
    # if params[:checkbox] == true
        mg_client = Mailgun::Client.new("key-8eeac9ac9b7aeb89b7c08e688bdfba47")
    
        message_params =  {
                     from: 'no-reply@pick.me',
                     to:   @one_post.email,
                     subject: @one_post.title,
                     text:    @one_post.content
                    }
    
        result = mg_client.send_message('sandbox525c248fee904feba716a989e9b7b3ad.mailgun.org', message_params).to_h!
    
        message_id = result['id']
        message = result['message']
        
        
    # end
    
    @one_post.save
    
    
    # 위에 있는것들 다 마치고 "/list"로 자동이동
    redirect_to "/list"
  end
  
    def list
      @every_post = Post.all
    end
    
    def destroy
      # 1. view에서 "/destroy/<%= p.id %>"로 링크 만듦
      # 2. route에서 '/destroy/:post_id' => 'home#destroy'로 맵핑
      #  2-1. 따라서 <%= p.id %> = :post_id가 된다. ( [:xxx] = 파라메터 변수 )
      # 3. 이 컨트롤러에서 DB에서 primary key로 질의한 결과를 변수에 저장
      @one_post = Post.find(params[:post_id])
      # 4. ㅃ2
      @one_post.destroy
      # 5. /list로 가버렷!
      redirect_to "/list"
    end
    
    # update는 수정할 form을 줄 페이지, 그걸 넘겨줄 페이지까지
    # 총 2개를 만들어야 함
    
    def update_prompt
      @one_post = Post.find(params[:post_id])
    end
    
    def update_confirm
      @one_post = Post.find(params[:post_id])
      
      # 다시 parameter들 땡겨와서 저장해야하니 불러오자
      @one_post.email = params[:email]
      @one_post.title = params[:title]
      @one_post.content = params[:content]
      
      # 다 땡겨왔으니 저장
      @one_post.save
      
      # 볼일끝ㅋ ㅃ2
      redirect_to "/list"
      
    end
end
