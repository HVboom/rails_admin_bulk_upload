require "rails_admin_bulk_upload/engine"

module RailsAdminBulkUpload
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class BulkUpload < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-upload'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          Proc.new do
            @response = {}

            if request.post?
              #if @object.update(:pictures_attributes => params[:gallery][:pictures_attributes])
              if @object.update(params.require(:gallery).permit(:name,
                                      { pictures_attributes: [:title, :image, :position, :gallery_id, :id, :_destroy] }))
                flash.now[:success] = "Upload done!"
              end
              
              #@gallery = Gallery.find_by_id(params[:gallery_id])
              #@gallery.update_attribute(:pictures_attributes, params[:gallery][:pictures_attributes])

              #obj = Model.find_by_id(params[:id])
              #obj.update_attributes(attributes)

              #@gallery = Gallery.new(params[:gallery])
              #if @gallery.save
                #redirect_to action: "index"
              #end

              #results = @abstract_model.model.run_import(params)

              #@response[:notice] = results[:success].join("<br />").html_safe if results[:success].any?
              #@response[:error] = results[:error].join("<br />").html_safe if results[:error].any?
            end

            render :action => @action.template_name
          end
        end

      end
    end
  end
end

