module ApplicationHelper
  def custom_webpack_asset_paths(source)
    return '' unless source.present?
    Webpack::Rails::Manifest.asset_paths(source)
  end
end
