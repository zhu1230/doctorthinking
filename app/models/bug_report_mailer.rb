class BugReportMailer < ActionMailer::Base
	def init
    # @network = Network.find(:first)
    @urls = 'http://www.doctorthinking.com/'
    @network_name = '医思网'
    @admin_email = 'zhu1230@gmail.com'
  end
  

  def new_bug(br)
	init
    subject    '新问题提交'
    recipients @admin_email
    from       'doctorthinking@gmail.com'
    sent_on    Time.now
    
    body       :greeting => br.description,:bug_report => br
  end

end
