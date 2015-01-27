module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

#  def flash_messages(opts = {})
#    flash.each do |msg_type, message|
#      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
#              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
#              concat message
#            end)
#    end
#    nil
#  end

  #TODO if flash message only one not need to struct large content
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(
              content_tag :div, nil,
                          class: "alert #{bootstrap_class_for(msg_type)} fade in",
                          data: {message: message},
                          style: 'display: none;'
            )
    end
    nil
  end

  def flash_errors(object)
    return nil if object.errors.messages.blank?
    concat(content_tag(:div, class: "alert #{bootstrap_class_for('alert-danger')} fade in") do
      concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
      object.errors.messages.each do |field, messages|
        concat content_tag(:p, "field:- #{field}")
        concat(content_tag(:ul) do
          messages.each {|e| concat content_tag(:li, e) }
        end)
       end
    end)
    nil
  end

  def title_of_object_form(object)
    object.new_record? ? 'Новый запись' : 'Редактировать запись'
  end
end
