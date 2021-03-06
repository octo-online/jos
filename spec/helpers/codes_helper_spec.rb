require 'rails_helper'

RSpec.describe CodesHelper, type: :helper do
  describe "display summary" do

    describe "with no link to articles" do
      before do
        section1 =Section.new(title: "1")
        section1_1 =Section.new(title: "1.1")
        section1_2_old =Section.new(title: "1.2 old")
        section1_2 =Section.new(title: "1.2")

        section_link1_1 = SectionLink.new(source:section1, target:section1_1, order: 1, state: 'ABROGE_DIFF')
        section_link1_2 = SectionLink.new(source:section1, target:section1_2, order: 2, state: 'VIGUEUR')

        section1.section_links_preloaded << section_link1_2 << section_link1_1

        section2 =Section.new(title: "2")
        sections=[section1, section2]

        @summary = display_summary(sections, 'accordion')
      end

      it "display one ul li by level in the right order" do
        expect(@summary).to eq("<ul id='accordion' class='nav'><li><a href='#'>1</a><ul id='' class='nav'><li><a href='#'>1.1</a></li><li><a href='#'>1.2</a></li></ul></li><li><a href='#'>2</a></li></ul>")
      end
    end

    describe 'display summary' do
      before do
        section1 =Section.create(title: "1")
        article = Article.create()
        section_article_link = SectionArticleLink.create(section: section1, article: article)

        section1.section_article_links_preloaded << section_article_link

        sections=[section1]
        @summary = display_summary(sections)
      end

      context "with one section article" do

        it "display one ul li by level with a for link" do
          expect(@summary).to eq("<ul id='' class='nav'><li><a href=\"/sections/1\">1</a></li></ul>")
        end
      end

    end
  end
end
