// const continents = [
//   {
//     'name': 'Asia',
//     'assetsPath': 'assets/city/asia_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/590478/pexels-photo-590478.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
//   {
//     'name': 'Africa',
//     'assetsPath': 'assets/city/africa_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/34098/south-africa-hluhluwe-giraffes-pattern.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
//   {
//     'name': 'Antarctica',
//     'assetsPath': 'assets/city/antarctica_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/689784/pexels-photo-689784.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
//   {
//     'name': 'Europe',
//     'assetsPath': 'assets/city/europe_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/773471/pexels-photo-773471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
//   {
//     'name': 'North America',
//     'assetsPath': 'assets/city/north_america_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/290386/pexels-photo-290386.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
//   {
//     'name': 'South America',
//     'assetsPath': 'assets/city/south_america_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/7499998/pexels-photo-7499998.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
//   {
//     'name': 'Oceania',
//     'assetsPath': 'assets/city/oceania_cities.json',
//     'avatarUrl':
//         'https://images.pexels.com/photos/6574640/pexels-photo-6574640.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//   },
// ];

final weatherImages = {
  '01d': 'assets/images/clear_sky.jpg',
  '01n': 'assets/images/clear_sky.jpg',
  '02d': 'assets/images/few_clouds.jpg',
  '02n': 'assets/images/few_clouds.jpg',
  '03d': 'assets/images/scattered_clouds.jpg',
  '03n': 'assets/images/scattered_clouds.jpg',
  '04d': 'assets/images/broken_clouds.jpg',
  '04n': 'assets/images/broken_clouds.jpg',
  '09d': 'assets/images/shower_rain.jpg',
  '09n': 'assets/images/shower_rain.jpg',
  '10d': 'assets/images/rain.jpg',
  '10n': 'assets/images/rain.jpg',
  '11d': 'assets/images/thunderstorm.jpg',
  '11n': 'assets/images/thunderstorm.jpg',
  '13d': 'assets/images/snow.jpg',
  '13n': 'assets/images/snow.jpg',
  '50d': 'assets/images/mist.jpg',
  '50n': 'assets/images/mist.jpg',
};

const continentsAndCitiesData = [
  {
    'name': 'Asia',
    'avatarUrl':
        'https://images.pexels.com/photos/590478/pexels-photo-590478.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 1733046,
        "name": "Kuala Lumpur",
        "state": "",
        "country": "MY",
        "coord": {"lon": 101.686531, "lat": 3.14309}
      },
      {
        "id": 1733047,
        "name": "Pulau Pinang",
        "state": "",
        "country": "MY",
        "coord": {"lon": 100.258476, "lat": 5.37677}
      },
      {
        "id": 1733049,
        "name": "Johor",
        "state": "",
        "country": "MY",
        "coord": {"lon": 103.5, "lat": 2}
      },
      {
        "id": 1819729,
        "name": "Hong Kong",
        "state": "",
        "country": "HK",
        "coord": {"lon": 114.157692, "lat": 22.285521}
      },
      {
        "id": 1850147,
        "name": "Tokyo",
        "state": "",
        "country": "JP",
        "coord": {"lon": 139.691711, "lat": 35.689499}
      },
      {
        "id": 1835847,
        "name": "Seoul",
        "state": "",
        "country": "KR",
        "coord": {"lon": 127.0, "lat": 37.583328}
      },
      {
        "id": 1609348,
        "name": "Bangkok",
        "state": "",
        "country": "TH",
        "coord": {"lon": 100.71991, "lat": 13.87719}
      },
      {
        "id": 1880252,
        "name": "Singapore",
        "state": "",
        "country": "SG",
        "coord": {"lon": 103.850067, "lat": 1.28967}
      }
    ]
  },
  {
    'name': 'Africa',
    'avatarUrl':
        'https://images.pexels.com/photos/34098/south-africa-hluhluwe-giraffes-pattern.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 2314302,
        "name": "Kinshasa",
        "state": "",
        "country": "CD",
        "coord": {"lon": 15.32146, "lat": -4.32459}
      },
      {
        "id": 2332459,
        "name": "Lagos",
        "state": "",
        "country": "NG",
        "coord": {"lon": 3.39583, "lat": 6.45306}
      },
      {
        "id": 360630,
        "name": "Cairo",
        "state": "",
        "country": "EG",
        "coord": {"lon": 31.24967, "lat": 30.06263}
      },
      {
        "id": 360995,
        "name": "Giza",
        "state": "",
        "country": "EG",
        "coord": {"lon": 31.21093, "lat": 30.00808}
      },
      {
        "id": 184742,
        "name": "Nairobi",
        "state": "",
        "country": "KE",
        "coord": {"lon": 36.833328, "lat": -1.28333}
      }
    ]
  },
  {
    'name': 'Antarctica',
    'avatarUrl':
        'https://images.pexels.com/photos/689784/pexels-photo-689784.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 6696480,
        "name": "McMurdo Station",
        "state": "",
        "country": "AQ",
        "coord": {"lon": 168.222656, "lat": -77.65535}
      }
    ]
  },
  {
    'name': 'Europe',
    'avatarUrl':
        'https://images.pexels.com/photos/773471/pexels-photo-773471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 2643743,
        "name": "London",
        "state": "",
        "country": "GB",
        "coord": {"lon": -0.12574, "lat": 51.50853}
      },
      {
        "id": 2968815,
        "name": "Paris",
        "state": "",
        "country": "FR",
        "coord": {"lon": 2.3486, "lat": 48.853401}
      },
      {
        "id": 5202009,
        "name": "Moscow",
        "state": "PA",
        "country": "US",
        "coord": {"lon": -75.518517, "lat": 41.33675}
      },
      {
        "id": 5245497,
        "name": "Berlin",
        "state": "WI",
        "country": "US",
        "coord": {"lon": -88.943451, "lat": 43.96804}
      },
      {
        "id": 6359304,
        "name": "Madrid",
        "state": "",
        "country": "ES",
        "coord": {"lon": -3.68275, "lat": 40.489349}
      }
    ]
  },
  {
    'name': 'North America',
    'avatarUrl':
        'https://images.pexels.com/photos/290386/pexels-photo-290386.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 5174095,
        "name": "Toronto",
        "state": "OH",
        "country": "US",
        "coord": {"lon": -80.600906, "lat": 40.46423}
      },
      {
        "id": 5128581,
        "name": "New York City",
        "state": "NY",
        "country": "US",
        "coord": {"lon": -74.005966, "lat": 40.714272}
      },
      {
        "id": 6077271,
        "name": "Montreal River",
        "state": "",
        "country": "CA",
        "coord": {"lon": -84.649918, "lat": 47.233372}
      },
      {
        "id": 6621230,
        "name": "San Francisco",
        "state": "",
        "country": "BO",
        "coord": {"lon": -64.681183, "lat": -20.75375}
      }
    ]
  },
  {
    'name': 'South America',
    'avatarUrl':
        'https://images.pexels.com/photos/7499998/pexels-photo-7499998.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 3448433,
        "name": "São Paulo",
        "state": "",
        "country": "BR",
        "coord": {"lon": -49.0, "lat": -22.0}
      },
      {
        "id": 3936452,
        "name": "Lima",
        "state": "",
        "country": "PE",
        "coord": {"lon": -76.638893, "lat": -12.00389}
      },
      {
        "id": 5095808,
        "name": "Bogota",
        "state": "NJ",
        "country": "US",
        "coord": {"lon": -74.029861, "lat": 40.876209}
      }
    ]
  },
  {
    'name': 'Oceania',
    'avatarUrl':
        'https://images.pexels.com/photos/6574640/pexels-photo-6574640.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'cities': [
      {
        "id": 2147714,
        "name": "Sydney",
        "state": "",
        "country": "AU",
        "coord": {"lon": 151.207321, "lat": -33.867851}
      },
      {
        "id": 2158177,
        "name": "Melbourne",
        "state": "",
        "country": "AU",
        "coord": {"lon": 144.963318, "lat": -37.813999}
      },
      {
        "id": 2179537,
        "name": "Wellington",
        "state": "",
        "country": "NZ",
        "coord": {"lon": 174.775574, "lat": -41.28664}
      },
      {
        "id": 2198148,
        "name": "Suva",
        "state": "",
        "country": "FJ",
        "coord": {"lon": 178.441483, "lat": -18.141609}
      }
    ]
  },
];
