class UsersControllerPolicy < ControllerBasePolicy
  def index?
    owner_or_admin?
  end

  def show?
    owner_or_admin?
  end

  def new?
    owner_or_admin?
  end

  def create?
    owner_or_admin?
  end

  def edit?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end
end
