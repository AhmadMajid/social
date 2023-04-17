class VibrationActivity::VibrationedJob < ApplicationJob
  queue_as :default

  def perform(actor:, vibration:)
    vibration_activities = actor.followers.map do |follower|
      VibrationActivity.new(user: follower, actor: actor, vibration: vibration, verb: "vibrationed")
    end
    VibrationActivity.import vibration_activities, on_duplicate_key_ignore: true, batch_size: 500
  end
end
