class CustomerDecorator < ApplicationDecorator
  def full_name
    "#{object.family_name} #{object.given_name}"
  end

  def full_name_kana
    "#{object.family_name_kana} #{object.given_name_kana}"
  end

  def birthday
    return '' if object.birthday.blank?

    object.birthday.strftime('%Y/%m/%d')
  end

  def gender
    case object.gender
    when 'male'
      '男性'
    when 'female'
      '女性'
    else
      ''
    end
  end

  def created_at
    object.created_at.try(:strftime, '%Y/%m/%d %H:%M:%S')
  end

  def update_at
    object.updated_at.try(:strftime, '%Y/%m/%d %H:%M:%S')
  end

  def personal_phones
    object.personal_phones.map(&:number)
  end

  def phones
    object.phones.map(&:number)
  end
end
