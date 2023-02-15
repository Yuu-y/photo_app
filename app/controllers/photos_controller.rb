class PhotosController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  
  before_action :logged_in_user, only:[:index, :new, :create, :upload_to_app]
  
  def index
    @photos = Photo.where(user_id: current_user.id).order(created_at: "DESC")
  end
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.new(photos_params)
    @photo[:user_id] = current_user.id
    if @photo.save
      redirect_to photos_index_path
    else
      flash[:danger] = []
      @photo.errors.each do |message|
        flash[:danger] << message.options[:with] ||= message.options[:message]
      end
      redirect_to photos_new_path
    end
  end
  
  def upload_to_app
    photo_id = params[:id].to_i
    @photo = Photo.find(photo_id) if photo_id > 0
    if upload_image(@photo)
      flash[:notice] = []
      flash[:notice] << 'ツイートが完了しました。'
      redirect_to root_path
    end
  end
  
  private
  def photos_params
    params.require(:photo).permit(:user_id, :title, :image)
  end
  
  def upload_image(photo)
    uri = ::URI.parse('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets')
    req = ::Net::HTTP::Post.new(uri)
    req['Authorization'] = "Bearer #{session[:access_token]}"
    req['Content-Type'] = 'application/json'
    img_url = "localhost:3000#{Rails.application.routes.url_helpers.rails_blob_path(photo.image, only_path: true)}"
    item = {
      "text": photo.title,
      "url": img_url
    }
    req.body = JSON.generate item
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
    	http.request(req)
    end
    res.is_a?(::Net::HTTPSuccess) ? res.body : res.error!
  end
end
