class Biz::CommentsController < ApplicationController
	require_role 'user',:except => [:index]
  def index
  end

  def new
  end

  def create
	
  end

  def edit
  end

  def update
	
  end

  def destroy
  end

end
