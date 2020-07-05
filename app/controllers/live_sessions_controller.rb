class LiveSessionsController < ApplicationController

  def attend_session
    @meeting = Meeting.find(params[:record_id])
  end

    def get_signature
        time = (Time.now.to_i * 1000 - 30000).to_s
        data = Base64.urlsafe_encode64(<zoom_api_key> + params[:meeting_number] + time + params[:role].to_s)
        hash = Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), <zoom_api_secret>, data))
        tempStr = <zoom_api_key> + '.' + params[:meeting_number] + '.' + time + '.' + params[:role].to_s + '.' + hash
        signature = Base64.urlsafe_encode64(tempStr).gsub('+', '-').gsub('/', '_').gsub(/#{Regexp.escape('=')}+$/, '')

        render json: {signature: signature, meetingNumber: params[:meeting_number], apiKey: <zoom_api_key>, userName: params[:username], userEmail: params[:email], password: params[:password] }
    end
    
end
