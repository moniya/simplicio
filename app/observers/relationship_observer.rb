class RelationshipObserver < ActiveRecord::Observer
  def after_save(relationship)
    actor = relationship.user

    data = {
    }
    activity = ActivityBuilder.new.build(relationship, data, 'create_relationship', relationship.follow)
    activity.save
  end

end
