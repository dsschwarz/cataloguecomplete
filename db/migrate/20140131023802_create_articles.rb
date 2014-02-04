class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

    	t.references :user
    	t.string :picture

      t.timestamps
    end
  end
end
