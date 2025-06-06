Spot.reset_column_information

WaterQualityDepartment.find_or_create_by(code: 'LAPH') do |dept|
  dept.name = 'Los Angeles County Department of Public Health'
  dept.url = 'http://www.publichealth.lacounty.gov/phcommon/public/eh/water_quality/beach_grades.cfm'
end

# Northern California
NCA = Region.find_or_create_by(name: 'Northern California')
NCA.sort_order = 10
NCA.timezone = 'America/Los_Angeles'
NCA.save!
SF = Subregion.find_or_create_by(name: 'San Francisco')
SF.region = NCA
SF.sort_order = 10
SF.timezone = 'America/Los_Angeles'
SF.save!
SC = Subregion.find_or_create_by(name: 'Santa Cruz')
SC.region = NCA
SC.sort_order = 20
SC.timezone = 'America/Los_Angeles'
SC.save!

# Southern California
SCA = Region.find_or_create_by(name: 'Southern California')
SCA.sort_order = 12
SCA.timezone = 'America/Los_Angeles'
SCA.save!
SBVC = Subregion.find_or_initialize_by(name: 'Santa Barbara/Ventura')
SBVC.region = SCA
SBVC.sort_order = 40
SBVC.timezone = 'America/Los_Angeles'
SBVC.save!
LA = Subregion.find_or_initialize_by(name: 'Los Angeles')
LA.region = SCA
LA.sort_order = 50
LA.timezone = 'America/Los_Angeles'
LA.save!
NOC = Subregion.find_or_initialize_by(name: 'North Orange County')
NOC.region = SCA
NOC.sort_order = 60
NOC.timezone = 'America/Los_Angeles'
NOC.save!
SOC = Subregion.find_or_initialize_by(name: 'South Orange County')
SOC.region = SCA
SOC.sort_order = 70
SOC.timezone = 'America/Los_Angeles'
SOC.save!
NSD = Subregion.find_or_initialize_by(name: 'North San Diego')
NSD.region = SCA
NSD.sort_order = 80
NSD.timezone = 'America/Los_Angeles'
NSD.save!
SSD = Subregion.find_or_initialize_by(name: 'South San Diego')
SSD.region = SCA
SSD.sort_order = 90
SSD.timezone = 'America/Los_Angeles'
SSD.save!

# Mexico
MX = Region.find_or_create_by(name: 'Mexico', sort_order: 15)
COL = Subregion.find_or_initialize_by(name: 'Colima', region: MX)
COL.sort_order = 30
COL.timezone = 'America/Mexico_City'
COL.save!
GUR = Subregion.find_or_initialize_by(name: 'Guerrero', region: MX)
GUR.sort_order = 32
GUR.timezone = 'America/Mexico_City'
GUR.save!

# Europe
EU = Region.find_or_create_by(name: 'Europe', sort_order: 50)
PT = Subregion.find_or_initialize_by(name: 'Portugal', region: EU)
PT.sort_order = 30
PT.timezone = 'Europe/Lisbon'
PT.save!

# Hawaii
HI = Region.find_or_create_by(name: 'Hawaii', sort_order: 14)
HI.timezone = 'Pacific/Honolulu'
HI.save!
ONS = Subregion.find_or_initialize_by(name: 'Oahu - North Shore', region: HI)
ONS.assign_attributes(sort_order: 5, timezone: 'Pacific/Honolulu')
ONS.save!
OSS = Subregion.find_or_initialize_by(name: 'Oahu - South Shore', region: HI)
OSS.assign_attributes(sort_order: 10, timezone: 'Pacific/Honolulu')
OSS.save!
MNS = Subregion.find_or_initialize_by(name: 'Maui - North Shore', region: HI)
MNS.assign_attributes(sort_order: 15, timezone: 'Pacific/Honolulu')
MNS.save!
MNW = Subregion.find_or_initialize_by(name: 'Maui - Northwest', region: HI)
MNW.assign_attributes(sort_order: 20, timezone: 'Pacific/Honolulu')
MNW.save!
MSW = Subregion.find_or_initialize_by(name: 'Maui - Southwest', region: HI)
MSW.assign_attributes(sort_order: 25, timezone: 'Pacific/Honolulu')
MSW.save!

# Fiji
FJ = Region.find_or_create_by(name: 'Fiji', sort_order: 40, timezone: 'Pacific/Fiji')
NT = Subregion.find_or_create_by(name: 'Namotu/Tavarua', region: FJ, timezone: 'Pacific/Fiji')

spots = [
  { subregion: LA,
    lon: -118.964,
    lat: 34.051,
    surfline_v1_id: 4203,
    surfline_v2_id: '5842041f4e65fad6a7708813',
    msw_id: 277,
    spitcast_id: 207,
    spitcast_slug: 'county-line-malibu-ca',
    name: 'County Line' },
  { subregion: LA,
    lon: -118.932943,
    lat: 34.043762,
    surfline_v1_id: 4953,
    surfline_v2_id: '5842041f4e65fad6a770893f',
    msw_id: 2642,
    spitcast_id: 638,
    spitcast_slug: 'leo-carrillo-malibu-ca',
    name: 'Leo Carillo' },
  { subregion: LA,
    lon: -118.91593,
    lat: 34.041956,
    surfline_v2_id: '640a3f824eb375f0b99455c0',
    msw_id: 2643,
    name: 'Zeros' },
  { subregion: LA,
    lon: -118.823636154759,
    lat: 34.0151575961847,
    surfline_v1_id: 4949,
    surfline_v2_id: '5842041f4e65fad6a770893a',
    msw_id: 853,
    spitcast_id: 206,
    spitcast_slug: 'zuma-beach-malibu-ca',
    name: 'Zuma Beach' },
  { subregion: LA,
    lon: -118.804558744648,
    lat: 34.0016731994772,
    surfline_v1_id: 4947,
    surfline_v2_id: '5842041f4e65fad6a7708936',
    msw_id: 2610,
    spitcast_id: 637,
    spitcast_slug: 'point-dume-malibu-ca',
    name: 'Point Dume' },
  { subregion: LA,
    lon: -118.677652,
    lat: 34.033415,
    surfline_v1_id: 4209,
    surfline_v2_id: '5842041f4e65fad6a7708817',
    msw_id: 4204,
    spitcast_id: 205,
    spitcast_slug: 'malibu-malibu-ca',
    name: 'Malibu' },
  { subregion: LA,
    lon: -118.5759544372,
    lat: 34.038649057421,
    surfline_v1_id: 4210,
    surfline_v2_id: '5842041f4e65fad6a770881e',
    msw_id: 279,
    spitcast_id: 388,
    spitcast_slug: 'topanga-malibu-ca',
    name: 'Topanga' },
  { subregion: LA,
    lon: -118.553563183915,
    lat: 34.0378981296024,
    surfline_v1_id: 4883,
    surfline_v2_id: '5842041f4e65fad6a7708914',
    msw_id: 3673,
    spitcast_id: 387,
    spitcast_slug: 'sunset-pacific-palisades-ca',
    name: 'Sunset Blvd' },
  { subregion: LA,
    lon: -118.474263465162,
    lat: 33.9831612707837,
    surfline_v1_id: 4211,
    surfline_v2_id: '5842041f4e65fad6a7708819',
    msw_id: 2611,
    spitcast_id: 204,
    spitcast_slug: 'venice-venice-ca',
    name: 'Venice Breakwater' },
  { subregion: LA,
    lon: -118.420866962057,
    lat: 33.8985925532951,
    surfline_v1_id: 4900,
    surfline_v2_id: '5842041f4e65fad6a7708906',
    msw_id: 2677,
    spitcast_id: 402,
    spitcast_slug: 'el-porto-manhattan-beach-ca',
    name: 'El Porto' },
  { subregion: LA,
    lon: -118.411017510697,
    lat: 33.8796350643179,
    surfline_v1_id: 4901,
    surfline_v2_id: '5842041f4e65fad6a7708907',
    msw_id: 281,
    spitcast_id: 203,
    spitcast_slug: 'manhattan-beach-manhattan-beach-ca',
    name: 'Manhattan Beach' },
  { subregion: LA,
    lon: -118.407515128626,
    lat: 33.8720136817393,
    surfline_v1_id: 4902,
    surfline_v2_id: '5842041f4e65fad6a7708904',
    msw_id: 2607,
    spitcast_id: 202,
    spitcast_slug: 'hermosa-hermosa-beach-ca',
    name: 'Hermosa Beach' },
  { subregion: LA,
    lon: -118.400483774997,
    lat: 33.8504451986121,
    surfline_v1_id: 4912,
    surfline_v2_id: '5842041f4e65fad6a7708921',
    msw_id: 4208,
    spitcast_id: 201,
    spitcast_slug: 'redondo-breakwater-redondo-beach-ca',
    name: 'Redondo Breakwall' },
  { subregion: LA,
    lon: -118.393319834265,
    lat: 33.8093082807436,
    surfline_v1_id: 4910,
    surfline_v2_id: '5842041f4e65fad6a7708920',
    msw_id: 2604,
    spitcast_id: 200,
    spitcast_slug: 'torrance-beach-redondo-beach-ca',
    name: 'Torrance Beach/Haggertys' },
  { subregion: LA,
    lon: -118.407031669983,
    lat: 33.7929465628614,
    surfline_v1_id: 4936,
    surfline_v2_id: '5842041f4e65fad6a770892d',
    msw_id: 4207,
    spitcast_id: 633,
    spitcast_slug: 'palos-verdes-cove-palos-verdes-estates-ca',
    name: 'Palos Verdes Cove' },
  { subregion: LA,
    lon: -118.426842847667,
    lat: 33.7720998680626,
    surfline_v1_id: 4935,
    surfline_v2_id: '5842041f4e65fad6a770892c',
    msw_id: 283,
    name: 'Lunada Bay' },
  { subregion: SC,
    lon: -121.971690062891,
    lat: 36.9540876220453,
    surfline_v1_id: 4190,
    surfline_v2_id: '5842041f4e65fad6a7708807',
    msw_id: 644,
    spitcast_id: 1,
    spitcast_slug: 'pleasure-point-santa-cruz-ca',
    name: 'Pleasure Point' },
  { subregion: SF,
    lon: -122.513476588314,
    lat: 37.7682565117962,
    surfline_v1_id: 4127,
    surfline_v2_id: '5842041f4e65fad6a77087f8',
    msw_id: 255,
    spitcast_id: 117,
    spitcast_slug: 'south-ocean-beach-san-francisco-ca',
    name: 'Ocean Beach' },
  { subregion: PT,
    lon: -9.338022,
    lat: 38.681209,
    surfline_v1_id: 6064,
    surfline_v2_id: '5842041f4e65fad6a7708bc0',
    msw_id: 912,
    name: 'Carcavelos' },
  { subregion: PT,
    lon: -9.2266,
    lat: 38.630405,
    surfline_v1_id: 44509,
    surfline_v2_id: '5842041f4e65fad6a7708e65',
    msw_id: 874,
    name: 'Costa da Caparica' },
  { subregion: COL,
    lon: -103.962,
    lat: 18.853,
    surfline_v1_id: 59564,
    surfline_v2_id: '584204204e65fad6a770920d',
    msw_id: 333,
    name: 'Pascuales' },
  { subregion: GUR,
    lon: -101.749,
    lat: 17.794,
    surfline_v1_id: 59608,
    surfline_v2_id: '584204204e65fad6a770921f',
    msw_id: 1059,
    name: 'Troncones' },
  { subregion: GUR,
    lon: -101.871,
    lat: 17.914,
    surfline_v1_id: 59606,
    surfline_v2_id: '584204204e65fad6a770921d',
    msw_id: 336,
    name: 'The Ranch' },
  { subregion: GUR,
    lon: -101.774,
    lat: 17.836,
    surfline_v1_id: 59607,
    surfline_v2_id: '584204204e65fad6a770921e',
    msw_id: 838,
    name: 'La Saladita' },
  { subregion: GUR,
    lon: -102.792,
    lat: 18.082,
    surfline_v1_id: 59604,
    surfline_v2_id: '584204204e65fad6a770921c',
    msw_id: 334,
    name: 'Rio Nexpa' },
  { subregion: NOC,
    lon: -118.107874753501,
    lat: 33.7377190285934,
    surfline_v1_id: 4217,
    surfline_v2_id: '5842041f4e65fad6a7708820',
    msw_id: 285,
    spitcast_id: 222,
    spitcast_slug: 'seal-beach-pier-seal-beach-ca',
    name: 'Seal Beach Pier' },
  { subregion: NOC,
    lon: -118.103408,
    lat: 33.736816,
    surfline_v1_id: 4865,
    surfline_v2_id: '5842041f4e65fad6a77088e4',
    msw_id: 2599,
    name: '13th St Seal Beach' },
  { subregion: NOC,
    lon: -118.09080856603,
    lat: 33.7284858046428,
    surfline_v1_id: 4867,
    surfline_v2_id: '5842041f4e65fad6a77088e7',
    msw_id: 2594,
    spitcast_id: 602,
    spitcast_slug: 'surfside-jetty-north-coast-ca',
    name: 'Surfside Jetty' },
  { subregion: NOC,
    lon: -118.080226173689,
    lat: 33.7231577185346,
    surfline_v1_id: 4219,
    surfline_v2_id: '5842041f4e65fad6a7708822',
    msw_id: 4898,
    spitcast_id: 603,
    spitcast_slug: 'anderson-st-north-coast-ca',
    name: 'Anderson St' },
  { subregion: NOC,
    lon: -118.040365824134,
    lat: 33.6853921593044,
    surfline_v1_id: 103685,
    surfline_v2_id: '584204204e65fad6a770998d',
    msw_id: 3797,
    spitcast_id: 604,
    spitcast_slug: 'bolsa-chica-huntington-beach-ca',
    name: 'Bolsa Chica' },
  { subregion: NOC,
    lon: -118.01901000164,
    lat: 33.6661562058152,
    surfline_v1_id: 4870,
    surfline_v2_id: '5842041f4e65fad6a77088ea',
    msw_id: 4039,
    spitcast_id: 220,
    spitcast_slug: 'goldenwest-huntington-beach-ca',
    name: 'Goldenwest' },
  { subregion: NOC,
    lon: -118.014049033956,
    lat: 33.6639452812659,
    surfline_v1_id: 4871,
    surfline_v2_id: '5842041f4e65fad6a77088eb',
    msw_id: 4896,
    spitcast_id: 605,
    spitcast_slug: '17th-street-huntington-beach-ca',
    name: '17th St Huntington' },
  { subregion: NOC,
    lon: -118.005043340881,
    lat: 33.6552139815928,
    surfline_v1_id: 4223,
    surfline_v2_id: '5842041f4e65fad6a7708827',
    msw_id: 286,
    spitcast_id: 221,
    spitcast_slug: 'huntington-pier-huntington-beach-ca',
    name: 'Huntington Pier' },
  { subregion: NOC,
    lon: -117.993221421263,
    lat: 33.6485165540874,
    surfline_v1_id: 4875,
    surfline_v2_id: '5842041f4e65fad6a77088ee',
    msw_id: 4895,
    spitcast_id: 643,
    spitcast_slug: 'huntington-beach-huntington-beach-ca',
    name: 'Huntington State Beach' },
  { subregion: NOC,
    lon: -117.959168,
    lat: 33.628085,
    surfline_v1_id: 103681,
    surfline_v2_id: '584204204e65fad6a770998c',
    msw_id: 2577,
    spitcast_id: 606,
    spitcast_slug: 'santa-ana-river-jetties-newport-beach-ca',
    name: 'Santa Ana River Jetties' },
  { subregion: NOC,
    lon: -117.948767376086,
    lat: 33.6229055807335,
    surfline_v1_id: 43103,
    surfline_v2_id: '5842041f4e65fad6a7708e54',
    msw_id: 665,
    spitcast_id: 219,
    spitcast_slug: '56th-street-newport-beach-ca',
    name: '56th St Newport Beach' },
  { subregion: NOC,
    lon: -117.938811422113,
    lat: 33.6172275924874,
    surfline_v1_id: 4225,
    surfline_v2_id: '5a26dd690f87fe001a0c70dc',
    spitcast_id: 607,
    spitcast_slug: '40th-street-newport-beach-ca',
    name: '40th Street' },
  { subregion: NOC,
    lon: -117.936957653326,
    lat: 33.6153190345846,
    surfline_v1_id: 4226,
    surfline_v2_id: '5842041f4e65fad6a770882a',
    msw_id: 4683,
    spitcast_id: 608,
    spitcast_slug: '36th-street-newport-beach-ca',
    name: '36th Street' },
  { subregion: NOC,
    lon: -117.933626701894,
    lat: 33.6109583118254,
    surfline_v1_id: 53412,
    surfline_v2_id: '584204204e65fad6a7709115',
    msw_id: 2575,
    spitcast_id: 651,
    spitcast_slug: 'blackies-newport-beach-ca',
    name: 'Blackies' },
  { subregion: NOC,
    lon: -117.930738451154,
    lat: 33.6066469200425,
    surfline_v1_id: 4227,
    surfline_v2_id: '5842041f4e65fad6a770882c',
    spitcast_id: 609,
    spitcast_slug: 'newport-pier-newport-beach-ca',
    name: 'Newport Pier' },
  { subregion: NOC,
    lon: -117.882342970408,
    lat: 33.5933899386699,
    surfline_v1_id: 4232,
    surfline_v2_id: '5842041f4e65fad6a770882b',
    msw_id: 287,
    spitcast_id: 217,
    spitcast_slug: 'the-wedge-newport-beach-ca',
    name: 'The Wedge' },
  { subregion: NOC,
    lon: -117.875881,
    lat: 33.592468,
    surfline_v1_id: 4879,
    surfline_v2_id: '5842041f4e65fad6a77088f3',
    msw_id: 2579,
    name: 'Corona Del Mar' },
  { subregion: SOC,
    lon: -117.723302388099,
    lat: 33.4746650451478,
    surfline_v1_id: 4233,
    surfline_v2_id: '5842041f4e65fad6a770882e',
    msw_id: 289,
    spitcast_id: 214,
    spitcast_slug: 'salt-creek-dana-point-ca',
    name: 'Salt Creek' },
  { subregion: SOC,
    lon: -117.716886,
    lat: 33.466191,
    surfline_v1_id: 4849,
    surfline_v2_id: '5842041f4e65fad6a77088d5',
    msw_id: 4040,
    name: 'Strands' },
  { subregion: SOC,
    lon: -117.688648571076,
    lat: 33.4603308582054,
    surfline_v1_id: 4848,
    surfline_v2_id: '5842041f4e65fad6a77088d7',
    msw_id: 2588,
    spitcast_id: 213,
    spitcast_slug: 'doheny-dana-point-ca',
    name: 'Doheny' },
  { subregion: SOC,
    lon: -117.621267674113,
    lat: 33.4197319428865,
    msw_id: 290,
    spitcast_id: 212,
    spitcast_slug: 'san-clemente-pier-san-clemente-ca',
    name: 'San Clemente Pier' },
  { subregion: SOC,
    lon: -117.618142936175,
    lat: 33.4159655824035,
    surfline_v1_id: 4235,
    surfline_v2_id: '5842041f4e65fad6a7708830',
    msw_id: 2570,
    spitcast_id: 211,
    spitcast_slug: 't-street-san-clemente-ca',
    name: 'T Street' },
  { subregion: SOC,
    lon: -117.606199616021,
    lat: 33.4029799681431,
    surfline_v1_id: 4843,
    surfline_v2_id: '5842041f4e65fad6a77088cf',
    msw_id: 4900,
    spitcast_id: 392,
    spitcast_slug: 'state-park-san-clemente-ca',
    name: 'San Clemente State Beach' },
  { subregion: SOC,
    lon: -117.598772149192,
    lat: 33.3906129925768,
    surfline_v1_id: 4737,
    surfline_v2_id: '5842041f4e65fad6a7708884',
    msw_id: 4899,
    spitcast_id: 209,
    spitcast_slug: 'cottons-point-san-clemente-ca',
    name: 'Cottons' },
  { subregion: SOC,
    lon: -117.594451124026,
    lat: 33.3844763013776,
    surfline_v1_id: 4738,
    surfline_v2_id: '5842041f4e65fad6a7708887',
    spitcast_id: 623,
    spitcast_slug: 'upper-trestles-san-clemente-ca',
    name: 'Upper Trestles' },
  { subregion: SOC,
    lon: -117.588839746081,
    lat: 33.3821169550733,
    surfline_v1_id: 4740,
    surfline_v2_id: '5842041f4e65fad6a770888a',
    msw_id: 291,
    spitcast_id: 208,
    spitcast_slug: 'lower-trestles-san-clemente-ca',
    name: 'Lower Trestles' },
  { subregion: SOC,
    lon: -117.57903433989,
    lat: 33.3801145547518,
    surfline_v1_id: 4741,
    surfline_v2_id: '5842041f4e65fad6a770888b',
    msw_id: 4901,
    spitcast_id: 625,
    spitcast_slug: 'church-san-clemente-ca',
    name: 'Church' },
  { subregion: SOC,
    lon: -117.569129199378,
    lat: 33.3736054662039,
    surfline_v1_id: 4237,
    surfline_v2_id: '5842041f4e65fad6a7708831',
    msw_id: 4192,
    spitcast_id: 239,
    spitcast_slug: 'san-onofre-san-clemente-ca',
    name: 'San Onofre' },
  { subregion: SOC,
    lon: -117.519084,
    lat: 33.343654,
    surfline_v1_id: 4736,
    surfline_v2_id: '5842041f4e65fad6a7708885',
    msw_id: 2600,
    spitcast_id: 614,
    spitcast_slug: 'trails-san-clemente-ca',
    name: 'Trails' },
  { subregion: NSD,
    lon: -117.395977021389,
    lat: 33.20422852759,
    surfline_v1_id: 4238,
    surfline_v2_id: '5842041f4e65fad6a7708832',
    msw_id: 4793,
    spitcast_id: 238,
    spitcast_slug: 'oceanside-harbor-oceanside-ca',
    name: 'Oceanside Harbor',
    sort_order: 1 },
  { subregion: NSD,
    lon: -117.387187858031,
    lat: 33.1933870461609,
    surfline_v1_id: 68366,
    surfline_v2_id: '584204204e65fad6a7709435',
    msw_id: 664,
    spitcast_id: 594,
    spitcast_slug: 'oceanside-pier-oceanside-ca',
    name: 'Oceanside Pier',
    sort_order: 2 },
  { subregion: NSD,
    lon: -117.346796664119,
    lat: 33.147320395177,
    surfline_v1_id: 4242,
    surfline_v2_id: '5842041f4e65fad6a7708837',
    msw_id: 292,
    spitcast_id: 237,
    spitcast_slug: 'tamarack-carlsbad-ca',
    name: 'Tamarack',
    sort_order: 3 },
  { subregion: NSD,
    lon: -117.336194882219,
    lat: 33.1287625038052,
    surfline_v1_id: 4775,
    surfline_v2_id: '5842041f4e65fad6a77088a6',
    spitcast_id: 597,
    spitcast_slug: 'terra-mar-carlsbad-ca',
    name: 'Terra Mar',
    sort_order: 4 },
  { subregion: NSD,
    lon: -117.314238172042,
    lat: 33.0870346652814,
    surfline_v1_id: 4773,
    surfline_v2_id: '5842041f4e65fad6a77088a5',
    msw_id: 1149,
    spitcast_id: 236,
    spitcast_slug: 'ponto-carlsbad-ca',
    name: 'Ponto',
    sort_order: 5 },
  { subregion: NSD,
    lon: -117.310721142163,
    lat: 33.0754844673957,
    surfline_v1_id: 4771,
    surfline_v2_id: '5842041f4e65fad6a770889f',
    msw_id: 4564,
    spitcast_id: 400,
    spitcast_slug: 'grandview-encinitas-ca',
    name: 'Grandview',
    sort_order: 6 },
  { subregion: NSD,
    lon: -117.305550079009,
    lat: 33.0635702120347,
    surfline_v1_id: 4772,
    surfline_v2_id: '5842041f4e65fad6a77088a0',
    msw_id: 4562,
    spitcast_id: 235,
    spitcast_slug: 'beacons-encinitas-ca',
    name: 'Beacons',
    sort_order: 7 },
  { subregion: NSD,
    lon: -117.298203869191,
    lat: 33.0454422741039,
    surfline_v1_id: 4792,
    surfline_v2_id: '5842041f4e65fad6a77088b7',
    msw_id: 4563,
    spitcast_id: 401,
    spitcast_slug: 'd-street-encinitas-ca',
    name: 'D Street',
    sort_order: 8 },
  { subregion: NSD,
    lon: -117.295750253542,
    lat: 33.0344229310135,
    surfline_v1_id: 4789,
    surfline_v2_id: '5842041f4e65fad6a77088b4',
    msw_id: 293,
    spitcast_id: 234,
    spitcast_slug: 'swamis-encinitas-ca',
    name: 'Swamis',
    sort_order: 9 },
  { subregion: NSD,
    lon: -117.28879,
    lat: 33.02460487110932,
    surfline_v2_id: '5c008f5313603c0001df5318',
    spitcast_id: 233,
    spitcast_slug: 'pipes-cardiff-ca',
    name: 'Pipes',
    sort_order: 10 },
  { subregion: NSD,
    lon: -117.283273919829,
    lat: 33.015419916751,
    surfline_v1_id: 4786,
    surfline_v2_id: '5842041f4e65fad6a77088b1',
    msw_id: 4663,
    spitcast_id: 232,
    spitcast_slug: 'cardiff-reef-cardiff-ca',
    name: 'Cardiff Reef',
    sort_order: 11 },
  { subregion: NSD,
    lon: -117.280247,
    lat: 33.001619,
    surfline_v1_id: 4787,
    surfline_v2_id: '5842041f4e65fad6a77088b3',
    msw_id: 294,
    spitcast_id: 231,
    spitcast_slug: 'seaside-reef-solana-beach-ca',
    name: 'Seaside Reef',
    sort_order: 12 },
  { subregion: NSD,
    lon: -117.271344,
    lat: 32.975133,
    surfline_v1_id: 4785,
    surfline_v2_id: '5842041f4e65fad6a77088b0',
    msw_id: 4682,
    spitcast_id: 751,
    spitcast_slug: 'del-mar-rivermouth-del-mar-ca',
    name: 'Del Mar Rivermouth',
    sort_order: 13 },
  { subregion: NSD,
    lon: -117.269175357458,
    lat: 32.9586623258672,
    surfline_v1_id: 4783,
    surfline_v2_id: '5842041f4e65fad6a77088af',
    msw_id: 3707,
    spitcast_id: 230,
    spitcast_slug: '15th-street-del-mar-ca',
    name: '15th Street Del Mar',
    sort_order: 14 },
  { subregion: SSD,
    lon: -117.261740740452,
    lat: 32.9331020835322,
    surfline_v1_id: 107951,
    surfline_v2_id: '584204204e65fad6a7709994',
    spitcast_id: 754,
    spitcast_slug: 'torrey-pines-state-beach-la-jolla-ca',
    name: 'Torrey Pines State Beach' },
  { subregion: SSD,
    lon: -117.257477932799,
    lat: 32.8887277619852,
    surfline_v1_id: 4245,
    surfline_v2_id: '5842041f4e65fad6a770883b',
    msw_id: 294,
    spitcast_id: 229,
    spitcast_slug: 'blacks-beach-la-jolla-ca',
    name: 'Blacks' },
  { subregion: SSD,
    lon: -117.256273652086,
    lat: 32.8665985093327,
    surfline_v1_id: 4246,
    surfline_v2_id: '5842041f4e65fad6a7708839',
    msw_id: 296,
    spitcast_id: 228,
    spitcast_slug: 'scripps-pier-la-jolla-ca',
    name: 'Scripps Pier' },
  { subregion: SSD,
    lon: -117.283514,
    lat: 32.838504,
    surfline_v1_id: 4247,
    surfline_v2_id: '5842041f4e65fad6a770883d',
    msw_id: 4210,
    spitcast_id: 756,
    spitcast_slug: 'horseshoe-la-jolla-ca',
    name: 'Horseshoe' },
  { subregion: SSD,
    lon: -117.282043539579,
    lat: 32.8296653213721,
    surfline_v1_id: 4248,
    surfline_v2_id: '5842041f4e65fad6a770883c',
    msw_id: 4214,
    spitcast_id: 227,
    spitcast_slug: 'windansea-la-jolla-ca',
    name: 'Windansea' },
  { subregion: SSD,
    lon: -117.273844294504,
    lat: 32.8134240499085,
    surfline_v1_id: 4249,
    surfline_v2_id: '5842041f4e65fad6a770883a',
    msw_id: 4209,
    spitcast_id: 398,
    spitcast_slug: 'bird-rock-la-jolla-ca',
    name: 'Bird Rock' },
  { subregion: SSD,
    lon: -117.265998972397,
    lat: 32.8069459175153,
    surfline_v1_id: 4804,
    surfline_v2_id: '5842041f4e65fad6a77088c4',
    spitcast_id: 399,
    spitcast_slug: 'tourmaline-san-diego-ca',
    name: 'Tourmaline' },
  { subregion: SSD,
    lon: -117.259602950346,
    lat: 32.7970295054355,
    surfline_v1_id: 4250,
    surfline_v2_id: '5842041f4e65fad6a7708841',
    msw_id: 663,
    spitcast_id: 226,
    spitcast_slug: 'pacific-beach-san-diego-ca',
    name: 'Pacific Beach' },
  { subregion: SSD,
    lon: -117.254326482191,
    lat: 32.777929007486,
    surfline_v1_id: 4252,
    surfline_v2_id: '5842041f4e65fad6a7708842',
    msw_id: 297,
    spitcast_id: 397,
    spitcast_slug: 'mission-beach-san-diego-ca',
    name: 'Mission Beach' },
  { subregion: SSD,
    lon: -117.255341884911,
    lat: 32.7491518519641,
    surfline_v1_id: 4253,
    surfline_v2_id: '5842041f4e65fad6a770883f',
    msw_id: 4212,
    spitcast_id: 225,
    spitcast_slug: 'ocean-beach-pier-san-diego-ca',
    name: 'Ocean Beach Pier' },
  { subregion: SSD,
    lon: -117.257163271327,
    lat: 32.7189989047182,
    surfline_v1_id: 4254,
    surfline_v2_id: '5842041f4e65fad6a7708840',
    msw_id: 4211,
    spitcast_id: 224,
    spitcast_slug: 'sunset-cliffs-san-diego-ca',
    name: 'Sunset Cliffs' },
  { subregion: SSD,
    lon: -117.134600796776,
    lat: 32.577928810608,
    surfline_v1_id: 4256,
    surfline_v2_id: '5842041f4e65fad6a7708844',
    msw_id: 3745,
    spitcast_id: 223,
    spitcast_slug: 'imperial-beach-ca',
    name: 'Imperial Beach' },
  { subregion: SBVC,
    lon: -120.073313658504,
    lat: 34.4607278590271,
    surfline_v1_id: 4991,
    surfline_v2_id: '5842041f4e65fad6a7708961',
    msw_id: 2625,
    spitcast_id: 620,
    spitcast_slug: 'refugio-goleta-ca',
    name: 'Refugio' },
  { subregion: SBVC,
    lon: -119.882143269301,
    lat: 34.4090791409269,
    surfline_v1_id: 4994,
    surfline_v2_id: '5842041f4e65fad6a7708964',
    msw_id: 268,
    spitcast_id: 182,
    spitcast_slug: 'sands-isla-vista-ca',
    name: 'Sands' },
  { subregion: SBVC,
    lon: -119.877763672798,
    lat: 34.4060390017938,
    surfline_v1_id: 4995,
    surfline_v2_id: '5842041f4e65fad6a7708962',
    msw_id: 4251,
    spitcast_id: 181,
    spitcast_slug: 'devereux-isla-vista-ca',
    name: 'Coal Oil Point/Devereux' },
  { subregion: SBVC,
    lon: -119.842596370484,
    lat: 34.4048788892378,
    surfline_v1_id: 4997,
    surfline_v2_id: '5842041f4e65fad6a770896c',
    msw_id: 269,
    spitcast_id: 179,
    spitcast_slug: 'campus-point-isla-vista-ca',
    name: 'Campus Point' },
  { subregion: SBVC,
    lon: -119.702089869972,
    lat: 34.3979688807858,
    surfline_v1_id: 145542,
    surfline_v2_id: '58bdf54982d034001252e3d5',
    msw_id: 270,
    spitcast_id: 177,
    spitcast_slug: 'leadbetter-santa-barbara-ca',
    name: 'Leadbetter' },
  { subregion: SBVC,
    lon: 34.404613,
    lat: -119.687402,
    surfline_v1_id: 4998,
    surfline_v2_id: '5842041f4e65fad6a7708966',
    msw_id: 2629,
    name: 'Sandspit' },
  { subregion: SBVC,
    lon: 34.416038,
    lat: -119.636549,
    surfline_v1_id: 4999,
    surfline_v2_id: '5842041f4e65fad6a7708967',
    msw_id: 271,
    name: 'Hammonds' },
  { subregion: SBVC,
    lon: 34.391859,
    lat: -119.525699,
    surfline_v1_id: 5001,
    surfline_v2_id: '5842041f4e65fad6a770896e',
    msw_id: 2701,
    name: 'Carpinteria/Tarpits' },
  { subregion: SBVC,
    lon: -119.477992904603,
    lat: 34.3725654297481,
    surfline_v1_id: 4197,
    surfline_v2_id: '5842041f4e65fad6a7708814',
    msw_id: 272,
    spitcast_id: 198,
    spitcast_slug: 'rincon-carpinteria-ca',
    name: 'Rincon' },
  { subregion: SBVC,
    lon: 34.355095,
    lat: -119.442182,
    surfline_v1_id: 4985,
    surfline_v2_id: '5842041f4e65fad6a770895a',
    msw_id: 2672,
    name: 'Mussel Shoals/Little Rincon' },
  { subregion: SBVC,
    lon: 34.31675,
    lat: -119.38924,
    surfline_v1_id: 4981,
    surfline_v2_id: '5842041f4e65fad6a7708957',
    msw_id: 274,
    name: 'Pitas Point' },
  { subregion: SBVC,
    lon: -119.377375358257,
    lat: 34.3191767099386,
    surfline_v1_id: 49737,
    surfline_v2_id: '584204204e65fad6a770904d',
    spitcast_id: 193,
    spitcast_slug: 'mondos-ventura-ca',
    name: 'Mondos' },
  { subregion: SBVC,
    lon: 34.309334,
    lat: -119.358505,
    surfline_v1_id: 4989,
    surfline_v2_id: '5842041f4e65fad6a770895f',
    msw_id: 2644,
    name: 'Solimar' },
  { subregion: SBVC,
    lon: -119.339878421031,
    lat: 34.2923374874949,
    surfline_v1_id: 4980,
    surfline_v2_id: '5842041f4e65fad6a7708959',
    msw_id: 2646,
    spitcast_id: 191,
    spitcast_slug: 'emma-wood-ventura-ca',
    name: 'Emma Wood' },
  { subregion: SBVC,
    lon: -119.300150838877,
    lat: 34.2730698693049,
    surfline_v1_id: 4200,
    surfline_v2_id: '584204214e65fad6a7709cfd',
    msw_id: 275,
    spitcast_id: 190,
    spitcast_slug: 'c-street-ventura-ca',
    name: 'C Street' },
  { subregion: SBVC,
    lon: -119.269073,
    lat: 34.244158,
    surfline_v1_id: 4201,
    surfline_v2_id: '5842041f4e65fad6a7708811',
    msw_id: 2632,
    spitcast_id: 189,
    spitcast_slug: 'south-jetty-ventura-ca',
    name: 'Ventura Harbor' },
  { subregion: SBVC,
    lon: 34.171836,
    lat: -119.237817,
    surfline_v1_id: 4968,
    surfline_v2_id: '5842041f4e65fad6a770894c',
    msw_id: 276,
    name: 'Oxnard' },
  { subregion: ONS,
    lon: -158.033,
    lat: 21.685,
    surfline_v1_id: 10833,
    surfline_v2_id: '5842041f4e65fad6a7708df4',
    msw_id: 659,
    name: 'Velzyland' },
  { subregion: ONS,
    lon: -158.042,
    lat: 21.679,
    surfline_v1_id: 4746,
    surfline_v2_id: '5842041f4e65fad6a770888d',
    msw_id: 657,
    name: 'Sunset' },
  { subregion: ONS,
    lon: -158.0482006072,
    lat: 21.670550036401,
    surfline_v1_id: 4748,
    surfline_v2_id: '5842041f4e65fad6a770888e',
    msw_id: 658,
    name: 'Rocky Point' },
  { subregion: ONS,
    lon: -158.0541,
    lat: 21.6651,
    surfline_v1_id: 4750,
    surfline_v2_id: '5842041f4e65fad6a7708890',
    msw_id: 616,
    name: 'Pipeline' },
  { subregion: ONS,
    lon: -158.055,
    lat: 21.664,
    surfline_v1_id: 4752,
    surfline_v2_id: '5842041f4e65fad6a7708894',
    msw_id: 2233,
    name: 'Off-The-Wall' },
  { subregion: ONS,
    lon: -158.057,
    lat: 21.662,
    surfline_v1_id: 4753,
    surfline_v2_id: '5842041f4e65fad6a7708892',
    msw_id: 2234,
    name: 'Rockpile' },
  { subregion: ONS,
    lon: -158.058,
    lat: 21.661,
    surfline_v1_id: 4754,
    surfline_v2_id: '5842041f4e65fad6a7708893',
    msw_id: 2226,
    name: 'Log Cabins' },
  { subregion: ONS,
    lon: -158.067,
    lat: 21.643,
    surfline_v1_id: 4755,
    surfline_v2_id: '5842041f4e65fad6a7708895',
    msw_id: 549,
    name: 'Waimea Bay' },
  { subregion: ONS,
    lon: -158.088,
    lat: 21.62,
    surfline_v1_id: 4759,
    surfline_v2_id: '5842041f4e65fad6a7708898',
    msw_id: 3672,
    name: 'Laniakea' },
  { subregion: ONS,
    lon: -158.109,
    lat: 21.597,
    surfline_v1_id: 10834,
    surfline_v2_id: '5842041f4e65fad6a7708df5',
    msw_id: 660,
    name: 'Haleiwa' },
  { subregion: OSS,
    lon: -158.107,
    lat: 21.295,
    surfline_v1_id: 10847,
    surfline_v2_id: '5842041f4e65fad6a7708dfe',
    msw_id: 3082,
    name: 'Barbers Point' },
  { subregion: OSS,
    lon: -157.845,
    lat: 21.28,
    surfline_v1_id: 5538,
    surfline_v2_id: '5842041f4e65fad6a7708b42',
    msw_id: 661,
    name: 'Ala Moana Bowls' },
  { subregion: OSS,
    lon: -157.8255,
    lat: 21.268,
    surfline_v1_id: 55536,
    surfline_v2_id: '584204204e65fad6a7709148',
    msw_id: 4916,
    name: 'Waikiki' },
  { subregion: OSS,
    lon: -157.826489266749,
    lat: 21.2729668197042,
    surfline_v1_id: 5531,
    surfline_v2_id: '5842041f4e65fad6a7708b36',
    msw_id: 662,
    name: "Queen's" },
  { subregion: OSS,
    lon: -157.805,
    lat: 21.252,
    surfline_v1_id: 4760,
    surfline_v2_id: '5842041f4e65fad6a77088a2',
    msw_id: 4697,
    name: 'Diamond Head' },
  { subregion: MNS,
    lon: -156.463,
    lat: 20.904,
    surfline_v1_id: 10816,
    surfline_v2_id: '5842041f4e65fad6a7708de6',
    msw_id: 4927,
    name: 'Kahului Harbor' },
  { subregion: MNS,
    lon: -156.442,
    lat: 20.905,
    surfline_v1_id: 10813,
    surfline_v2_id: '5842041f4e65fad6a7708de5',
    msw_id: 4926,
    name: 'Kanaha' },
  { subregion: MNS,
    lon: -156.374,
    lat: 20.922,
    surfline_v1_id: 108155,
    surfline_v2_id: '584204204e65fad6a770999d',
    msw_id: 4925,
    name: 'Tavares Bay' },
  { subregion: MNS,
    lon: -156.359,
    lat: 20.9357,
    surfline_v1_id: 10817,
    surfline_v2_id: '5842041f4e65fad6a7708de8',
    msw_id: 1244,
    name: "Ho'okipa" },
  { subregion: MNS,
    lon: -156.356,
    lat: 20.9374,
    msw_id: 2785,
    name: 'Pavilions' },
  { subregion: MNS,
    lon: -156.298,
    lat: 20.945,
    surfline_v1_id: 10818,
    surfline_v2_id: '5842041f4e65fad6a7708de9',
    msw_id: 617,
    name: 'Peahi/Jaws' },
  { subregion: MNS,
    lon: -156.166,
    lat: 20.866,
    surfline_v1_id: 10819,
    surfline_v2_id: '5842041f4e65fad6a7708deb',
    msw_id: 4924,
    name: 'Honomanu Bay' },
  { subregion: MNS,
    lon: -155.983,
    lat: 20.76,
    surfline_v1_id: 10820,
    surfline_v2_id: '5842041f4e65fad6a7708dea',
    msw_id: 4923,
    name: 'Hana Bay' },
  { subregion: MNW,
    lon: -156.61,
    lat: 21.0228,
    surfline_v1_id: 10815,
    surfline_v2_id: '5842041f4e65fad6a7708de7',
    msw_id: 2782,
    name: 'Honokohau Bay' },
  { subregion: MNW,
    lon: -156.628,
    lat: 21.0239,
    msw_id: 1274,
    name: 'Windmills' },
  { subregion: MNW,
    lon: -156.641,
    lat: 21.0159,
    surfline_v1_id: 10814,
    surfline_v2_id: '5842041f4e65fad6a7708de4',
    msw_id: 697,
    name: 'Honolua Bay' },
  { subregion: MNW,
    lon: -156.668,
    lat: 20.9972,
    msw_id: 2780,
    name: 'Little Makaha' },
  { subregion: MNW,
    lon: -156.694,
    lat: 20.9468,
    surfline_v1_id: 10812,
    surfline_v2_id: '5842041f4e65fad6a7708de3',
    msw_id: 2966,
    name: 'Rainbows' },
  { subregion: MNW,
    lon: -156.6797,
    lat: 20.8705,
    surfline_v1_id: 5528,
    surfline_v2_id: '5842041f4e65fad6a7708b37',
    msw_id: 4287,
    name: 'Lahaina Harbor/Breakwall' },
  { subregion: MNW,
    lon: -156.624,
    lat: 20.808,
    surfline_v1_id: 10809,
    surfline_v2_id: '5842041f4e65fad6a7708de0',
    msw_id: 4928,
    name: 'Olowalu' },
  { subregion: MNW,
    lon: -156.511,
    lat: 20.7895,
    surfline_v1_id: 7443,
    surfline_v2_id: '5842041f4e65fad6a7708da5',
    msw_id: 618,
    name: "Ma'alaea Harbor" },
  { subregion: MSW,
    lon: -156.453,
    lat: 20.728,
    surfline_v1_id: 10810,
    surfline_v2_id: '5842041f4e65fad6a7708de1',
    msw_id: 4929,
    name: 'The Cove' },
  { subregion: MSW,
    lon: -156.4462,
    lat: 20.6412,
    msw_id: 5876,
    name: 'Oneuli Beach' },
  { subregion: MSW,
    lon: -156.4473,
    lat: 20.632,
    surfline_v1_id: 5520,
    surfline_v2_id: '5842041f4e65fad6a7708b2a',
    msw_id: 5875,
    name: 'Makena Beach' },
  { subregion: MSW,
    lon: -156.438,
    lat: 20.6124,
    surfline_v1_id: 5521,
    surfline_v2_id: '5842041f4e65fad6a7708b2b',
    msw_id: 3668,
    name: 'Aluhi Bay/Dumps' },
  { subregion: MSW,
    lon: -156.415,
    lat: 20.591,
    surfline_v1_id: 10811,
    surfline_v2_id: '5842041f4e65fad6a7708de2',
    msw_id: 4930,
    name: 'La Perouse Bay' },
  { subregion: NT,
    name: 'Wilkes Pass',
    msw_id: 4217,
    lat: -17.8421,
    lon: 177.17,
    surfline_v1_id: 7285,
    surfline_v2_id: '5842041f4e65fad6a7708d5c' },
  { subregion: NT,
    name: 'Namotu Left',
    msw_id: 3682,
    lat: -17.8453,
    lon: 177.1781,
    surfline_v1_id: 7284,
    surfline_v2_id: '5842041f4e65fad6a7708d5a' },
  { subregion: NT,
    name: 'Swimming Pools',
    lat: -17.8459,
    lon: 177.178,
    surfline_v1_id: 7283,
    surfline_v2_id: '5842041f4e65fad6a7708d5d' },
  { subregion: NT,
    name: 'Restaurants',
    msw_id: 4486,
    lat: -17.8529,
    lon: 177.2002,
    surfline_v1_id: 8494,
    surfline_v2_id: '5842041f4e65fad6a7708dc2' },
  { subregion: NT,
    name: 'Cloudbreak',
    msw_id: 669,
    lat: -17.8869,
    lon: 177.1855,
    surfline_v1_id: 8493,
    surfline_v2_id: '5842041f4e65fad6a7708dc5' },
].freeze

spots.each do |spot_data|
  spot = Spot.find_or_initialize_by(name: spot_data[:name], subregion: spot_data[:subregion])
  spot.assign_attributes(spot_data)
  spot.save!
end

buoys = [
  { region: NCA, ndbc_id: 46006, lat: 40.772, lon: -137.376, name: 'SE Papa' },
  { region: NCA, ndbc_id: 46012, lat: 37.356, lon: -122.881, name: 'Half Moon Bay' },
  { region: NCA, ndbc_id: 46013, lat: 38.253, lon: -123.303, name: 'Bodega Bay' },
  { region: NCA, ndbc_id: 46014, lat: 39.231, lon: -123.974, name: 'Pt Arena' },
  { region: NCA, ndbc_id: 46022, lat: 40.703, lon: -124.554, name: 'Eel River' },
  { region: SCA, ndbc_id: 46025, lat: 33.758, lon: -119.044, name: 'Santa Monica Basin' },
  { region: NCA, ndbc_id: 46026, lat: 37.754, lon: -122.839, name: 'San Francisco' },
  { region: NCA, ndbc_id: 46027, lat: 41.852, lon: -124.38, name: 'St Georges' },
  { region: NCA, ndbc_id: 46028, lat: 35.774, lon: -121.905, name: 'Cape San Martin' },
  { region: NCA, ndbc_id: 46042, lat: 36.785, lon: -122.398, name: 'Monterey' },
  { region: SCA, ndbc_id: 46047, lat: 32.404, lon: -119.506, name: 'Tanner Bank' },
  { region: SCA, ndbc_id: 46053, lat: 34.241, lon: -119.839, name: 'E Santa Barbara' },
  { region: SCA, ndbc_id: 46054, lat: 34.265, lon: -120.477, name: 'W Santa Barbara' },
  { region: SCA, ndbc_id: 46069, lat: 33.677, lon: -120.213, name: 'S Santa Rosa Island' },
  { region: SCA, ndbc_id: 46086, lat: 32.499, lon: -118.052, name: 'San Clemente Basin' },
  { region: NCA, ndbc_id: 46114, lat: 36.699, lon: -122.343, name: 'W Monterey Bay' },
  { region: NCA, ndbc_id: 46213, lat: 40.295, lon: -124.732, name: 'Cape Mendocino' },
  { region: NCA, ndbc_id: 46214, lat: 37.937, lon: -123.463, name: 'Point Reyes' },
  { region: NCA, ndbc_id: 46215, lat: 35.204, lon: -120.859, name: 'Diablo Canyon' },
  { region: SCA, ndbc_id: 46218, lat: 34.454, lon: -120.783, name: 'Harvest' },
  { region: SCA, ndbc_id: 46219, lat: 33.225, lon: -119.882, name: 'San Nicolas Island' },
  { region: SCA, ndbc_id: 46221, lat: 33.855, lon: -118.634, name: 'Santa Monica Bay' },
  { region: SCA, ndbc_id: 46222, lat: 33.618, lon: -118.317, name: 'San Pedro' },
  { region: SCA, ndbc_id: 46224, lat: 33.178, lon: -117.472, name: 'Oceanside Offshore' },
  { region: SCA, ndbc_id: 46225, lat: 32.933, lon: -117.391, name: 'Torrey Pines Outer' },
  { region: SCA, ndbc_id: 46232, lat: 32.517, lon: -117.425, name: 'Point Loma South' },
  { region: SCA, ndbc_id: 46235, lat: 32.57, lon: -117.169, name: 'Imperial Beach Nearshore' },
  { region: NCA, ndbc_id: 46237, lat: 37.786, lon: -122.635, name: 'San Francisco Bar' },
  { region: NCA, ndbc_id: 46239, lat: 36.343, lon: -122.096, name: 'Point Sur' },
  { region: NCA, ndbc_id: 46240, lat: 36.626, lon: -121.907, name: 'Cabrillo Point' },
  { region: SCA, ndbc_id: 46242, lat: 33.22, lon: -117.439, name: 'Camp Pendleton Nearshore' },
  { region: NCA, ndbc_id: 46244, lat: 40.896, lon: -124.357, name: 'Humboldt Bay, North Spit' },
  { region: SCA, ndbc_id: 46251, lat: 33.761, lon: -119.559, name: 'Santa Cruz Basin' },
  { region: SCA, ndbc_id: 46253, lat: 33.576, lon: -118.181, name: 'San Pedro S' },
  { region: SCA, ndbc_id: 46254, lat: 32.868, lon: -117.267, name: 'Scripps Nearshore' },
  { region: SCA, ndbc_id: 46256, lat: 33.7, lon: -118.201, name: 'Long Beach Channel' },
  { region: SCA, ndbc_id: 46258, lat: 32.752, lon: -117.501, name: 'Mission Bay W' },
  { region: NCA, ndbc_id: 46259, lat: 34.767, lon: -121.497, name: 'Santa Lucia Escarpment' },
  { region: SCA, ndbc_id: 46266, lat: 32.957, lon: -117.279, name: 'Del Mar Nearshore' },
  { region: SCA, ndbc_id: 46268, lat: 34.022, lon: -118.578, name: 'Topanga Nearshore' },
  { region: NCA, ndbc_id: 46411, lat: 39.34, lon: -127.07, name: 'Mendocino' },
].freeze

buoys.each do |buoy_data|
  buoy = Buoy.find_or_initialize_by(ndbc_id: buoy_data[:ndbc_id])
  buoy.assign_attributes(buoy_data)
  buoy.save!
end
