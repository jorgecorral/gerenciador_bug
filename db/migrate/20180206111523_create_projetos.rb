class CreateProjetos < ActiveRecord::Migration[5.1]
  def change
    create_table :projetos do |t|
      t.string :nome
      t.string :descricao
      t.string :link

      t.timestamps
    end
  end
end
