class Helper
  attr_reader :user

  def initialize user
    @user = user
  end

  def home *args
    File.join('/home', @user, *args)
  end
end
