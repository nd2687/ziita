class User::DraftsController < User::Base
  def index
    @drafts = current_user.drafts
  end

  def show
    @draft = current_user.drafts.find_by_access_token(params[:access_token])
    unless @draft
      redirect_to [ :user, :drafts ]
      return false
    end
  end

  def update
    @draft = current_user.drafts.find_by_access_token(params[:access_token])
    unless @draft
      redirect_to [ :user, :drafts ]
      return false
    end
    if @draft.update_attribute(:published, true)
      flash.notice = "下書き記事を公開しました。"
      redirect_to [ :user, :drafts ]
    else
      flash.alert = "処理に失敗しました。"
      redirect_to :back
    end
  end

  def destroy
    @draft = current_user.drafts.find_by_access_token(params[:access_token])
    unless @draft
      redirect_to [ :user, :drafts ]
      return false
    end
    if @draft.destroy
      flash.notice = "下書き記事を削除しました。"
      redirect_to [ :user, :drafts ]
    else
      flash.alert = "下書き記事の削除に失敗しました。"
      redirect_to :back
    end
  end
end
