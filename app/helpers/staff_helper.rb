module StaffHelper
  include HtmlBuilder

  def number_of_unprocessed_messages
    markup do |m|
      m.a(href: inbound_staff_messages_path) do
        m << '新規問い合わせ'
        anchor_text =
          if (c = CustomerMessage.unprocessed.count) > 0
            "(#{c})"
          else
            ''
          end
        m.span(
          anchor_text,
          id: 'number-of-unprocessed-messages',
          'data-path' => staff_message_count_path
        )
      end
    end
  end
  def staff_message_title
    case params[:action]
    when "index"; "全メッセージ一覧"
    when "inbound"; "問い合わせ一覧"
    when "outbound"; "返信一覧"
    when "deleted"; "ゴミ箱"
    else; raise
    end
  end
end
