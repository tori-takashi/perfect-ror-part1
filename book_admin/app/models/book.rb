class Book < ActiveRecord::Base
    scope :costly, -> { where("price > ?", 3000)}
    scope :written_about, -> (theme){ where("name like '#{theme}'")}
    default_scope -> { order("price DESC")}

    belongs_to :publisher
    
    has_many :book_authors
    has_many :authors, through: :book_authors

    validates :name, presence: true
    validates :name, length: { maximum: 15 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validate do |book|
        if book.name.include?("ピーポくん")
            book.errors[:name] << "そんな本があるはずありません"
        end
    end

    before_validation :replace_vim

    def replace_vim
        self.name = self.name.gsub(/emacs/) do
            "vim"
        end
    end
end