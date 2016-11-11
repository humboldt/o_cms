module DeviseHelper
 def devise_error_messages!
  return '' if resource.errors.empty?

   html = <<-HTML
   
   <div class="alert alert-danger alert-dismissible" role="alert">
     <strong>Please correct the below errors.</strong>
   </div>
   HTML

   html.html_safe
 end
end