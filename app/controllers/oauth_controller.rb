class OauthController < ApplicationController
  require 'net/http'
  
  def new
    uri = ::URI.parse('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize')
    callback_oauth_url = 'http://localhost:3000/oauth/callback'
    params = {
      client_id: Rails.application.credentials.my_tweet_app[:client_id],
      scope: 'write_tweet',
      redirect_uri: callback_oauth_url,
      response_type: 'code',
    }
    uri.query = ::URI.encode_www_form(params)

    redirect_to uri.to_s, allow_other_host: true
  end

  def callback
    if params[:code].blank?
      flash[:alert] = [] 
      flash[:alert] << '連携がキャンセルされました。'
      redirect_to root_url
    end
    callback_oauth_url = 'http://localhost:3000/oauth/callback'
    uri = ::URI.parse('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token')
    params_data = {
      code: params[:code],
      client_id: Rails.application.credentials.my_tweet_app[:client_id],
      client_secret: Rails.application.credentials.my_tweet_app[:client_secret],
      grant_type: 'authorization_code',
      redirect_uri: callback_oauth_url,
    }
    res = ::Net::HTTP.post_form(uri, params_data)

    result = ::JSON.parse(res.body)
    session[:access_token] = result['access_token']
    flash[:notice] = [] 
    flash[:notice] << '連携に成功しました。'
    redirect_to root_url
  end
end
