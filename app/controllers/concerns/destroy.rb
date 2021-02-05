require "active_support/concern"

module Destroy
  extend ActiveSupport::Concern
  
  def destroy_cascada(objects,message_sucess="",message_error="")
        if !objects.empty?
          objects .each do |object|
            object.destroy
          end
          flash[:notice] = t(:sucess, action: :eliminar, models: message_sucess)
        else
          flash[:alert] = t(:error, action: :eliminar, models: message_error)
        end
  end

end