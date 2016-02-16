require "picfit/version"
require "picfit/configuration"
require "picfit/client"

module Picfit
  extend Configuration

  def self.init(options={})
    @client = Picfit::Client.new(options)
  end

  # Get the common client
  def self.client
    @client ||= init
  end

  # Set the common client
  def self.client=(client)
    @client = client
  end

  # Delegate to Picfit::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Picfit::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end

end
