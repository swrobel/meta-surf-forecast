Spot.reset_column_information

WaterQualityDepartment.find_or_create_by(code: 'LAPH') do |dept|
  dept.name = 'Los Angeles County Department of Public Health'
  dept.url = 'http://www.publichealth.lacounty.gov/phcommon/public/eh/water_quality/beach_grades.cfm'
end

# California
CA = Region.find_or_create_by(name: 'California', sort_order: 10)
CA.timezone = 'America/Los_Angeles'
CA.save!
SF = Subregion.find_or_create_by(name: 'San Francisco', region: CA)
SF.sort_order = 10
SF.timezone = 'America/Los_Angeles'
SF.save!
SC = Subregion.find_or_create_by(name: 'Santa Cruz', region: CA)
SC.sort_order = 20
SC.timezone = 'America/Los_Angeles'
SC.save!
SBVC = Subregion.find_or_initialize_by(name: 'Santa Barbara/Ventura', region: CA)
SBVC.sort_order = 40
SBVC.timezone = 'America/Los_Angeles'
SBVC.save!
LA = Subregion.find_or_initialize_by(name: 'Los Angeles', region: CA)
LA.sort_order = 50
LA.timezone = 'America/Los_Angeles'
LA.save!
NOC = Subregion.find_or_initialize_by(name: 'North Orange County', region: CA)
NOC.sort_order = 60
NOC.timezone = 'America/Los_Angeles'
NOC.save!
SOC = Subregion.find_or_initialize_by(name: 'South Orange County', region: CA)
SOC.sort_order = 70
SOC.timezone = 'America/Los_Angeles'
SOC.save!
NSD = Subregion.find_or_initialize_by(name: 'North San Diego', region: CA)
NSD.sort_order = 80
NSD.timezone = 'America/Los_Angeles'
NSD.save!
SSD = Subregion.find_or_initialize_by(name: 'South San Diego', region: CA)
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
]

spots.each do |spot_data|
  spot = Spot.find_or_initialize_by(name: spot_data[:name], subregion: spot_data[:subregion])
  spot.assign_attributes(spot_data)
  spot.save!
end

Buoy.find_or_create_by(region: CA, ndbc_id: 46006, lat: 40.772, lon: -137.376, name: 'SE Papa')
Buoy.find_or_create_by(region: CA, ndbc_id: 46012, lat: 37.356, lon: -122.881, name: 'Half Moon Bay')
Buoy.find_or_create_by(region: CA, ndbc_id: 46013, lat: 38.253, lon: -123.303, name: 'Bodega Bay')
Buoy.find_or_create_by(region: CA, ndbc_id: 46014, lat: 39.231, lon: -123.974, name: 'Pt Arena')
Buoy.find_or_create_by(region: CA, ndbc_id: 46022, lat: 40.703, lon: -124.554, name: 'Eel River')
Buoy.find_or_create_by(region: CA, ndbc_id: 46025, lat: 33.758, lon: -119.044, name: 'Santa Monica Basin')
Buoy.find_or_create_by(region: CA, ndbc_id: 46026, lat: 37.754, lon: -122.839, name: 'San Francisco')
Buoy.find_or_create_by(region: CA, ndbc_id: 46027, lat: 41.852, lon: -124.38, name: 'St Georges')
Buoy.find_or_create_by(region: CA, ndbc_id: 46028, lat: 35.774, lon: -121.905, name: 'Cape San Martin')
Buoy.find_or_create_by(region: CA, ndbc_id: 46042, lat: 36.785, lon: -122.398, name: 'Monterey')
Buoy.find_or_create_by(region: CA, ndbc_id: 46047, lat: 32.404, lon: -119.506, name: 'Tanner Bank')
Buoy.find_or_create_by(region: CA, ndbc_id: 46053, lat: 34.241, lon: -119.839, name: 'E Santa Barbara')
Buoy.find_or_create_by(region: CA, ndbc_id: 46054, lat: 34.265, lon: -120.477, name: 'W Santa Barbara')
Buoy.find_or_create_by(region: CA, ndbc_id: 46069, lat: 33.677, lon: -120.213, name: 'S Santa Rosa Island')
Buoy.find_or_create_by(region: CA, ndbc_id: 46086, lat: 32.499, lon: -118.052, name: 'San Clemente Basin')
Buoy.find_or_create_by(region: CA, ndbc_id: 46114, lat: 36.699, lon: -122.343, name: 'W Monterey Bay')
Buoy.find_or_create_by(region: CA, ndbc_id: 46213, lat: 40.295, lon: -124.732, name: 'Cape Mendocino')
Buoy.find_or_create_by(region: CA, ndbc_id: 46214, lat: 37.937, lon: -123.463, name: 'Point Reyes')
Buoy.find_or_create_by(region: CA, ndbc_id: 46215, lat: 35.204, lon: -120.859, name: 'Diablo Canyon')
Buoy.find_or_create_by(region: CA, ndbc_id: 46218, lat: 34.454, lon: -120.783, name: 'Harvest')
Buoy.find_or_create_by(region: CA, ndbc_id: 46219, lat: 33.225, lon: -119.882, name: 'San Nicolas Island')
Buoy.find_or_create_by(region: CA, ndbc_id: 46221, lat: 33.855, lon: -118.634, name: 'Santa Monica Bay')
Buoy.find_or_create_by(region: CA, ndbc_id: 46222, lat: 33.618, lon: -118.317, name: 'San Pedro')
Buoy.find_or_create_by(region: CA, ndbc_id: 46224, lat: 33.178, lon: -117.472, name: 'Oceanside Offshore')
Buoy.find_or_create_by(region: CA, ndbc_id: 46225, lat: 32.933, lon: -117.391, name: 'Torrey Pines Outer')
Buoy.find_or_create_by(region: CA, ndbc_id: 46232, lat: 32.517, lon: -117.425, name: 'Point Loma South')
Buoy.find_or_create_by(region: CA, ndbc_id: 46235, lat: 32.57, lon: -117.169, name: 'Imperial Beach Nearshore')
Buoy.find_or_create_by(region: CA, ndbc_id: 46237, lat: 37.786, lon: -122.635, name: 'San Francisco Bar')
Buoy.find_or_create_by(region: CA, ndbc_id: 46239, lat: 36.343, lon: -122.096, name: 'Point Sur')
Buoy.find_or_create_by(region: CA, ndbc_id: 46240, lat: 36.626, lon: -121.907, name: 'Cabrillo Point')
Buoy.find_or_create_by(region: CA, ndbc_id: 46242, lat: 33.22, lon: -117.439, name: 'Camp Pendleton Nearshore')
Buoy.find_or_create_by(region: CA, ndbc_id: 46244, lat: 40.896, lon: -124.357, name: 'Humboldt Bay, North Spit')
Buoy.find_or_create_by(region: CA, ndbc_id: 46251, lat: 33.761, lon: -119.559, name: 'Santa Cruz Basin')
Buoy.find_or_create_by(region: CA, ndbc_id: 46253, lat: 33.576, lon: -118.181, name: 'San Pedro S')
Buoy.find_or_create_by(region: CA, ndbc_id: 46254, lat: 32.868, lon: -117.267, name: 'Scripps Nearshore')
Buoy.find_or_create_by(region: CA, ndbc_id: 46256, lat: 33.7, lon: -118.201, name: 'Long Beach Channel')
Buoy.find_or_create_by(region: CA, ndbc_id: 46258, lat: 32.752, lon: -117.501, name: 'Mission Bay W')
Buoy.find_or_create_by(region: CA, ndbc_id: 46259, lat: 34.767, lon: -121.497, name: 'Santa Lucia Escarpment')
Buoy.find_or_create_by(region: CA, ndbc_id: 46266, lat: 32.957, lon: -117.279, name: 'Del Mar Nearshore')
Buoy.find_or_create_by(region: CA, ndbc_id: 46268, lat: 34.022, lon: -118.578, name: 'Topanga Nearshore')
Buoy.find_or_create_by(region: CA, ndbc_id: 46411, lat: 39.34, lon: -127.07, name: 'Mendocino')
