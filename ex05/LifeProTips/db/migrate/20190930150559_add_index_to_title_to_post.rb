class AddIndexToTitleToPost < ActiveRecord::Migration
  def change
    def self.up
      add_index :posts, :title, :unique => true
    end

    def self.down
      remove_index :posts, :title
    end
  end

end
