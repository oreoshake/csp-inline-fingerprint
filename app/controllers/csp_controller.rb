class CspController < ApplicationController
  HEADER_NAME = 'Content-Security-Policy'

  def index
    if Reports.where(user_agent: request.user_agent).count > 50
      render text: "Hey we already have enough data for your browser. Consider using another?" and return
    end

    response.headers[HEADER_NAME] = "default-src 'none'; frame-src 'self'; report-uri /csp/plugin?id=#{form_authenticity_token}"
  end

  def plugins
    log
  end

  def inline_script
    if request.get?
      set_csp('inline_script')
    else
      log
    end
  end

  def inline_event_handler
    if request.get?
      response.headers[HEADER_NAME] = "default-src 'none'; img-src https://blog.matatall.com/donkey; report-uri /csp/inline_event_handler?id=#{form_authenticity_token}"
    else
      log
    end
  end

  def image_litmus_test
    if request.get?
      set_csp('image_litmus_test')
    else
      log
    end
  end

  def inline_style
    if request.get?
      log
    else
      set_csp('inline_style')
    end
  end

  def javascript_href
    if request.get?
      set_csp('javascript_href')
    else
      log
    end
  end

  def eval
    if request.get?
      set_csp('eval')
    else
      log
    end
  end

  private

  def set_csp(designation)
    response.headers[HEADER_NAME] = "default-src 'none'; report-uri /csp/#{designation}?id=#{form_authenticity_token}"
  end

  def log
    body = if request.content_type == "application/csp-report"
      request.body.rewind
      request.body.read
    else
      request.body.read
    end

    Reports.create(user_agent: request.user_agent, classification: self.action_name, weak_id: params[:id], report: body)
    head :ok
  end
end
