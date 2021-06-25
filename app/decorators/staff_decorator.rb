class StaffDecorator < ApplicationDecorator
  def suspended_mark
    if object.suspended?
      h.raw('&#x2611;')
    else
      h.raw('&#x2610;')
    end
  end
end
