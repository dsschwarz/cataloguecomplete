class CreateArticlesTagsTable < ActiveRecord::Migration
  def self.up
    create_table :articles_tags, :id => false do |t|
        t.references :article
        t.references :tag
    end
    add_index :articles_tags, [:article_id, :tag_id], unique: true
  end

  def self.down
    drop_table :articles_tags
  end
end
