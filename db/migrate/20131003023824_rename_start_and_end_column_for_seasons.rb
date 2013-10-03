class RenameStartAndEndColumnForSeasons < ActiveRecord::Migration
  def up
    rename_column :seasons, :start, :start_date
    rename_column :seasons, :end, :end_date
  end

  def down
    rename_column :seasons, :start_date, :start
    rename_column :seasons, :end_date, :end
  end
end
