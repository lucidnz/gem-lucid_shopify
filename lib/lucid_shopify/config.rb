# frozen_string_literal: true

require 'dry-initializer'

module LucidShopify
  NotConfiguredError = Class.new(StandardError)

  class Config
    extend Dry::Initializer

    # @return [String]
    param :api_key
    # @return [String]
    param :shared_secret
    # @return [String]
    param :scope
    # @return [String]
    param :billing_callback_uri
    # @return [String]
    param :webhook_uri
  end
end

class << LucidShopify
  extend Forwardable

  # TODO: *Config.dry_initializer.attributes (version 2.0.0+)
  def delegators :config, :api_key, :shared_secret, :scope, :billing_callback_uri, :webhook_uri

  # @param config [Config]
  attr_writer :config

  #
  # @return [Config]
  #
  # @raise [NotConfiguredError] if credentials are unset
  #
  def config
    raise NotConfiguredError unless @config

    @config
  end
end