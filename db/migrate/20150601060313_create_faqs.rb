class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :content

      t.timestamps
    end
  end
end
