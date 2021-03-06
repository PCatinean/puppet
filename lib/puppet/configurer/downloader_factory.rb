require 'puppet/configurer'

# Factory for <tt>Puppet::Configurer::Downloader</tt> objects.
#
# Puppet's pluginsync facilities can be used to download modules
# and external facts, each with a different destination directory
# and related settings.
#
# @api private
#
class Puppet::Configurer::DownloaderFactory
  def create_plugin_downloader(environment)
    plugin_downloader = Puppet::Configurer::Downloader.new(
      "plugin",
      Puppet[:plugindest],
      Puppet[:pluginsource],
      Puppet[:pluginsignore],
      environment
    )
  end

  def create_plugin_facts_downloader(environment)
    source_permissions = Puppet.features.microsoft_windows? ? :ignore : :use

    plugin_fact_downloader = Puppet::Configurer::Downloader.new(
      "pluginfacts",
      Puppet[:pluginfactdest],
      Puppet[:pluginfactsource],
      Puppet[:pluginsignore],
      environment,
      source_permissions
    )
  end

  def create_locales_downloader(environment)
    locales_downloader = Puppet::Configurer::Downloader.new(
      "locales",
      Puppet[:localedest],
      Puppet[:localesource],
      Puppet[:pluginsignore] + " config.yaml",
      environment
    )
  end
end
