class Admin::BugReportsController < Admin::Base
  def index
    @bug_reports = BugReport.all
  end

  def update
    @bug_report = BugReport.find(params[:id])
    @bug_report.assign_attributes(bug_report_params)
    if @bug_report.save
      flash.notice =  "バグを修正済みにしました。"
    else
      flash.now[:alert] = "バグを修正済みにできませんでした。"
    end
    redirect_to :admin_bug_reports
  end

  private
  def bug_report_params
    params.require(:bug_report).permit(
      :completable
    )
  end
end
