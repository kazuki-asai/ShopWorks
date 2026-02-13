class CustomersControllerPolicy < ControllerBasePolicy
  def index?
    owner_or_admin?
  end

  def show?
    owner_or_admin?
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
    owner_or_admin?
  end
end
