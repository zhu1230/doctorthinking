class BugReportObserver < ActiveRecord::Observer
	# def after_save(br)
	# 	p "save "+br.to_s
	# end
	
	def after_create(br)
		BugReportMailer.deliver_new_bug(br)
	end
	
	
end
