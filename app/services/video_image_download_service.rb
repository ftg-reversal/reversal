class VideoImageDownloadService
  class << self
    # @param url [String]
    # @return [StringIO, Tempfile, File]
    def fetch_file(url)
      url.nil? ? dummy_thumbnail : open(url)
    rescue OpenURI::HTTPError
      dummy_thumbnail
    end

    # @return [File]
    def dummy_thumbnail
      File.open(VideoConfig.dummy_thumbnail_filepath)
    end
  end
end
