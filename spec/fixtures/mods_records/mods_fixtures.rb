# encoding: UTF-8
module ModsFixtures
  def mods_001
    <<-xml
      <?xml version="1.0" encoding="UTF-8"?>
      <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.3" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">
        <titleInfo>
          <title>Reproduction from the Official Map of San Francisco, Showing the District Swept...</title>
        </titleInfo>
        <titleInfo type="alternative">
          <title>San Francisco District Swept by Fire, 1906 (reproduction)</title>
        </titleInfo>
        <name>
          <namePart>B. Smith</namePart>
          <role>
            <roleTerm authority="marcrelator" type="text">Producer</roleTerm>
          </role>
        </name>
        <typeOfResource>still image</typeOfResource>
        <originInfo>
          <dateIssued>copyright 1906</dateIssued>
        </originInfo>
        <subject>
          <topic authority="lcsh">1906 Earthquake</topic>
        </subject>
        <genre authority="lcsh">Photographs</genre>
        <physicalDescription>
          <form>offset lithograph on paper</form>
          <note displayLabel="Dimensions">13-1/4 x 10 inches</note>
          <note displayLabel="Condition">good</note>
        </physicalDescription>
        <abstract displayLabel="Description">Topographical and street map of the western part of the city of San Francisco, with red indicating fire area. Annotations: “Area, approximately 4 square miles”; entire title reads: “Reproduction from the Official Map of San Francisco, Showing the District Swept by Fire of April 18, 19, 20, 1906.”</abstract>
        <tableOfContents>This is an amazing table of contents!</contents>
        <identifier type="local">rd-412</identifier>
        <relatedItem type="host">
          <titleInfo>
            <title>Reid W. Dennis collection of California lithographs, 1850-1906</title>
          </titleInfo>
          <identifier type="uri">http://purl.stanford.edu/sg213ph2100</identifier>
          <typeOfResource collection="yes" />
        </relatedItem>
        <accessCondition type="useAndReproduction">Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.</accessCondition>
        <accessCondition type="copyright">Copyright © Stanford University. All Rights Reserved.</accessCondition>
      </mods>
    xml
  end

  def mods_only_title
    <<-xml
      <?xml version="1.0" encoding="UTF-8"?>
      <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.3" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">
        <titleInfo>
          <title>Reproduction from the Official Map of San Francisco, Showing the District Swept...</title>
        </titleInfo>
        <titleInfo type="alternative">
          <title>San Francisco District Swept by Fire, 1906 (reproduction)</title>
        </titleInfo>
      </mods>
    xml
  end

  def mods_everything
    <<-xml
      <?xml version="1.0" encoding="UTF-8"?>
      <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.3" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">
        <titleInfo>
          <title>A record with everything</title>
        </titleInfo>
        <titleInfo type="alternative">
          <title>A record</title>
        </titleInfo>
        <name>
          <namePart>J. Smith</namePart>
          <role>
            <roleTerm authority="marcrelator" type="text">Author</roleTerm>
          </role>
        </name>
        <name>
          <namePart>B. Smith</namePart>
          <role>
            <roleTerm authority="marcrelator" type="text">Producer</roleTerm>
          </role>
        </name>
        <typeOfResource>still image</typeOfResource>
        <originInfo>
          <dateIssued>copyright 2014</dateIssued>
        </originInfo>
        <language displayLabel="Lang">
          <languageTerm type="text">Esperanza</languageTerm>
        </language>
        <physicalDescription>
          <note displayLabel="Condition">amazing</note>
        </physicalDescription>
        <subject>
          <topic authority="lcsh">Cats</topic>
          <topic authority="lcsh">Rules</topic>
          <topic authority="lcsh">Everything</topic>
        </subject>
        <abstract>Nunc venenatis et odio ac elementum. Nulla ornare faucibus laoreet</abstract>
        <targetAudience displayLabel="Who?">Cat loverz</targetAudience>
        <note>Pick up milk</note>
        <note displayLabel="Notez">Pick up milkz</note>
        <relatedItem>
          <titleInfo>
            <title>The collection of everything</title>
          </titleInfo>
          <identifier type="uri">http://fakeurl.stanford.edu/abc123</identifier>
          <typeOfResource collection="yes" />
        </relatedItem>
        <identifier type="uri">http://www.myspace.com/myband</identifier>
        <location>
          <physicalLocation displayLabel="Secret Location">NorCal</physicalLocation>
        </location>
        <accessCondition type="copyright">Copyright © Stanford University. All Rights Reserved.</accessCondition>
      </mods>
    xml
  end

  def mods_file
    <<-xml
      <?xml version="1.0" encoding="UTF-8"?>
      <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.3" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">
      <titleInfo>
        <title>This is a file</title>
      </titleInfo>
      <titleInfo type="alternative">
        <title>A file</title>
      </titleInfo>
      <abstract>Nunc venenatis et odio ac elementum. Nulla ornare faucibus laoreet</abstract>
      <typeOfResource>stuff</typeOfResource>
      <name>
        <namePart>J. Smith</namePart>
        <role>
          <roleTerm authority="marcrelator" type="text">Author</roleTerm>
        </role>
      </name>
      </mods>
    xml
  end

  def dms_mods_001
    <<-xml
    <?xml version="1.0" encoding="UTF-8"?>
    <mods xmlns="http://www.loc.gov/mods/v3">
      <titleInfo authority="Corpus Christi College">
        <title>Old English Homilies, mostly by Ælfric</title>
      </titleInfo>
      <titleInfo authority="James Catalog" type="alternative">
        <title>Homiliae Saxonicae (IV)</title>
      </titleInfo>
      <name type="corporate">
        <namePart>Worcester</namePart>
        <role>
          <roleTerm type="text">originator</roleTerm>
        </role>
      </name>
      <name type="corporate">
        <namePart>Worcester</namePart>
        <role>
          <roleTerm type="text">originator</roleTerm>
        </role>
      </name>
      <typeOfResource manuscript="yes">text</typeOfResource>
      <language>
        <languageTerm type="text">Old English and Latin.</languageTerm>
      </language>
      <physicalDescription>
        <form authority="marcform">electronic</form>
        <reformattingQuality>preservation</reformattingQuality>
        <internetMediaType>image/tif</internetMediaType>
        <internetMediaType>image/jp2</internetMediaType>
        <digitalOrigin>reformatted digital</digitalOrigin>
      </physicalDescription>
      <subject authority="lcsh">
        <topic>Manuscripts</topic>
        <geographic>Great Britain</geographic>
      </subject>
      <location>
        <url>http://parkerweb.stanford.edu/</url>
      </location>
      <relatedItem type="host">
        <titleInfo>
          <title>Corpus Christi College Cambridge / PARKER-ON-THE-WEB</title>
        </titleInfo>
        <originInfo>
          <edition>Descriptive Catalogue of the Manuscripts in the Library of Corpus Christi College</edition>
        </originInfo>
      </relatedItem>
      <relatedItem displayLabel="Description appears in" type="host">
        <titleInfo>
          <title>A descriptive catalogue of the manuscripts in the library of Corpus Christi College, Cambridge, by Montague Rhodes James ...</title>
        </titleInfo>
        <recordInfo>
          <recordIdentifier source="Unicorn catalog key">2263114</recordIdentifier>
        </recordInfo>
        <typeOfResource>text</typeOfResource>
      </relatedItem>
      <identifier type="local">CCC198</identifier>
      <identifier type="local">Stanley_S. 8</identifier>
      <identifier type="local">TJames_267</identifier>
      <location>
        <physicalLocation>Parker Library, Corpus Christi College, Cambridge, UK</physicalLocation>
      </location>
      <recordInfo>
        <recordContentSource>SDR Transformation</recordContentSource>
        <recordCreationDate>2011-09-27T12:58:14.826+02:00</recordCreationDate>
        <recordIdentifier source="Data Provider Digital Object identifier">CCC198</recordIdentifier>
        <recordOrigin>Transformed from TEI encoding of manuscript descriptions from the James Catalogue by Corpus Christi College, Cambridge,  UK.</recordOrigin>
        <languageOfCataloging>
          <languageTerm authority="iso639-2b">eng</languageTerm>
        </languageOfCataloging>
      </recordInfo>
      <relatedItem type="host">
        <titleInfo>
          <title>Parker Manuscripts</title>
        </titleInfo>
        <identifier type="uri">http://purl.stanford.edu/dx969tv9730</identifier>
        <typeOfResource collection="yes"/>
      </relatedItem>
    </mods>
    xml
  end

  def dms_mods_002
    <<-xml
    <?xml version="1.0" encoding="UTF-8"?>
    <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.loc.gov/mods/v3" version="3.3" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">
      <titleInfo>
        <title>Manuscript fragment of the Gospels and Canonical Epistles, glossed</title>
      </titleInfo>
      <titleInfo type="uniform">
        <title>Bible</title>
        <partName>N.T. Gospels</partName>
      </titleInfo>
      <typeOfResource/>
      <originInfo>
        <place>
          <placeTerm type="code" authority="marccountry">cau</placeTerm>
        </place>
        <place>
          <placeTerm type="text">[Paris?</placeTerm>
        </place>
        <dateIssued>ca. 1135]</dateIssued>
        <dateIssued encoding="marc" keyDate="yes">1135</dateIssued>
        <issuance>monographic</issuance>
      </originInfo>
      <language>
        <languageTerm authority="iso639-2b" type="code">lat</languageTerm>
      </language>
      <physicalDescription>
        <extent>18 leaves, detached.</extent>
      </physicalDescription>
      <note>From a manuscript which comprised the third and fourth Gospels and The Canonical Epistles, glossed, in 105 leaves. The Gloss on St. John was composed in the eleventh century by Anselm of Laon (d. 1117) and the Gloss on the Canonical Epistles probably dates from about 1100 and may be the work of Anselm or his brother Ralph (d. 1133).</note>
      <note>Purchased, 1985.</note>
      <subject authority="lcsh">
        <name type="personal">
          <namePart type="termsOfAddress">of Laon</namePart>
          <namePart>Anselm</namePart>
          <namePart type="date">d.1117</namePart>
        </name>
      </subject>
      <subject authority="lcsh">
        <name type="personal">
          <namePart type="termsOfAddress">of Laon</namePart>
          <namePart>Ralph</namePart>
          <namePart type="date">d.1133</namePart>
        </name>
      </subject>
      <subject authority="lcsh">
        <topic>Bible</topic>
        <topic>History</topic>
        <genre>Sources</genre>
      </subject>
      <subject authority="lcsh">
        <topic>Manuscripts, Latin</topic>
      </subject>
      <subject authority="lcsh">
        <geographic>France</geographic>
        <topic>Church history</topic>
        <temporal>Middle Ages, 987-1515</temporal>
      </subject>
      <location>
        <physicalLocation>Department of Special Collections, Stanford University Libraries, Stanford, CA 94305</physicalLocation>
      </location>
      <recordInfo>
        <descriptionStandard>appm</descriptionStandard>
        <recordContentSource authority="marcorg">CSt</recordContentSource>
        <recordCreationDate encoding="marc">860403</recordCreationDate>
        <recordChangeDate encoding="iso8601">19990219151953.0</recordChangeDate>
        <recordIdentifier source="CStRLIN">a4083458</recordIdentifier>
      </recordInfo>
      <relatedItem type="host">
        <titleInfo>
          <title>Stanford University Libraries Special Collections, Manuscripts Division</title>
        </titleInfo>
        <identifier type="uri">http://purl.stanford.edu/sk373nx0013</identifier>
        <typeOfResource collection="yes"/>
      </relatedItem>
      <accessCondition type="useAndReproduction">Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.</accessCondition>
    </mods>
    xml
  end

  def dms_mods_003
    <<-xml
    <?xml version="1.0" encoding="UTF-8"?>
    <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
      <titleInfo authority="BNF Catalog" type="alternative">
        <title>BNF NAF 6221</title>
      </titleInfo>
      <titleInfo>
        <title>Paris, Bibliothèque Nationale de France, NAF 6221</title>
      </titleInfo>
      <abstract displayLabel="Summary">Mélanges. II Recueil de 154 lais, ballades, rondeaux et serventois, dont 71 au moins sont d'Eustache DESCHAMPS</abstract>
      <typeOfResource manuscript="yes">text</typeOfResource>
      <physicalDescription>
        <reformattingQuality>preservation</reformattingQuality>
        <internetMediaType>image/jp2</internetMediaType>
        <digitalOrigin>reformatted digital</digitalOrigin>
      </physicalDescription>
      <subject authority="lcsh">
        <topic>Manuscripts</topic>
        <geographic>France</geographic>
      </subject>
      <location>
        <url/>
      </location>
      <relatedItem displayLabel="Bibliography" type="host">
        <titleInfo>
          <title/>
        </titleInfo>
        <recordInfo>
          <recordIdentifier source="Gallica ARK"/>
        </recordInfo>
        <typeOfResource>text</typeOfResource>
      </relatedItem>
      <identifier type="local">6221</identifier>
      <location>
        <physicalLocation>NAF, Bibliothèque nationale de France, Paris, France</physicalLocation>
      </location>
      <recordInfo>
        <recordContentSource>TEI Description</recordContentSource>
        <recordCreationDate encoding="w3cdtf">2012-12-18</recordCreationDate>
        <recordIdentifier source="BNF 6221"/>
        <recordOrigin/>
        <languageOfCataloging>
          <languageTerm authority="iso639-2b">fra</languageTerm>
        </languageOfCataloging>
      </recordInfo>
      <relatedItem type="host">
        <titleInfo>
          <title>Medieval Manuscripts from the Bibliothèque nationale de France</title>
        </titleInfo>
        <identifier type="uri">http://purl.stanford.edu/gj309bn0813</identifier>
        <typeOfResource collection="yes"/>
      </relatedItem>
    </mods>
    xml
  end

end
