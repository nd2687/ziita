class BugReportsController < ApplicationController
  def index
    @bug_reports = BugReport.all
  end

  def new
    @bug_report = BugReport.new
  end

  def create
    @bug_report = BugReport.new(bug_report_params)
    if @bug_report.save
      flash.notice = "バグ報告をしていただきありがとうございます。"
      redirect_to :bug_reports
    else
      flash.now[:alert] = "バグ報告に失敗しました。"
      render action: "new"
    end
  end

  private
  def bug_report_params
    params.require(:bug_report).permit(
      :title, :body
    )
  end
end
