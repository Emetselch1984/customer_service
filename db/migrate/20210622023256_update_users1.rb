class UpdateUsers1 < ActiveRecord::Migration[6.1]
  def up
    execute('
      UPDATE users SET birth_year = EXTRACT(YEAR FROM birthday),
        birth_month = EXTRACT(MONTH FROM birthday),
        birth_mday = EXTRACT(DAY FROM birthday)
        WHERE birthday IS NOT NULL
    ')
  end

  def down
    execute('
      UPDATE users SET birth_year = NULL,
      birth_month = NULL,
      birth_mday = NULL
    ')
  end
end
