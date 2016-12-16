class AddViewToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :page_view, :integer
  end
end
