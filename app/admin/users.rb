# frozen_string_literal: true

ActiveAdmin.register User do
  filter :email

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :superadmin, label: 'Super Administrator'
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: %i[email password password_confirmation
                             authenticity_token user commit locale]
    end
  end
end
