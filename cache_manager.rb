require 'redis'
require 'digest'

class CacheManager
  attr_accessor :logger
  # url looks like "redis://:p4ssw0rd@10.0.1.1:6379/0"
  # username, password
  def initialize(url)
    @redis = Redis.new(url: url)
  end

  # Is this connected
  def connected?
    return false if @redis.nil?

    @redis.ping
    return true
  rescue StandardError => e
    @logger&.error 'Error seeing if connected in cache manager'
    return false
  end

  # Get cached value
  def get_cached(src)
    return nil unless self.connected?
    @redis.get(Digest::MD5.hexdigest(src))
  rescue StandardError => e
    @logger&.error 'Error getting cached value from cache manager'
    return nil
  end

  # Set cache value
  def set_cached(src, diss)
    @redis.set(Digest::MD5.hexdigest(src), diss)
  rescue StandardError => e
    @logger&.error 'Error setting cached value from cache manager'
    return nil
  end
end
