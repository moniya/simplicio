# encoding: utf-8

class PostImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "postimages"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

end
