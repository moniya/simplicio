class ActivityBuilder
  def build(model, data, kind, recipient=nil)
    activity = Activity.new
    activity.user_id =model.user.id
    activity.username = model.user.full_name
    activity.email = model.user.email
    activity.kind = kind
    activity.data = data
    activity.recipient = recipient if recipient

    activity
  end
end