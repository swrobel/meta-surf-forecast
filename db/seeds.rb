# frozen_string_literal: true

WaterQualityDepartment.find_or_create_by(code: 'LAPH') do |dept|
  dept.name = 'Los Angeles County Department of Public Health'
  dept.url = 'http://www.publichealth.lacounty.gov/phcommon/public/eh/water_quality/beach_grades.cfm'
end

LA = Subregion.find_or_create_by(name: 'Los Angeles')
SC = Subregion.find_or_create_by(name: 'Santa Cruz')
SF = Subregion.find_or_create_by(name: 'San Francisco')

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
]

spots.each do |spot_data|
  spot = Spot.find_or_initialize_by(surfline_id: spot_data[:surfline_id], msw_id: spot_data[:msw_id], spitcast_id: spot_data[:spitcast_id])
  spot.name = spot_data[:name]
  spot.lat = spot_data[:lat]
  spot.lon = spot_data[:lon]
  spot.subregion = spot_data[:subregion]
  spot.msw_slug = spot_data[:msw_slug]
  spot.spitcast_slug = spot_data[:spitcast_slug]
  spot.save!
end
