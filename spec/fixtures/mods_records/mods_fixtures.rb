# encoding: UTF-8
module ModsFixtures
  def dms_mods_001
    File.read('spec/fixtures/mods_records/fh878gz0315.mods.xml')
  end

  def dms_mods_002
    File.read('spec/fixtures/mods_records/kq131cs7229.mods.xml')
  end

  def dms_mods_003
    File.read('spec/fixtures/mods_records/jr903ng8662.mods.xml')
  end

  def dms_mods_004
    # Year ["1389"]
    File.read('spec/fixtures/mods_records/mr892jv0716.mods.xml')
  end

  def dms_mods_005
    # Start and end years ["850","1499"]
    File.read('spec/fixtures/mods_records/kh686yw0435.mods.xml')
  end

  def dms_mods_006
    # Approximate year ["Ca. 1580 CE"]
    File.read('spec/fixtures/mods_records/gs755tr2814.mods.xml')
  end

  def dms_mods_007
    # Approximate year ["1500 CE"]
    File.read('spec/fixtures/mods_records/hp976mx6580.mods.xml')
  end

  def dms_mods_008
    # Approximate century ["14uu"]
    File.read('spec/fixtures/mods_records/tw490xj0071.mods.xml')
  end

  def dms_mods_009
    # Full date ["February 6, 1486"]
    File.read('spec/fixtures/mods_records/ss222gr9703.mods.xml')
  end

  def dms_mods_010
    # Partial date ["June 1781"]
    File.read('spec/fixtures/mods_records/zq824dz1346.mods.xml')
  end

  def dms_mods_011
    # Approximate start and end years ["s. XIII^^ex [ca. 1275-1300]"]
    File.read('spec/fixtures/mods_records/rc145sy7436.mods.xml')
  end
end
