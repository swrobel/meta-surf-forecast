WaterQualityDepartment.create(name: 'Los Angeles County Department of Public Health', code: 'LAPH', url: 'http://www.publichealth.lacounty.gov/phcommon/public/eh/water_quality/beach_grades.cfm')

Spot.create(
  [
    {
      name: 'Venice Breakwater',
      lat: 33.983161270783711,
      lon: -118.4742634651619,
      surfline_id: 4211,
      msw_id: 2611,
      spitcast_id: 204,
    },
    {
      name: 'Santa Monica Pier',
      msw_id: 280,
    },
    {
      name: 'Manhattan Beach',
      msw_id: 281,
    },
    {
      name: 'Torrance Beach/Haggertys',
      msw_id: 2604,
    },
    {
      name: 'Hermosa Beach',
      msw_id: 2607,
    },
    {
      name: 'El Porto',
      surfline_id: 4900,
      msw_id: 2677,
    },
    {
      name: 'Sunset Blvd',
      msw_id: 3673,
    },
    {
      name: 'Redondo Breakwall',
      msw_id: 4208,
    },
  ]
)
