#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


class BugReportsController < ApplicationController

  require_role 'admin',:except => [:new,:create]  
  
  def index
    @bug_reports = BugReport.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bug_reports }
      format.json  { render :json => @bug_reports }
    end
  end


  def show
    @bug_report = BugReport.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bug_report }
      format.json  { render :json => @bug_report }
    end
  end


  def new
    @bug_report = BugReport.new
session[:return_to] ||= request.referer
  end


  def edit
    @bug_report = BugReport.find(params[:id])
  end


  def create
    @bug_report = BugReport.new(params[:bug_report])
    if logged_in?
      @bug_report.user_id = current_user.id
    end
    respond_to do |format|
      if @bug_report.save
        flash[:notice] = '十分感谢您对医思网的支持，您的问题建议已成功提交，我们会尽快处理及改进.'
        format.html { redirect_back_or_default('/') }
        format.xml  { render :xml => @bug_report, :status => :created, :location => @bug_report }
        format.json  { render :json => @bug_report, :status => :created, :location => @bug_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bug_report.errors, :status => :unprocessable_entity }
        format.json  { render :json => @bug_report.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @bug_report = BugReport.find(params[:id])
    respond_to do |format|
      if @bug_report.update_attributes(params[:bug_report])
        flash[:notice] = 'BugReport was successfully updated.'
        format.html { redirect_to(@bug_report) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bug_report.errors, :status => :unprocessable_entity }
        format.json  { render :json => @bug_report.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @bug_report = BugReport.find(params[:id])
    @bug_report.destroy
    respond_to do |format|
      format.html { redirect_to(bug_reports_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
