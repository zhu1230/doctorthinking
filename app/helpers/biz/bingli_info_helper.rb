module Biz::BingliInfoHelper
	def build_fuzhu
	@bingli_info.build_bingli if @bingli_info.bingli.blank?
	fd=	@bingli_info.bingli.fuzhu_details.build(){|fd|fd.new_by_build=true}
	fd.attachments.build 
	@bingli_info.bingli.chubu_details.build(){|fd|fd.new_by_build=true}
	@bingli_info.bingli.question_details.build(){|fd|fd.new_by_build=true}
	end
	
end
