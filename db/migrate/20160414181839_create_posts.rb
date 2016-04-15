class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string  :email
      t.string  :title
      t.string  :content
      
      # t.datetype => "5월 5일"
      t.timestamps null: false
    end
  end
end
