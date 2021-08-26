module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescure500
    rescue_from ApplicationController::Forbidden, with: :rescure403
    rescue_from ApplicationController::IPAddressRejected, with: :rescure403
    rescue_from ActiveRecord::RecordNotFound, with: :rescure404
  end

  private
  def rescure500(e)
    render "errors/internal_server_error", status: 500
  end

  def rescure403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end
  
  def rescure404(e)
    render "errors/not_found", status: 404
  end

end