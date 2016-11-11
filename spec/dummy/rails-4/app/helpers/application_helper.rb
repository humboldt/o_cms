module ApplicationHelper
  def roles_for_select
    Role.not_admin
  end
end
