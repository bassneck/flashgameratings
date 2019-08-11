class SubmitNewGamePolicy
  def self.build_from_env(user)
    self.new(user, Integer(ENV.fetch('SUBMIT_NEW_GAME_MINIMUM_RATING')))
  end

  attr_reader :minimum_rating

  def initialize(user, minimum_rating)
    @user = user
    @minimum_rating = minimum_rating
  end

  def can_submit_new_game?
    @user.points >= minimum_rating
  end
end
