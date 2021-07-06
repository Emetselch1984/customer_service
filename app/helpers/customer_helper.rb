module CustomerHelper
  include HtmlBuilder

  def number_of_unprocessed_messages
    markup do |m|
      m.a(href: inbound_customer_messages_path) do
        m << '新規問い合わせ'
        anchor_text =
          if (c = StaffMessage.unprocessed.count) > 0
            "(#{c})"
          else
            ''
          end
        m.span(
          anchor_text,
          id: 'number-of-unprocessed-staff-messages',
          'data-path' => customer_message_count_path
        )
      end
    end
  end
  def customer_message_title
    case params[:action]
    when "index"; "全メッセージ一覧"
    when "inbound"; "受信メッセージ一覧"
    when "outbound"; "送信メッセージ一覧"
    when "deleted"; "ゴミ箱"
    else; raise
    end
  end
  def customer_message_title
    case params[:action]
    when "index"; "全メッセージ一覧"
    when "inbound"; "受信メッセージ一覧"
    when "outbound"; "送信メッセージ一覧"
    when "deleted"; "ゴミ箱"
    else; raise
    end
  end
end
