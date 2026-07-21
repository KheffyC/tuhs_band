module Admin
  class FundraisersController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Please note: Administrate fully supports namespaced models. Ensure that your
    # resources are configured with their fully-namespaced model.
    #
    # eg.
    #
    #   resources :posts, namespace: :admin do
    #     resources :comments, namespace: :admin
    #   end
  end
end
