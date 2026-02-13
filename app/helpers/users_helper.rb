module UsersHelper
  ROLES = {
    "admin"=>"管理者",
    "owner"=>"店舗オーナー",
    "staff"=>"店舗スタッフ"
  }

  def roles_pulldown
    # 管理者の場合は全てのロール
    # owner の場合は、ownerとstaffのみ選択可能
    if current_user.admin?
      User.roles.keys.map { |r| [ ROLES[r], r ] }
    else
      %w[owner staff].map { |r| [ ROLES[r], r ] }
    end
  end

  def role_labels(role)
    ROLES[role]
  end

  def admin?
    current_user.admin?
  end
end
