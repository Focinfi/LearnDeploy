# encoding: utf-8
class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :qiniu

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "public/images"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
    # base_url = "/images/place_example.png"
    # ip = 'http://localhost:1234'
    # if ENV['ALIYUN_FOCI']
    #   ip = Settings.aliyun_foci_ip
    # elsif ENV['CENTOS']
    # end
    # ip + base_url
    'http://7xiwsa.com2.z0.glb.qiniucdn.com/uploads%2Flibrary.png?e=1430997501&token=oDzI0sgiK40RaXTm_fne0yIgNvFZajLpwmmCSJe_:8vttC164BawEVd2hgPRd_8QYggE='
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
