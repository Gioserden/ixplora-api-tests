require 'bson'
require 'mongo'
require 'singleton'

# Turn off debug-mode
Mongo::Logger.logger.level = Logger::WARN

# Class for MongoDB connection and query manager
class MongoDBConnection
  include Mongo
  include Singleton

  def initialize
    start_connection
  end

  def find_by_id(id, document_name)
    result = {}
    @client[document_name.to_sym].find(_id: BSON::ObjectId(id)).each do |data|
      result = data
    end

    result
  end

  def find_by_user_id(id, document_name)
    result = {}
    @client[document_name.to_sym].find(userId: id).each do |data|
      result = data
    end
    result
  end

  def start_connection
    client_host = ["#{$mongodb_host}:#{$mongodb_port}"]
    client_options = { database: $mongodb_db_name,
                       user: $mongodb_username,
                       password: $mongodb_password }
    @client = Mongo::Client.new(client_host, client_options)
  end

  def close_connection
    @client.close
  end
end

p MongoDBConnection.instance.find_by_user_id('59d4029e64c0be0665de1dc3', 'email_tokens')['token']
#p MongoDBConnection.instance.find_by_id('59d4029e64c0be0665de1dc3', 'users')