class ImageDownloadService
  class << self
    # @param url [String]
    # @return [StringIO, Tempfile, File]
    def fetch_file(url)
      open(url)
    rescue OpenURI::HTTPError
      dummy_thumbnail
    end

    # @return [File]
    def dummy_thumbnail
      File.open(VideoConfig.dummy_thumbnail_filepath)
    end

    private

    # @param file [StringIO, Tempfile, File]
    # @return [Boolean]
    def remote_file?(file)
      file.respond_to?(:status) && file.status.first.to_i == 200
    end

    # @param file [StringIO, Tempfile, File]
    # @return [Boolean]
    def local_file?(file)
      file.is_a?(File)
    end
  end
end
