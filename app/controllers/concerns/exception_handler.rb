# frozen_string_literal: true

# Handling controller errors
# https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one
# redirect to current page:
# https://stackoverflow.com/questions/17601397/redirect-to-current-page-rails
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |err|
      respond_to do |format|
        format.html { generic_html_error(err) }
        format.js { generic_js_error(err) }
        format.json { generic_json_error(err, :not_found) }
      end
    end

    rescue_from ActiveRecord::RecordInvalid do |err|
      respond_to do |format|
        format.html { generic_html_error(err) }
        format.js { generic_js_error(err) }
        format.json { generic_json_error(err, :unprocessable_entity) }
      end
    end
  end

  private

  def generic_html_error(err)
    flash[:danger] = err.message
    redirect_back(fallback_location: get_fallback_path)
  end

  def generic_js_error(err)
    flash[:danger] = err.message
    redirect_back(fallback_location: get_fallback_path)
  end

  def generic_json_error(err, status)
    render json: {message: err.message}, status: status
  end

  def get_fallback_path
    path = request.path
    # check if path matches an entity path
    return catalogs_path if path.start_with?(catalogs_path)
    return articles_path if path.start_with?(articles_path)

    # über fallback
    root_path
  end
end
