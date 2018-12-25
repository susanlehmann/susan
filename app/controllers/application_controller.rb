class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit
  helper_method :current_account
  helper_method :eth_usd
  #before_action :set_locale

  protected

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end

  def current_account
    @current_account ||= begin
      if session[:account_id]
        Account.find_by(id: session[:account_id])
      end
    end
  end

  def authenticate_user!
    if current_account.blank?
      redirect_to login_path, notice: t("login_first")
    end
  end

  def attach_transaction_to(object)
    tx = Transaction.make_by_address(params[:tx_hash])
    tx.update!(transactable: object)
    tx.transactable = object
    object.tx = tx
    object.transact
    object.save
    render json: { transaction: { id: tx.id, url: transaction_path(tx) } }
  end

  def user_for_paper_trail
    current_account ? current_account.hash_address : nil
  end

  def eth_usd
    @eth_usd ||= Networker.eth_usd
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options options = {}
    {locale: I18n.locale}
  end
end
