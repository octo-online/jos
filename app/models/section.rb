class Section < ActiveRecord::Base
  belongs_to :code
  has_and_belongs_to_many :articles

  has_many :section_links, foreign_key: :source_id
  has_many :section_article_links

  attr_accessor :sections

  after_initialize do
    @sections=[]
  end

  def self.with_article_displayable id
    section = Section.includes(:articles).find id
    section.articles = section.articles.select {|a| a.state == 'VIGUEUR' || a.state == 'ABROGE_DIFF' }
    section
  end

end
