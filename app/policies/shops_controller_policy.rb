class ShopsControllerPolicy < ControllerBasePolicy
  def index?
    only_admin?
  end

  def show?
    only_admin?
  end

  def new?
    only_admin?
  end

  def create?
    only_admin?
  end

  def edit?
    only_admin?
  end

  def update?
    only_admin?
  end

  def destroy?
    only_admin?
  end
end
