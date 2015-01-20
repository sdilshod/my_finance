class ChangeSource < ActiveRecord::Migration
  def up
    add_column :operations, :source_temp, :integer

    o = Operation.all
    o.each do |e|
      if e.source == 'Наличка'
        e.source_temp = 1
      else
        e.source_temp = 2
      end
      e.save
    end

    remove_column :operations, :source

    rename_column :operations, :source_temp, :source
    change_column :operations, :source, :integer, null: false
  end

  def down
    add_column :operations, :source_temp, :string

    o = Operation.all
    o.each do |e|
      if e.source == 1
        e.source_temp = 'Наличка'
      else
        e.source_temp = 'Пл.карта'
      end
      e.save
    end

    remove_column :operations, :source

    rename_column :operations, :source_temp, :source
    change_column :operations, :source, :string, null: false
  end
end
