class ControllerBasePolicy < ApplicationPolicy
  def index?
    all_actions?
  end

  def show?
    all_actions?
  end

  def create?
    all_actions?
  end

  def new?
    all_actions?
  end

  def update?
    all_actions?
  end

  def edit?
    all_actions?
  end

  def destroy?
    all_actions?
  end

  private

  def all_actions?
    user.present?
  end

  def owner_or_admin?
    user.owner? || user.admin?
  end

  def only_admin?
    user.admin?
  end
end
