# frozen_string_literal: true

ActiveAdmin.register Ingredient do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :name, :price, :image

  form partial: 'form'

  show do
    attributes_table do
      row :name
      row :price
      row :image do |ad|
        if ad.image.attachment
          image_tag url_for(ad.image)
        end
      end
    end
  end
end
