class ApplicationDecorator < Draper::Decorator
  delegate_all
  include HtmlBuilder
  include Sorcery
end
