class AwardPointsPolicy
  def self.build_from_env(user, request)
    self.new(user, request, Integer(ENV.fetch('REQUEST_RECENCY_THRESHOLD_HOURS')).hours)
  end

  def initialize(user, request, request_recency_threshold_seconds)
    @user = user
    @request = request
    @request_recency_threshold_seconds = request_recency_threshold_seconds
  end

  def should_award_points?
    return false if @user.banned?
    return false if @request.created_at < @request_recency_threshold_seconds.ago

    @user.can_vote?(@request)
  end
end
