class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.string :descricao
      t.boolean :solucionado
      t.string :solucao
      t.belongs_to :projeto, foreign_key: true

      t.timestamps
    end
  end
end
