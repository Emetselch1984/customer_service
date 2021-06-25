class StaffEventDecorator < ApplicationDecorator
  def table_row
    markup(:tr) do |m|
      m.td description
      m.td(class: 'date') do
        m.text occurred_at.strftime('%Y/%m/%d %H:%M:%S')
      end
    end
  end
end
