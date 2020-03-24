ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel t("labels.frequent_clients") do
          ul do
            Order.joins(:user).group("users.email").count.reverse_each do |k, v|
              li "#{k} / #{v} #{t("labels.orders")}"
            end
          end
        end
      end

      column do
        panel t("labels.betters_clients") do
          ul do
            Order.joins(:user).group("orders.user_id, users.email").select('SUM(total) as total, users.email').order('total desc').each do |u|
              li "#{u.email}: #{number_to_currency(u.total, locale: :en)} "
            end
          end
        end
      end

      column do
        panel t("labels.betters_ingredients") do
          ul do
            Pizza.joins(:ingredients).group("ingredients.name").count.sort_by{ |_, v| -v }.each do |k, v|
              li "#{k} / #{v} #{v > 1 ? "Pizzas" : "Pizza"} "
            end
          end
        end
      end

      controller do
        skip_before_filter :authorize_user!
      end
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    end
  end # content
end
