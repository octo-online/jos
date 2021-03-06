require 'rails_helper'
require './lib/logic/map/jorf/jstruct_map'

def fake_jtext_file
  <<-FOO
  <TEXTELR>
  <META>
    <META_COMMUN>
      <ID>JORFTEXT000030611441</ID>
      <ID_ELI>http://www.legifrance.gouv.fr/eli/decret/2015/5/18/AGRS1501735D/jo/texte</ID_ELI>
      <ELI_ALIAS>
        <ID_ELI_ALIAS>http://www.legifrance.gouv.fr/eli/decret/2015/5/18/2015-543/jo/texte</ID_ELI_ALIAS>
      </ELI_ALIAS>
      <ANCIEN_ID/>
      <ORIGINE>JORF</ORIGINE>
      <URL>texte/struct/JORF/TEXT/00/00/30/61/14/JORFTEXT000030611441.xml</URL>
      <NATURE>DECRET</NATURE>
    </META_COMMUN>
    <META_SPEC>
      <META_TEXTE_CHRONICLE>
        <CID>JORFTEXT000030611441</CID>
        <NUM>2015-543</NUM>
        <NUM_SEQUENCE>25</NUM_SEQUENCE>
        <NOR>AGRS1501735D</NOR>
        <DATE_PUBLI>2015-05-19</DATE_PUBLI>
        <DATE_TEXTE>2015-05-18</DATE_TEXTE>
        <ORIGINE_PUBLI>JORF n°0114 du 19 mai 2015</ORIGINE_PUBLI>
        <PAGE_DEB_PUBLI>8438</PAGE_DEB_PUBLI>
        <PAGE_FIN_PUBLI>8439</PAGE_FIN_PUBLI>
      </META_TEXTE_CHRONICLE>
    </META_SPEC>
  </META>
  <VERSIONS>
    <VERSION etat="VIGUEUR">
      <LIEN_TXT debut="2015-05-20" fin="2999-01-01" id="LEGITEXT000030611706" num="2015-543"/>
    </VERSION>
    <VERSION etat="">
      <LIEN_TXT debut="2999-01-01" fin="2999-01-01" id="JORFTEXT000030611441" num="2015-543"/>
    </VERSION>
  </VERSIONS>
  <STRUCT>
    <LIEN_ART debut="2999-01-01" etat="" fin="2999-01-01" id="JORFARTI000030611446" num="1" origine="JORF"/>
    <LIEN_ART debut="2999-01-01" etat="" fin="2999-01-01" id="JORFARTI000030611449" num="2" origine="JORF"/>
    <LIEN_SECTION_TA cid="JORFSCTA000030611232" debut="2999-01-01" etat="" fin="2999-01-01" id="JORFSCTA000030611232" niv="1" url="/JORF/SCTA/00/00/30/61/12/JORFSCTA000030611232.xml">Annexe</LIEN_SECTION_TA>
  </STRUCT>
</TEXTELR>
  FOO
end

describe 'mapping of jorftext' do

  context "when we have one jorftext" do

    before do
      @jtext_map = JstructMap.parse(fake_jtext_file, :single => true)
      @jtext = @jtext_map.to_jtext
    end

    it 'maps correctly the jorftext' do
      expect(@jtext.id_jorftext_origin).to  eq("JORFTEXT000030611441")
      expect(@jtext.nature).to   eq("DECRET")
      expect(@jtext.sequence_number).to   eq(25)
      expect(@jtext.nor).to   eq("AGRS1501735D")
      expect(@jtext.publication_date).to   eq("2015-05-19")
      expect(@jtext.text_date).to   eq("2015-05-18")
    end

    it 'maps correctly the jarticle links' do
      expect(@jtext_map.link_text_article_maps.length).to  eq(2)
      expect(@jtext_map.link_text_article_maps[0].id_jarticle_origin).to  eq("JORFARTI000030611446")
      expect(@jtext_map.link_text_article_maps[0].number).to  eq("1")
    end

    it 'maps correctly the jsection link' do
      expect(@jtext_map.link_text_section_maps.length).to  eq(1)
      expect(@jtext_map.link_text_section_maps[0].id_jsection_origin).to  eq("JORFSCTA000030611232")
    end

    describe "#to_jtext_jarticle_link_hashes" do
      before do
        @hashes = @jtext_map.to_jtext_jarticle_link_hashes
      end

      it 'hash correctly the links' do
        expect(@hashes.length).to   eq(2)
        expect(@hashes[0][:id_jtext_origin]).to   eq("JORFTEXT000030611441")
        expect(@hashes[0][:id_jarticle_origin]).to   eq("JORFARTI000030611446")
      end
    end

    describe "#to_jtext_jsection_link_hashes" do
      before do
        @hashes = @jtext_map.to_jtext_jsection_link_hashes
      end

      it 'hash correctly the link' do
        expect(@hashes.length).to   eq(1)
        expect(@hashes[0][:id_jtext_origin]).to   eq("JORFTEXT000030611441")
        expect(@hashes[0][:id_jsection_origin]).to   eq("JORFSCTA000030611232")
      end
    end

  end

end


