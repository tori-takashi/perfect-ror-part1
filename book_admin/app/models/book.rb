class Book < ActiveRecord::Base
    enum status: [:reservation, :now_on_sale, :end_of_print]

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

    def high_price?
        self.price >= 5000
    end
    
    before_validation :replace_vim
    before_validation :if => :high_price? do |book|
        puts "お前そんな高い本買ったの？"
    end

    def replace_vim
        self.name = self.name.gsub(/emacs/) do
            "vim"
        end
    end

end