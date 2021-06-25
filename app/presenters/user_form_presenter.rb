class UserFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    super(name, label_text, options) if object.new_record?
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: 'input_block') do |m|
      m << decorated_label(name1, label_text, options)
      m << text_field(name1)
      m << text_field(name2)
      m << error_messages_for(name1)
      m << error_messages_for(name2)
    end
  end
end
