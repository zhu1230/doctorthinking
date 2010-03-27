class Misc::SearchController < ApplicationController
  
  def index
  end
  
  def do_search
    @bingli_infos = case params[:type]
  when "tag" then @bingli_infos=BingliInfo.paginate_by_sql(["SELECT * FROM tags_bingli_infos t right join bingli_infos t2 on (t.bingli_info=t2.id) where tag_id=:tag_id",{:tag_id=>params[:id]}],:page => params[:page], :per_page => 3)
    render :template => "misc/search/do_search"
    return
      when "fine" then BingliInfo.paginate(:page=>params[:page],:conditions=>["rank_num>=#{AppConfig[:fineNum]} and rank_num < #{AppConfig[:perfectNum]} and keshi_id=?",params[:keshi]])
    when "perfect" then BingliInfo.paginate(:page=>params[:page],:per_page=>10,:conditions=>["rank_num>=#{AppConfig[:perfectNum]} and keshi_id = ?",params[:keshi]])
       when "hot" then BingliInfo.paginate(:page=>params[:page],:per_page=>10,:conditions=>["keshi_id = ?",params[:keshi]],:order=>"bingli_comments_count desc")
      when "favorite" then current_user.favorites 
      when "mine" then BingliInfo.paginate(:page=>params[:page],:per_page=>10,:conditions=>["user_id=:user_id and keshi_id=:keshi_id",{:user_id=>current_user.id,:keshi_id=>params[:keshi]}])
      when "participation" then 
      @bingli_comments=BingliComment.paginate(:page=>params[:page],:per_page=>10,:conditions=>["user_id=:user_id and keshi_id=:keshi_id",{:user_id=>current_user.id,:keshi_id=>params[:keshi]}],:group => "bingli_info_id")
    end
    render :template => "biz/bingli_info/index"
end
def content
  @bingli_info=BingliInfo.paginate(:page=>params[:page],:conditions=>["title like :search",{:search=>'%'+params[:search_content]+'%'}]) 
    render :template => "misc/search/do_search"
end
end
