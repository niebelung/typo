 require 'spec_helper'

describe Admin::ContentController do
  
#  render_views
  
  describe "non-admin's attempt to merge articles" do

    before :each do
      Factory(:blog) if Blog.count == 0
      @user = Factory(:user,
                     :login => 'vasja',
                     :profile => Factory(:profile_publisher))
      @article_from = Factory(:article, 
                             :author => 'vasja', 
                             :body => 'My name is vasja!')
      @article_to   = Factory(:article, 
                             :author => 'petja', 
                             :body => 'My name is petja!')
      request.session = {:user => @user.id}
    end

    it "should generate a flash message" do
      post :merge, {:id => @article_from.id, :merge_with => @article_to.id}
      response.should redirect_to "/admin/content/edit/#{@article_from.id}"
      flash.now[:error].should == "Error, only admin may merge articles!"
    end
  
  end
  
  describe "admin's attempt to merge articles" do

    before :each do
      Factory(:blog) if Blog.count == 0
      @user = Factory(:user,
                      :login => 'admin',
                      :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      @article_from = Factory(:article, 
                             :author => 'vasja', 
                             :title => 'Vasja article',
                             :body => 'My name is vasja!')
      @article_to   = Factory(:article, 
                             :author => 'petja',
                              :title => 'Petja article',
                             :body => 'My name is petja!')

      @comment_from = Factory(:comment,
                              :article_id => @article_from.id,
                              :author => 'petja',
                              :body => 'This is comment by petja!')
      @comment_to = Factory(:comment,
                              :article_id => @article_to.id,
                              :author => 'vasja',
                              :body => 'This is comment by vasja!')
      request.session = {:user => @user.id}
    end

    it "should invoke merge_with model method" do
      #Article.find(@article_from.id).merge_with(@article_to.id)
      post :merge, {:id => @article_from.id, :merge_with => @article_to.id}
      #assigns(:article).reload
      #@article.reload
      assigns(:article).comments.count.should == 2
      assigns(:article).body.should include('My name is vasja!')      
      assigns(:article).body.should include('My name is petja!')
      assigns(:article).author.should == 'petja'
      assigns(:article).title.should == 'Petja article'
      response.should redirect_to "/admin/content/edit/#{@article_to.id}"
      flash.now[:notice].should == "Successfully merged!"
    end
  
  end
end
  
