# frozen_string_literal: true

WaterQualityDepartment.find_or_create_by(code: 'LAPH') do |dept|
  dept.name = 'Los Angeles County Department of Public Health'
  dept.url = 'http://www.publichealth.lacounty.gov/phcommon/public/eh/water_quality/beach_grades.cfm'
end

CA = Region.find_or_create_by(name: 'California', sort_order: 10)
SF = Subregion.find_or_create_by(name: 'San Francisco', region: CA)
SF.sort_order = 10
SF.timezone = 'Pacific Time (US & Canada)'
SF.save!
SC = Subregion.find_or_create_by(name: 'Santa Cruz', region: CA)
SC.sort_order = 20
SC.timezone = 'Pacific Time (US & Canada)'
SC.save!
LA = Subregion.find_or_initialize_by(name: 'Los Angeles', region: CA)
LA.sort_order = 50
LA.timezone = 'Pacific Time (US & Canada)'
LA.save!
NOC = Subregion.find_or_initialize_by(name: 'North Orange County', region: CA)
NOC.sort_order = 60
NOC.timezone = 'Pacific Time (US & Canada)'
NOC.save!
SOC = Subregion.find_or_initialize_by(name: 'South Orange County', region: CA)
SOC.sort_order = 70
SOC.timezone = 'Pacific Time (US & Canada)'
SOC.save!
MX = Region.find_or_create_by(name: 'Mexico', sort_order: 15)
COL = Subregion.find_or_initialize_by(name: 'Colima', region: MX)
COL.sort_order = 30
COL.timezone = 'Guadalajara'
COL.save!
GUR = Subregion.find_or_initialize_by(name: 'Guerrero', region: MX)
GUR.sort_order = 32
GUR.timezone = 'Guadalajara'
GUR.save!
EU = Region.find_or_create_by(name: 'Europe', sort_order: 50)
PT = Subregion.find_or_initialize_by(name: 'Portugal', region: EU)
PT.sort_order = 30
PT.timezone = 'Lisbon'
PT.save!

spots = [
  {
    name: 'County Line',
    lat: 34.051,
    lon: -118.964,
    surfline_id: 4203,
    msw_id: 277,
    msw_slug: 'County-Line-Yerba-Buena-Beach',
    spitcast_id: 207,
    spitcast_slug: 'county-line-malibu-ca',
    subregion: LA,
  },
  {
    name: 'Leo Carillo',
    lat: 34.043762,
    lon: -118.932943,
    surfline_id: 4953,
    msw_id: 2642,
    msw_slug: 'Leo-Carrillo',
    subregion: LA,
  },
  {
    name: 'Zeros',
    lat: 34.041956,
    lon: -118.91593,
    msw_id: 2643,
    msw_slug: 'Zero-Nicholas-Canyon-County-Beach',
    subregion: LA,
  },
  {
    name: 'Zuma Beach',
    lat: 34.01515759618465,
    lon: -118.8236361547595,
    surfline_id: 4949,
    msw_id: 853,
    msw_slug: 'Zuma-Beach-County-Park',
    spitcast_id: 206,
    spitcast_slug: 'zuma-beach-malibu-ca',
    subregion: LA,
  },
  {
    name: 'Point Dume',
    lat: 34.0016731994772,
    lon: -118.804558744648,
    surfline_id: 4947,
    msw_id: 2610,
    msw_slug: 'Point-Dume',
    subregion: LA,
  },
  {
    name: 'Malibu',
    lat: 34.033415,
    lon: -118.677652,
    surfline_id: 4209,
    msw_id: 4204,
    msw_slug: 'Malibu-First-Point',
    spitcast_id: 205,
    spitcast_slug: 'malibu-malibu-ca',
    subregion: LA,
  },
  {
    name: 'Topanga',
    lat: 34.038649057421,
    lon: -118.5759544372,
    surfline_id: 4210,
    msw_id: 279,
    msw_slug: 'Topanga-State-Beach',
    spitcast_id: 388,
    spitcast_slug: 'topanga-malibu-ca',
    subregion: LA,
  },
  {
    name: 'Sunset Blvd',
    lat: 34.03789812960242,
    lon: -118.5535631839145,
    surfline_id: 4883,
    msw_id: 3673,
    msw_slug: 'Sunset-Blvd',
    spitcast_id: 387,
    spitcast_slug: 'sunset-pacific-palisades-ca',
    subregion: LA,
  },
  {
    name: 'Venice Breakwater',
    lat: 33.983161270783711,
    lon: -118.4742634651619,
    surfline_id: 4211,
    msw_id: 2611,
    msw_slug: 'Venice-Beach',
    spitcast_id: 204,
    spitcast_slug: 'venice-venice-ca',
    subregion: LA,
  },
  {
    name: 'El Porto',
    lat: 33.89859255329511,
    lon: -118.4208669620573,
    surfline_id: 4900,
    msw_id: 2677,
    msw_slug: 'El-Porto-Beach',
    spitcast_id: 402,
    spitcast_slug: 'el-porto-manhattan-beach-ca',
    subregion: LA,
  },
  {
    name: 'Manhattan Beach',
    lat: 33.87963506431794,
    lon: -118.4110175106966,
    surfline_id: 4901,
    msw_id: 281,
    msw_slug: 'Manhattan-Beach',
    spitcast_id: 203,
    spitcast_slug: 'manhattan-beach-manhattan-beach-ca',
    subregion: LA,
  },
  {
    name: 'Hermosa Beach',
    lat: 33.87201368173932,
    lon: -118.4075151286262,
    surfline_id: 4902,
    msw_id: 2607,
    msw_slug: 'Hermosa-Beach',
    spitcast_id: 202,
    spitcast_slug: 'hermosa-hermosa-beach-ca',
    subregion: LA,
  },
  {
    name: 'Redondo Breakwall',
    lat: 33.85044519861206,
    lon: -118.4004837749971,
    surfline_id: 4912,
    msw_id: 4208,
    msw_slug: 'Redondo-Beach-Breakwater',
    subregion: LA,
  },
  {
    name: 'Torrance Beach/Haggertys',
    lat: 33.80930828074364,
    lon: -118.3933198342649,
    surfline_id: 4910,
    msw_id: 2604,
    msw_slug: 'Torrance-Beach-Haggertys',
    spitcast_id: 200,
    spitcast_slug: 'torrance-beach-redondo-beach-ca',
    subregion: LA,
  },
  {
    name: 'Palos Verdes Cove',
    lat: 33.79294656286144,
    lon: -118.4070316699825,
    surfline_id: 4936,
    msw_id: 4207,
    msw_slug: 'Palos-Verdes-Cove',
    subregion: LA,
  },
  {
    name: 'Lunada Bay',
    lat: 33.77209986806257,
    lon: -118.4268428476672,
    surfline_id: 4935,
    msw_id: 283,
    msw_slug: 'Lunada-Bay',
    subregion: LA,
  },
  {
    subregion: NOC,
    lat: 33.737719028593382,
    lon: -118.1078747535007,
    surfline_id: 4217,
    msw_id: 285,
    msw_slug: 'Seal-Beach-Pier',
    spitcast_id: 222,
    spitcast_slug: 'seal-beach-pier-seal-beach-ca',
    name: 'Seal Beach Pier'
  },
  {
    subregion: NOC,
    lat: 33.736816,
    lon: -118.103408,
    surfline_id: 4865,
    msw_id: 2599,
    msw_slug: '13th-Street',
    name: '13th St Seal Beach'
  },
  {
    subregion: NOC,
    lat: 33.728485804642823,
    lon: -118.0908085660303,
    surfline_id: 4867,
    msw_id: 2594,
    msw_slug: 'Surfside-Jetty',
    spitcast_id: 602,
    spitcast_slug: 'surfside-jetty-north-coast-ca',
    name: 'Surfside Jetty'
  },
  {
    subregion: NOC,
    lat: 33.72315771853458,
    lon: -118.0802261736895,
    surfline_id: 4219,
    spitcast_id: 603,
    spitcast_slug: 'anderson-st-north-coast-ca',
    name: 'Anderson St'
  },
  {
    subregion: NOC,
    lat: 33.685392159304449,
    lon: -118.0403658241339,
    surfline_id: 103_685,
    msw_id: 3797,
    msw_slug: 'Bolsa-Chica',
    spitcast_id: 604,
    spitcast_slug: 'bolsa-chica-huntington-beach-ca',
    name: 'Bolsa Chica'
  },
  {
    subregion: NOC,
    lat: 33.666156205815213,
    lon: -118.01901000164,
    surfline_id: 4870,
    msw_id: 4039,
    msw_slug: 'Goldenwest',
    spitcast_id: 220,
    spitcast_slug: 'goldenwest-huntington-beach-ca',
    name: 'Goldenwest'
  },
  {
    subregion: NOC,
    lat: 33.663945281265853,
    lon: -118.0140490339561,
    surfline_id: 4871,
    spitcast_id: 605,
    spitcast_slug: '17th-street-huntington-beach-ca',
    name: '17th St Huntington'
  },
  {
    subregion: NOC,
    lat: 33.655213981592752,
    lon: -118.0050433408805,
    surfline_id: 4223,
    msw_id: 286,
    msw_slug: 'Huntington-Pier',
    spitcast_id: 221,
    spitcast_slug: 'huntington-pier-huntington-beach-ca',
    name: 'Huntington Pier'
  },
  {
    subregion: NOC,
    lat: 33.648516554087408,
    lon: -117.9932214212635,
    surfline_id: 4875,
    spitcast_id: 643,
    spitcast_slug: 'huntington-beach-huntington-beach-ca',
    name: 'Huntington State Beach'
  },
  {
    subregion: NOC,
    lat: 33.628085,
    lon: -117.959168,
    surfline_id: 103_681,
    msw_id: 2577,
    msw_slug: 'Santa-Ana-River-Jetties',
    name: 'Santa Ana River Jetties'
  },
  {
    subregion: NOC,
    lat: 33.62290558073348,
    lon: -117.9487673760861,
    surfline_id: 43_103,
    msw_id: 665,
    msw_slug: 'Newport-Beach',
    spitcast_id: 219,
    spitcast_slug: '56th-street-newport-beach-ca',
    name: '56th St Newport Beach'
  },
  {
    subregion: NOC,
    lat: 33.617227592487389,
    lon: -117.93881142211259,
    surfline_id: 4225,
    spitcast_id: 607,
    spitcast_slug: '40th-street-newport-beach-ca',
    name: '40th Street'
  },
  {
    subregion: NOC,
    lat: 33.615319034584573,
    lon: -117.9369576533262,
    surfline_id: 4226,
    msw_id: 4683,
    msw_slug: '36th-St-Newport',
    spitcast_id: 608,
    spitcast_slug: '36th-street-newport-beach-ca',
    name: '36th Street'
  },
  {
    subregion: NOC,
    lat: 33.610958311825421,
    lon: -117.933626701894,
    surfline_id: 53_412,
    msw_id: 2575,
    msw_slug: 'Blackies',
    spitcast_id: 651,
    spitcast_slug: 'blackies-newport-beach-ca',
    name: 'Blackies'
  },
  {
    subregion: NOC,
    lat: 33.606646920042472,
    lon: -117.9307384511544,
    surfline_id: 4227,
    spitcast_id: 609,
    spitcast_slug: 'newport-pier-newport-beach-ca',
    name: 'Newport Pier'
  },
  {
    subregion: NOC,
    lat: 33.593389938669887,
    lon: -117.88234297040751,
    surfline_id: 4232,
    msw_id: 287,
    msw_slug: 'The-Wedge',
    spitcast_id: 217,
    spitcast_slug: 'the-wedge-newport-beach-ca',
    name: 'The Wedge'
  },
  {
    subregion: NOC,
    lat: 33.592468,
    lon: -117.875881,
    surfline_id: 4879,
    msw_id: 2579,
    msw_slug: 'Corona-Del-Mar-Jetty',
    name: 'Corona Del Mar'
  },
  {
    subregion: SOC,
    lat: 33.474665045147823,
    lon: -117.7233023880989,
    surfline_id: 4233,
    msw_id: 289,
    msw_slug: 'Salt-Creek',
    spitcast_id: 214,
    spitcast_slug: 'salt-creek-dana-point-ca',
    name: 'Salt Creek'
  },
  {
    subregion: SOC,
    lat: 33.466191,
    lon: -117.716886,
    surfline_id: 4849,
    msw_id: 4040,
    msw_slug: 'Strands-Point',
    name: 'Strands'
  },
  {
    subregion: SOC,
    lat: 33.460330858205381,
    lon: -117.6886485710755,
    surfline_id: 4848,
    msw_id: 2588,
    msw_slug: 'Doheny-State-Beach',
    spitcast_id: 213,
    spitcast_slug: 'doheny-dana-point-ca',
    name: 'Doheny'
  },
  {
    subregion: SOC,
    lat: 33.419731942886493,
    lon: -117.6212676741133,
    msw_id: 290,
    msw_slug: 'San-Clemente-Pier',
    spitcast_id: 212,
    spitcast_slug: 'san-clemente-pier-san-clemente-ca',
    name: 'San Clemente Pier'
  },
  {
    subregion: SOC,
    lat: 33.415965582403473,
    lon: -117.618142936175,
    surfline_id: 4235,
    msw_id: 2570,
    msw_slug: 'T-Street-Trafalgar-Street',
    spitcast_id: 211,
    spitcast_slug: 't-street-san-clemente-ca',
    name: 'T Street'
  },
  {
    subregion: SOC,
    lat: 33.402979968143072,
    lon: -117.6061996160215,
    surfline_id: 4843,
    spitcast_id: 392,
    spitcast_slug: 'state-park-san-clemente-ca',
    name: 'San Clemente State Beach'
  },
  {
    subregion: SOC,
    lat: 33.390612992576763,
    lon: -117.5987721491924,
    surfline_id: 4737,
    spitcast_id: 209,
    spitcast_slug: 'cottons-point-san-clemente-ca',
    name: 'Cottons'
  },
  {
    subregion: SOC,
    lat: 33.384476301377603,
    lon: -117.59445112402619,
    surfline_id: 4738,
    spitcast_id: 623,
    spitcast_slug: 'upper-trestles-san-clemente-ca',
    name: 'Upper Trestles'
  },
  {
    subregion: SOC,
    lat: 33.382116955073258,
    lon: -117.5888397460814,
    surfline_id: 4740,
    msw_id: 291,
    msw_slug: 'Trestles',
    spitcast_id: 208,
    spitcast_slug: 'lower-trestles-san-clemente-ca',
    name: 'Lower Trestles'
  },
  {
    subregion: SOC,
    lat: 33.380114554751792,
    lon: -117.5790343398904,
    surfline_id: 4741,
    spitcast_id: 625,
    spitcast_slug: 'church-san-clemente-ca',
    name: 'Church'
  },
  {
    subregion: SOC,
    lat: 33.373605466203927,
    lon: -117.56912919937839,
    surfline_id: 4237,
    msw_id: 4192,
    msw_slug: 'San-Onofre',
    spitcast_id: 239,
    spitcast_slug: 'san-onofre-san-clemente-ca',
    name: 'San Onofre'
  },
  {
    name: 'Ocean Beach',
    lat: 37.768256511796238,
    lon: -122.51347658831379,
    surfline_id: 4127,
    msw_id: 255,
    msw_slug: 'Ocean-Beach',
    spitcast_id: 117,
    spitcast_slug: 'south-ocean-beach-san-francisco-ca',
    subregion: SF,
  },
  {
    name: 'Pleasure Point',
    lat: 36.954087622045307,
    lon: -121.9716900628907,
    surfline_id: 4190,
    msw_id: 644,
    msw_slug: 'Pleasure-Point',
    spitcast_id: 1,
    spitcast_slug: 'pleasure-point-santa-cruz-ca',
    subregion: SC,
  },
  {
    name: 'Carcavelos',
    lat: 38.681209,
    lon: -9.338022,
    surfline_id: 6064,
    msw_id: 912,
    msw_slug: 'Carcavelos',
    subregion: PT,
  },
  {
    name: 'Costa da Caparica',
    lat: 38.630405,
    lon: -9.2266,
    surfline_id: 44_509,
    msw_id: 874,
    msw_slug: 'Costa-da-Caparica',
    subregion: PT,
  },
  {
    name: 'Pascuales',
    lat: 18.853,
    lon: -103.962,
    surfline_id: 59_564,
    msw_id: 333,
    msw_slug: 'Pascuales',
    subregion: COL,
  },
  {
    name: 'Rio Nexpa',
    lat: 18.082,
    lon: -102.792,
    surfline_id: 59_604,
    msw_id: 334,
    msw_slug: 'Rio-Nexpa',
    subregion: GUR,
    sort_order: 5,
  },
  {
    name: 'The Ranch',
    lat: 17.914,
    lon: -101.871,
    surfline_id: 59_606,
    msw_id: 336,
    msw_slug: 'The-Ranch',
    subregion: GUR,
    sort_order: 10,
  },
  {
    name: 'La Saladita',
    lat: 17.836,
    lon: -101.774,
    surfline_id: 59_607,
    msw_id: 838,
    msw_slug: 'La-Saladita',
    subregion: GUR,
    sort_order: 20,
  },
  {
    name: 'Troncones',
    lat: 17.794,
    lon: -101.749,
    surfline_id: 59_608,
    msw_id: 1059,
    msw_slug: 'Manzanillo-Bay',
    subregion: GUR,
    sort_order: 30,
  },
]

spots.each do |spot_data|
  spot = Spot.find_or_initialize_by(name: spot_data[:name], subregion: spot_data[:subregion])
  spot.surfline_id = spot_data[:surfline_id]
  spot.msw_id = spot_data[:msw_id]
  spot.spitcast_id = spot_data[:spitcast_id]
  spot.lat = spot_data[:lat]
  spot.lon = spot_data[:lon]
  spot.msw_slug = spot_data[:msw_slug]
  spot.spitcast_slug = spot_data[:spitcast_slug]
  spot.sort_order = spot_data[:sort_order]
  spot.save!
end
