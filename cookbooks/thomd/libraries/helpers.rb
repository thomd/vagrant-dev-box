module Thomd
  class Helper
    attr_reader :user, :ruby_version

    def initialize ruby_version, user
      @ruby_version = ruby_version
      @user = user
    end

    def home *args
      File.join('/home', @user, *args)
    end
  end
end
