class Admins::SessionsController < Devise::SessionsController
  def destroy
    super do
      return redirect_to new_admin_session_path
    end
  end
end
