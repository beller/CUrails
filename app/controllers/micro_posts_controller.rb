class MicroPostsController < ApplicationController

  before_filter :redirect_unless_authorized, only: [:edit, :update, :destroy]
  
  # GET /micro_posts
  # GET /micro_posts.json
  def index
    @micro_posts = MicroPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @micro_posts }
    end
  end

  # GET /micro_posts/1
  # GET /micro_posts/1.json
  def show
    @micro_post = MicroPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @micro_post }
    end
  end

  # GET /micro_posts/new
  # GET /micro_posts/new.json
  def new
    @micro_post = MicroPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micro_post }
    end
  end

  # GET /micro_posts/1/edit
  def edit
    @micro_post = MicroPost.find(params[:id])
  end

  # POST /micro_posts
  # POST /micro_posts.json
  def create
	@micro_post = current_user.micro_posts.build(params[:micro_post])
	
    respond_to do |format|
      if @micro_post.save
        format.html { redirect_to @micro_post, notice: 'Micro post was successfully created.' }
        format.json { render json: @micro_post, status: :created, location: @micro_post }
		format.js {render partial: 'micro_posts/show'}
      else
        format.html { render action: "new" }
        format.json { render json: @micro_post.errors, status: :unprocessable_entity }
		format.js {render partial: 'micro_posts/errors'}
      end
    end
  end

  # PUT /micro_posts/1
  # PUT /micro_posts/1.json
  def update

    respond_to do |format|
      if @micro_post.update_attributes(params[:micro_post])
        format.html { redirect_to @micro_post, notice: 'Micro post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @micro_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /micro_posts/1
  # DELETE /micro_posts/1.json
  def destroy
    @micro_post.destroy

    respond_to do |format|
      format.html { redirect_to micro_posts_url }
      format.json { head :no_content }
	  format.js { render partial: 'micro_posts/destroy'}
    end
  end
  
  private 
  def redirect_unless_authorized
    @micro_post = MicroPost.find(params[:id])
	unless signed_in? && current_user == @micro_post.user
		flash[:error] = "You are not authorized to edit that Micropost."
		redirect_to root_path
	end
  end
end
