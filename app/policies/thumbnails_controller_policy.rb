class ThumbnailsControllerPolicy < ControllerBasePolicy
  def destroy?
    owner_or_admin?
  end
end
