class Biz::BingliInfoController < ApplicationController
  require_role "user",:only=>[:input,:save,:add_favorite,:add_bingli_comment]
  def index
    #params[:keshi]=1 unless params[:keshi]
    @bingli_infos=BingliInfo.paginate :page=>params[:page],:order=>"id",:per_page => 5#,:conditions=>["keshi_id= ?",params[:keshi]]
    #@bingli_infos=BingliInfo.find(:all,:conditions=>["keshi_id= ?",params[:keshi]])
  end

  def showOne
    @bingli_info=BingliInfo.find(params[:id],:include=>[:bingli,:user])
    @bingli=@bingli_info.bingli
    @bingli_comments=BingliComment.paginate :conditions=>["bingli_info_id =:bingli_info_id",{:bingli_info_id=>params[:id]}],:per_page=>10,:page=>params[:page]
    @user=@bingli_info.user
  end

  def input

  end
  def add_favorite
    current_user.favorites << BingliInfo.find(params[:id])
   # current_user.save
  end
  def save
        @bingli=Bingli.new(params[:bingli])
		
        process_yiwen params,@bingli
        process_chubu params,@bingli
        process_fuzhu params,@bingli unless params[:fuzhu].blank?
params[:bingli_info][:catelog_id]=0
        @bingli.bingli_info=BingliInfo.new(params[:bingli_info])
        @bingli.bingli_info.user=current_user
        @bingli.bingli_info.thetime=Time.new
        process_bingli_info params,@bingli
        if  @bingli.save 
		flash[:success]="病例发布成功！"
          redirect_to :action=>"showOne",:id=>@bingli.bingli_info.id
#        show '发表成功',{:action=>"showOne",:id=>@bingli.bingli_info.id}
#        return;
        else
         render :action=>"input"
        end
  end
  private
  def process_fuzhu(params,bingli)
     params[:fuzhu].each {|fu|
        f=fu[1]
        f['file'].delete_if{|temp|temp.blank?} if !f['file'].nil?
        if(f.blank? or f['fuzhu_type'].blank? or (f['content'].blank? and f['file'].nil?))then next end
          fuzhu=FuzhuDetail.new(:fuzhu_type_id=>f['fuzhu_type'],:content=>f['content'])
          f['file'].each{|file|
          if(file.blank?)then next end
          pic=Attachment.new({'uploaded_data'=>file})
          fuzhu.attachments << pic
          }
          bingli.fuzhu_details << fuzhu
        }
  end
  def process_chubu(params,bingli)
        params[:chubu].each {|c|
        if c.blank? then next end
        bingli.chubu_has=1
        bingli.chubu_details << ChubuDetail.new(:content=>c)
        }
  end
  def process_yiwen(params,bingli)
        params[:yiwen].each {|q|
        if(q.blank?)then next end
        bingli.yiwen_has=1
        bingli.question_details << QuestionDetail.new(:content=>q)
        }
  end
  def process_bingli_info(params,bingli)
        bingli.bingli_info.tags << Tag.find(params[:tags]['already']) unless params[:tags]['already'].blank?
        params[:tags]['custom'].split(/,|，/).each{|t|
        t.strip!
        tag=Tag.exists?(:name=>t)?Tag.find(:first,:conditions=>["name=:title",{:title=>t}]):Tag.create(:name=>t)
        bingli.bingli_info.tags << tag unless bingli.bingli_info.tags.include? tag

        }
        
  end
end
