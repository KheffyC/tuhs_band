module Admin
  class GalleriesController < Admin::ApplicationController
    def upload_image
      Gallery.find(params[:id])

      unless params[:image].present?
        return render json: { error: "No image provided" }, status: :bad_request
      end

      file = params[:image]
      if file.size > 10.megabytes
        return render json: { error: "File too large. Max 10MB." }, status: :unprocessable_entity
      end

      content_type = file.content_type.to_s
      unless content_type.start_with?("image/")
        return render json: { error: "Only image files allowed" }, status: :unprocessable_entity
      end

      begin
        filename = file.original_filename.presence || "gallery-upload-#{Time.current.to_i}.jpg"

        blob = ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: filename,
          content_type: content_type
        )

        url = url_for(blob)

        render json: { url: url, blob_signed_id: blob.signed_id, status: "success" }, status: :ok
      rescue => e
        render json: { error: "Upload failed: #{e.message}" }, status: :internal_server_error
      end
    end

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

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
