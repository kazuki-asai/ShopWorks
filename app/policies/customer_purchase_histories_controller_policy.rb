class CustomerPurchaseHistoriesControllerPolicy < ControllerBasePolicy
  def index?
    all_actions?
  end

  def show?
    all_actions?
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
