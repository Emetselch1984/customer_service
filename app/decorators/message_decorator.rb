class MessageDecorator < ApplicationDecorator
  def type
    case object
    when CustomerMessage
      '問い合わせ'
    when StaffMessage
      '返信'
    else
      raise
    end
  end

  def sender
    case object
    when CustomerMessage
      object.user.family_name + ' ' + object.user.given_name
    when StaffMessage
      object.user.family_name + ' ' + object.user.given_name
    else
      raise
    end
  end

  def receiver
    case object
    when CustomerMessage
      ''
    when StaffMessage
      object.user.family_name + ' ' + object.user.given_name
    else
      raise
    end
  end

  def truncated_subject
    h.truncate(subject, length: 20)
  end

  def formatted_body
    ERB::Util.html_escape(body).gsub(/\n/, '<br>').html_safe
  end

  def created_at
    if object.created_at > Time.current.midnight
      object.created_at.strftime('%H:%M:%S')
    elsif object.created_at > 5.months.ago.beginning_of_month
      object.created_at.strftime('%m/%d %H:%M')
    else
      object.created_at.strftime('%Y/%m/%d %H:%M')
    end
  end

  def tree
    expand(object.tree.root)
  end

  def formatted_body
    ERB::Util.html_escape(body).gsub(/\n/, '<br>').html_safe
  end

  private

  def expand(node)
    markup(:ul) do |m|
      m.li do
        if node.id == object.id
          m.strong(node.subject)
        else
          m << h.link_to(node.subject, h.staff_message_path(node))
        end
        node.child_nodes.each do |c|
          m << expand(c)
        end
      end
    end
  end
end
