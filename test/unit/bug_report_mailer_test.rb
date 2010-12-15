require 'test_helper'

class BugReportMailerTest < ActionMailer::TestCase
  test "new_bug" do
    @expected.subject = 'BugReportMailer#new_bug'
    @expected.body    = read_fixture('new_bug')
    @expected.date    = Time.now

    assert_equal @expected.encoded, BugReportMailer.create_new_bug(@expected.date).encoded
  end

end
