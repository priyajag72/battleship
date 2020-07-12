class Game

  attr_reader :user, :auto

  def initialize(user, auto)
    @user = user
    @auto = auto
  end
end
