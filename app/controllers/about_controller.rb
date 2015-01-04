class AboutController < ApplicationController
  layout "html_page"

  def ziita
  end

  def bug
    @bug_reports = BugReport.all
  end

  def new_bug_report
    @bug_report = BugReport.new
  end

  def create_bug_report
    @bug_report = BugReport.new
    if @report_bug_form.save
      flash.notice = "バグ報告をしていただきありがとうございます。"
      redirect_to action: "bug"
    else
      flash.now[:alert] = "バグ報告に失敗しました。"
      render action: "new_bug_report"
    end
  end
end
