class UploadImage
  def self.call(env)
    new(env).call
  end

  def initialize(env)
    @env = env
  end
  
  def call
    uploader = PostImageUploader.new
    minimagick_image_path = Pathname.new MiniMagick::Image.read(blob).path
    filepath = minimagick_image_path.dirname + filename
    filepath = filepath.sub_ext("#{Time.now.to_i}_#{@env['action_dispatch.remote_ip'].to_s.gsub(/\./, '')}" + filepath.extname)
    minimagick_image_path.rename filepath
    file = File.open(filepath)
    uploader.store!(file)

    [200, {"Content-Type" => "application/json"}, [{ success: true, imagelocation: uploader.to_s }.to_json]]
  end

  def blob
    @env["rack.input"].read
  end

  def filename
    @env["QUERY_STRING"][/qqfile=([^&]+)/, 1]
  end
end