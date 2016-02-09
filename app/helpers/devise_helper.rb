module DeviseHelper
	def devise_error_messages!
		return "" if !defined?(resource) || resource.errors.empty?
		flash.now[:danger] = resource.errors.full_messages.join('<br />')
	end
end