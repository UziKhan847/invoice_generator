class Countries {
  static final nameOfCountries = countries.keys.toList();

  static final countries = {
    "Afghanistan": {
      "provinces": [
        "BDS",
        "BGL",
        "BAL",
        "BAM",
        "DAY",
        "FRA",
        "FYB",
        "GHA",
        "GHO",
        "HEL",
        "HER",
        "JOW",
        "KAB",
        "KAN",
        "KAP",
        "KDZ",
        "KHO",
        "KNR",
        "LAG",
        "LOG",
        "NAN",
        "NIM",
        "NUR",
        "PAN",
        "PAR",
        "PIA",
        "SAM",
        "SAR",
        "TAK",
        "URU",
        "WAR",
        "ZAB"
      ],
      "phone_regex": r"^\+93\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Albania": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12"
      ],
      // These are numeric codes representing Albania's 12 counties.
      "phone_regex": r"^\+355\d{8,9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Algeria": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27",
        "28",
        "29",
        "30",
        "31",
        "32",
        "33",
        "34",
        "35",
        "36",
        "37",
        "38",
        "39",
        "40",
        "41",
        "42",
        "43",
        "44",
        "45",
        "46",
        "47",
        "48",
        "49",
        "50",
        "51",
        "52",
        "53",
        "54",
        "55",
        "56",
        "57",
        "58"
      ],
      // ISO 3166-2:DZ codes are numeric and represent the 58 wilayas (provinces)
      "phone_regex": r"^\+213\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Andorra": {
      "provinces": ["07", "02", "03", "04", "05", "06", "08"],
      // Parish codes (ISO 3166-2:AD): 07 = Andorra la Vella, etc.
      "phone_regex": r"^\+376\d{6}$",
      "postal_code_regex": r"^AD\d{3}$"
    },
    "Angola": {
      "provinces": [
        "BGO",
        "BGU",
        "BIE",
        "CAB",
        "CCU",
        "CNO",
        "CUS",
        "HUA",
        "HUI",
        "LNO",
        "LSU",
        "LUA",
        "MAL",
        "MOX",
        "NAM",
        "UIG",
        "ZAI"
      ],
      // ISO 3166-2:AO codes
      "phone_regex": r"^\+244\d{9}$",
      "postal_code_regex": r"^\d{4,5}$"
    },
    "Antigua and Barbuda": {
      "provinces": ["03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
      // Codes for parishes and dependencies, unofficial numeric identifiers
      "phone_regex": r"^\+1(268)\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Argentina": {
      "provinces": [
        "C",
        "B",
        "K",
        "H",
        "U",
        "X",
        "W",
        "E",
        "P",
        "Y",
        "L",
        "F",
        "M",
        "N",
        "Q",
        "R",
        "A",
        "J",
        "D",
        "Z",
        "S",
        "G",
        "V",
        "T"
      ],
      // ISO 3166-2:AR codes — letters for provinces
      "phone_regex": r"^\+54\d{10}$",
      "postal_code_regex": r"^[A-Z]\d{4}[A-Z]{3}$"
    },
    "Armenia": {
      "provinces": [
        "AG",
        "AR",
        "AV",
        "ER",
        "GR",
        "KT",
        "LO",
        "SH",
        "SU",
        "TV",
        "VD"
      ],
      // ISO 3166-2:AM codes
      "phone_regex": r"^\+374\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Australia": {
      "provinces": ["NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT"],
      // State/territory abbreviations
      "phone_regex": r"^\+61\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Austria": {
      "provinces": ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
      // ISO 3166-2:AT uses numeric codes (1 = Burgenland, 9 = Vienna, etc.)
      "phone_regex": r"^\+43\d{10,13}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Azerbaijan": {
      "provinces": [
        "ABS",
        "AGC",
        "AGM",
        "AGS",
        "AGU",
        "AST",
        "BA",
        "BAB",
        "BAL",
        "BAR",
        "BEY",
        "BIL",
        "CAB",
        "CAL",
        "CUL",
        "DAS",
        "FUZ",
        "GA",
        "GAD",
        "GOR",
        "GOY",
        "GYG",
        "HAC",
        "IMI",
        "ISM",
        "KAL",
        "KAN",
        "LA",
        "LAC",
        "LER",
        "MAS",
        "MI",
        "NA",
        "NEF",
        "OGU",
        "ORD",
        "QAB",
        "QAX",
        "QAZ",
        "QBA",
        "QBI",
        "QOB",
        "QUS",
        "SA",
        "SAB",
        "SAD",
        "SAH",
        "SAK",
        "SAL",
        "SAR",
        "SAT",
        "SBN",
        "SIY",
        "SM",
        "SMI",
        "SMX",
        "SR",
        "SUS",
        "TAR",
        "TOV",
        "UCA",
        "XA",
        "XAC",
        "XCI",
        "XIZ",
        "XVD",
        "YAR",
        "YE",
        "YEV",
        "ZAN",
        "ZAQ",
        "ZAR",
        "ZAQ"
      ],
      // ISO 3166-2:AZ subdivision codes
      "phone_regex": r"^\+994\d{9}$",
      "postal_code_regex": r"^AZ\d{4}$"
    },
    "Bahamas": {
      "provinces": [
        "AK",
        "BI",
        "BP",
        "BY",
        "CE",
        "CI",
        "CK",
        "CO",
        "CS",
        "EG",
        "EX",
        "FP",
        "GB",
        "HI",
        "HT",
        "IN",
        "LI",
        "MG",
        "MI",
        "NE",
        "NO",
        "RC",
        "RI",
        "SS",
        "SR",
        "SW",
        "WG"
      ],
      // Unofficial codes for islands/districts
      "phone_regex": r"^\+1(242)\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Bahrain": {
      "provinces": ["13", "14", "15", "16"],
      // ISO 3166-2:BH codes: 13 = Capital, 14 = Central, etc.
      "phone_regex": r"^\+973\d{8}$",
      "postal_code_regex": r"^\d{3,4}$"
    },
    "Bangladesh": {
      "provinces": ["A", "B", "C", "D", "E", "F", "G", "H"],
      // ISO 3166-2:BD codes — A-H representing 8 divisions
      "phone_regex": r"^\+8801[3-9]\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Barbados": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11"
      ],
      // Unofficial numeric codes for parishes
      "phone_regex": r"^\+1(246)\d{7}$",
      "postal_code_regex": r"^BB\d{5}$"
    },
    "Belarus": {
      "provinces": ["BR", "HO", "HR", "MA", "MI", "VI"],
      // ISO 3166-2:BY codes
      "phone_regex": r"^\+375(17|25|29|33|44)\d{7}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Belgium": {
      "provinces": [
        "VAN",
        "VBR",
        "WBR",
        "WHT",
        "WLG",
        "WNA",
        "WVL",
        "WLG",
        "WHT",
        "WBR",
        "WNA"
      ],
      // ISO 3166-2:BE codes (provinces + regions sometimes overlap)
      "phone_regex": r"^\+32\d{8,9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Belize": {
      "provinces": ["BZ", "CY", "CZL", "OW", "SC", "TOL"],
      // ISO 3166-2:BZ codes
      "phone_regex": r"^\+501\d{7}$",
      //"postal_code_regex": r"^$" // Belize does not use postal codes
    },
    "Benin": {
      "provinces": [
        "AK",
        "AL",
        "AQ",
        "AT",
        "BO",
        "CO",
        "DO",
        "KO",
        "LI",
        "MO",
        "OU",
        "PL"
      ],
      // ISO 3166-2:BJ codes (departments)
      "phone_regex": r"^\+229\d{8}$",
      "postal_code_regex": r"^\d{2}$" // Often only department codes used
    },
    "Bhutan": {
      "provinces": [
        "11",
        "12",
        "13",
        "14",
        "15",
        "21",
        "22",
        "23",
        "24",
        "31",
        "32",
        "33",
        "34",
        "41",
        "42",
        "43",
        "44",
        "45",
        "GA",
        "TH"
      ],
      // ISO 3166-2:BT codes for dzongkhags
      "phone_regex": r"^\+975\d{7,8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Bolivia": {
      "provinces": ["B", "C", "H", "L", "N", "O", "P", "S", "T"],
      // ISO 3166-2:BO codes (departments)
      "phone_regex": r"^\+591\d{8}$",
      "postal_code_regex":
          r"^\d{4}$" // Used in major cities, but not nationwide
    },
    "Bosnia and Herzegovina": {
      "provinces": ["BIH", "SRP", "BRC"],
      // ISO 3166-2:BA codes (2 entities and 1 district)
      "phone_regex": r"^\+387\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Botswana": {
      "provinces": ["CE", "GH", "KG", "KL", "KW", "NE", "NW", "SE", "SO"],
      // ISO 3166-2:BW codes (districts)
      "phone_regex": r"^\+267\d{7,8}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Brazil": {
      "provinces": [
        "AC",
        "AL",
        "AP",
        "AM",
        "BA",
        "CE",
        "DF",
        "ES",
        "GO",
        "MA",
        "MT",
        "MS",
        "MG",
        "PA",
        "PB",
        "PR",
        "PE",
        "PI",
        "RJ",
        "RN",
        "RS",
        "RO",
        "RR",
        "SC",
        "SP",
        "SE",
        "TO"
      ],
      // ISO 3166-2:BR codes (federal units)
      "phone_regex": r"^\+55\d{10,11}$",
      "postal_code_regex": r"^\d{5}-\d{3}$"
    },
    "Brunei": {
      "provinces": ["BE", "BM", "TE", "TU"],
      // ISO 3166-2:BN codes (districts)
      "phone_regex": r"^\+673\d{7}$",
      "postal_code_regex": r"^[A-Z]{2}\d{4}$"
    },
    "Bulgaria": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27",
        "28"
      ],
      // ISO 3166-2:BG codes (districts)
      "phone_regex": r"^\+359\d{8,9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Burkina Faso": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13"
      ],
      // ISO 3166-2:BF codes (regions)
      "phone_regex": r"^\+226\d{8}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Burundi": {
      "provinces": [
        "BB",
        "BJ",
        "BR",
        "CA",
        "CI",
        "GI",
        "KR",
        "KY",
        "KI",
        "MA",
        "MU",
        "MW",
        "MY",
        "NG",
        "RT",
        "RY",
        "RU"
      ],
      // ISO 3166-2:BI codes (provinces)
      "phone_regex": r"^\+257\d{8}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Cabo Verde": {
      "provinces": [
        "B",
        "BR",
        "BV",
        "CA",
        "CF",
        "MA",
        "MO",
        "PA",
        "PN",
        "PR",
        "RG",
        "SL",
        "SM",
        "SS",
        "SV",
        "TA"
      ],
      // ISO 3166-2:CV codes (municipalities or islands)
      "phone_regex": r"^\+238\d{7}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Cambodia": {
      "provinces": [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25"
      ],
      // ISO 3166-2:KH numeric subdivision codes
      "phone_regex": r"^\+855\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Cameroon": {
      "provinces": ["AD", "CE", "EN", "ES", "LT", "NO", "NW", "OU", "SU", "SW"],
      // ISO 3166-2:CM codes (regions)
      "phone_regex": r"^\+237[2368]\d{7}$",
      //"postal_code_regex": r"^$" // No standardized postal code system
    },
    "Canada": {
      "provinces": [
        "AB",
        "BC",
        "MB",
        "NB",
        "NL",
        "NS",
        "NT",
        "NU",
        "ON",
        "PE",
        "QC",
        "SK",
        "YT"
      ],
      // ISO 3166-2:CA codes (provinces and territories)
      "phone_regex": r'^\+?1?\s?(\(\d{3}\)|\d{3})(-|\s)?\d{3}(-|\s)?\d{4}$',
      "postal_code_regex": r'^\w\d\w\s?\d\w\d$'
    },
    "Central African Republic": {
      "provinces": [
        "AC",
        "BB",
        "BK",
        "HK",
        "HM",
        "HS",
        "KB",
        "KG",
        "LB",
        "MB",
        "MP",
        "NM",
        "OP",
        "SE",
        "UK",
        "VK"
      ],
      // ISO 3166-2:CF codes (prefectures)
      "phone_regex": r"^\+236\d{8}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Chad": {
      "provinces": [
        "BA",
        "BG",
        "BO",
        "CB",
        "EN",
        "GR",
        "HL",
        "KA",
        "LC",
        "LO",
        "LR",
        "MA",
        "MC",
        "ME",
        "MO",
        "ND",
        "OD",
        "SA",
        "SI",
        "TA",
        "TI",
        "WF"
      ],
      // ISO 3166-2:TD codes (regions)
      "phone_regex": r"^\+235\d{8}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Chile": {
      "provinces": [
        "AI",
        "AN",
        "AP",
        "AR",
        "AT",
        "BI",
        "CO",
        "LI",
        "LL",
        "MA",
        "ML",
        "NB",
        "RM",
        "TA",
        "VS"
      ],
      // ISO 3166-2:CL codes (regions)
      "phone_regex": r"^\+56\d{8,9}$",
      "postal_code_regex": r"^\d{7}$"
    },
    "China": {
      "provinces": [
        "BJ",
        "TJ",
        "HE",
        "SX",
        "NM",
        "LN",
        "JL",
        "HL",
        "SH",
        "JS",
        "ZJ",
        "AH",
        "FJ",
        "JX",
        "SD",
        "HA",
        "HB",
        "HN",
        "GD",
        "GX",
        "HI",
        "CQ",
        "SC",
        "GZ",
        "YN",
        "XZ",
        "SN",
        "GS",
        "QH",
        "NX",
        "XJ",
        "TW",
        "HK",
        "MO"
      ],
      // ISO 3166-2:CN codes (provinces, autonomous regions, municipalities, special admin regions)
      "phone_regex": r"^\+86(1\d{10}|[2-9]\d{8})$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Colombia": {
      "provinces": [
        "AMA",
        "ANT",
        "ARA",
        "ATL",
        "BOL",
        "BOY",
        "CAL",
        "CAQ",
        "CAS",
        "CAU",
        "CES",
        "CHO",
        "CUN",
        "COR",
        "DC",
        "GUA",
        "GUV",
        "HUI",
        "LAG",
        "MAG",
        "MET",
        "NAR",
        "NSA",
        "PUT",
        "QUI",
        "RIS",
        "SAN",
        "SAP",
        "SUC",
        "TOL",
        "VAC",
        "VAU",
        "VID"
      ],
      // ISO 3166-2:CO codes (departments)
      "phone_regex": r"^\+57\d{10}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Comoros": {
      "provinces": ["A", "G", "M"],
      // ISO 3166-2:KM codes (islands: Anjouan, Grande Comore, Mohéli)
      "phone_regex": r"^\+269\d{7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Congo (Brazzaville)": {
      "provinces": [
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "2",
        "5",
        "7",
        "8",
        "9"
      ],
      // ISO 3166-2:CG codes (departments)
      "phone_regex": r"^\+242\d{7,8}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Congo (Kinshasa)": {
      "provinces": [
        "BC",
        "BN",
        "EQ",
        "HK",
        "HM",
        "IT",
        "KC",
        "KE",
        "KG",
        "KL",
        "KN",
        "KS",
        "LO",
        "LU",
        "MA",
        "MN",
        "MO",
        "NK",
        "SK",
        "SU",
        "TA",
        "TO",
        "TU"
      ],
      // ISO 3166-2:CD codes (provinces)
      "phone_regex": r"^\+243\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Costa Rica": {
      "provinces": ["AL", "CR", "GU", "HO", "LI", "PU", "SA", "SJ", "ES", "CO"],
      // ISO 3166-2:CR codes (provinces)
      "phone_regex": r"^\+506\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Croatia": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20"
      ],
      // ISO 3166-2:HR codes (counties)
      "phone_regex": r"^\+385\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Cuba": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20"
      ],
      // ISO 3166-2:CU codes (provinces)
      "phone_regex": r"^\+53\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Cyprus": {
      "provinces": ["01", "02", "03", "04", "05", "06", "07", "08"],
      // ISO 3166-2:CY codes (districts)
      "phone_regex": r"^\+357\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Czech Republic": {
      "provinces": ["H", "J", "K", "M", "P", "S", "U", "Z", "BR", "PL"],
      // ISO 3166-2:CZ codes (regions)
      "phone_regex": r"^\+420\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Denmark": {
      "provinces": ["81", "82", "83", "84", "85", "86", "87", "88"],
      // ISO 3166-2:DK codes (regions)
      "phone_regex": r"^\+45\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Djibouti": {
      "provinces": ["AR", "AS", "DJ", "OB", "TA"],
      // ISO 3166-2:DJ codes (regions)
      "phone_regex": r"^\+253\d{7}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Dominica": {
      "provinces": ["10", "20", "30", "40", "50", "60", "70"],
      // ISO 3166-2:DM codes (parishes)
      "phone_regex": r"^\+1767\d{7}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Dominican Republic": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20"
      ],
      // ISO 3166-2:DO codes (provinces)
      "phone_regex": r"^\+1(809|829|849)\d{7}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Ecuador": {
      "provinces": [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z"
      ],
      // ISO 3166-2:EC codes (provinces)
      "phone_regex": r"^\+593\d{9}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Egypt": {
      "provinces": [
        "AL",
        "BA",
        "DT",
        "DT",
        "GZ",
        "IS",
        "KA",
        "KI",
        "LX",
        "MN",
        "MS",
        "NS",
        "PS",
        "QI",
        "SH",
        "SU",
        "SY",
        "UD",
        "AS"
      ],
      // ISO 3166-2:EG codes (governorates)
      "phone_regex": r"^\+20\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "El Salvador": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14"
      ],
      // ISO 3166-2:SV codes (departments)
      "phone_regex": r"^\+503\d{7}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Equatorial Guinea": {
      "provinces": ["Bioko", "Continental", "Annobón"],
      // ISO 3166-2:GQ codes (provinces)
      "phone_regex": r"^\+240\d{7}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Eritrea": {
      "provinces": ["AN", "DS", "MA", "SM", "GA", "NA", "SK", "SS"],
      // ISO 3166-2:ER codes (regions)
      "phone_regex": r"^\+291\d{7}$",
      //"postal_code_regex": r"^$" // No official postal code system
    },
    "Estonia": {
      "provinces": ["EE", "HI", "ID", "JH", "LA", "LÄ", "PA", "PI", "SA", "VL"],
      // ISO 3166-2:EE codes (counties)
      "phone_regex": r"^\+372\d{7}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Ethiopia": {
      "provinces": [
        "AA",
        "AF",
        "AM",
        "BG",
        "DN",
        "GE",
        "HR",
        "OR",
        "SN",
        "SO",
        "SP",
        "TI",
        "YA"
      ],
      // ISO 3166-2:ET codes (regions)
      "phone_regex": r"^\+251\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Fiji": {
      "provinces": ["C", "E", "M", "R", "V"],
      // ISO 3166-2:FJ codes (divisions)
      "phone_regex": r"^\+679\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Finland": {
      "provinces": [
        "AH",
        "ES",
        "IS",
        "IT",
        "KA",
        "KA",
        "KO",
        "LA",
        "LS",
        "PA",
        "PO",
        "PI",
        "SA",
        "SL",
        "TA",
        "UP",
        "VS"
      ],
      // ISO 3166-2:FI codes (regions)
      "phone_regex": r"^\+358\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "France": {
      "provinces": [
        "A",
        "AD",
        "AI",
        "AL",
        "AM",
        "AN",
        "AP",
        "AR",
        "AS",
        "AT",
        "AU",
        "AUV",
        "BA",
        "BFC",
        "BG",
        "BHI",
        "BL",
        "BO",
        "BR",
        "BU",
        "CA",
        "CC",
        "CH",
        "CO",
        "CS",
        "CV",
        "D",
        "DE",
        "DOM",
        "ED",
        "EES",
        "EP",
        "ES",
        "FR",
        "GA",
        "GR",
        "GU",
        "H",
        "HD",
        "HR",
        "IC",
        "IDF",
        "IL",
        "IN",
        "K",
        "LA",
        "LAR",
        "LC",
        "LE",
        "LF",
        "LL",
        "LN",
        "LO",
        "LR",
        "MA",
        "MD",
        "MG",
        "MH",
        "MO",
        "MOM",
        "MU",
        "NE",
        "NO",
        "NR",
        "NT",
        "NS",
        "NY",
        "OCC",
        "OR",
        "PD",
        "PE",
        "PL",
        "PM",
        "PACA",
        "PC",
        "PDL",
        "PI",
        "PO",
        "PS",
        "PY"
      ],
      // ISO 3166-2:FR codes (regions)
      "phone_regex": r"^\+33\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Gabon": {
      "provinces": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
      // ISO 3166-2:GA codes (provinces)
      "phone_regex": r"^\+241\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Gambia": {
      "provinces": [
        "Banjul",
        "Central River",
        "Lower River",
        "North Bank",
        "Upper River",
        "Western"
      ],
      // ISO 3166-2:GM codes (regions)
      "phone_regex": r"^\+220\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Georgia": {
      "provinces": ["AB", "AJ", "GE", "SK", "SZ", "TL", "KK", "RZ"],
      // ISO 3166-2:GE codes (regions)
      "phone_regex": r"^\+995\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Germany": {
      "provinces": [
        "BW",
        "BY",
        "BE",
        "BB",
        "HB",
        "HE",
        "MV",
        "NI",
        "NW",
        "RP",
        "SL",
        "SN",
        "ST",
        "SH",
        "TH"
      ],
      // ISO 3166-2:DE codes (states)
      "phone_regex": r"^\+49\d{10,11}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Ghana": {
      "provinces": ["AH", "BA", "C", "EP", "GV", "NE", "NR", "OT", "UE", "WR"],
      // ISO 3166-2:GH codes (regions)
      "phone_regex": r"^\+233\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Greece": {
      "provinces": ["A", "C", "GR", "NC", "PE", "RA", "SP", "TH", "WC"],
      // ISO 3166-2:GR codes (regions)
      "phone_regex": r"^\+30\d{10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Grenada": {
      "provinces": ["01", "02", "03", "04", "05", "06"],
      // ISO 3166-2:GD codes (parishes)
      "phone_regex": r"^\+1473\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Guatemala": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20"
      ],
      // ISO 3166-2:GT codes (departments)
      "phone_regex": r"^\+502\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Guinea": {
      "provinces": [
        "Boke",
        "Conakry",
        "Faranah",
        "Kankan",
        "Kindia",
        "Labé",
        "Mamou",
        "Nzérékoré"
      ],
      // ISO 3166-2:GN codes (regions)
      "phone_regex": r"^\+224\d{8}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Guinea-Bissau": {
      "provinces": [
        "Bafata",
        "Biombo",
        "Bissau",
        "Bolama",
        "Cacheu",
        "Gabu",
        "Oio",
        "Quinara",
        "Tombali"
      ],
      // ISO 3166-2:GW codes (regions)
      "phone_regex": r"^\+245\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Guyana": {
      "provinces": [
        "BAR",
        "BES",
        "CBE",
        "COO",
        "DEM",
        "ESSE",
        "MAHA",
        "POS",
        "UPPER"
      ],
      // ISO 3166-2:GY codes (regions)
      "phone_regex": r"^\+592\d{7}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Haiti": {
      "provinces": [
        "AR",
        "CE",
        "GA",
        "ND",
        "NE",
        "NI",
        "NO",
        "OU",
        "SD",
        "SE",
        "SU",
        "GA"
      ],
      // ISO 3166-2:HT codes (departments)
      "phone_regex": r"^\+509\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Honduras": {
      "provinces": [
        "AT",
        "CH",
        "CL",
        "CM",
        "CP",
        "CR",
        "EP",
        "FM",
        "GD",
        "IN",
        "IB",
        "LE",
        "LP",
        "OC",
        "OL",
        "SB",
        "VA",
        "YO"
      ],
      // ISO 3166-2:HN codes (departments)
      "phone_regex": r"^\+504\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Hungary": {
      "provinces": [
        "BK",
        "BA",
        "BE",
        "BC",
        "BZ",
        "CS",
        "FE",
        "GS",
        "HB",
        "HE",
        "JN",
        "KE",
        "KO",
        "NO",
        "PE",
        "SO",
        "SZ",
        "TO",
        "VA",
        "VE",
        "ZA"
      ],
      // ISO 3166-2:HU codes (counties)
      "phone_regex": r"^\+36\d{8,9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Iceland": {
      "provinces": ["1", "2", "3", "4", "5", "6", "7", "8"],
      // ISO 3166-2:IS codes (regions)
      "phone_regex": r"^\+354\d{7}$",
      "postal_code_regex": r"^\d{3}$"
    },
    "India": {
      "provinces": [
        "AN",
        "AP",
        "AR",
        "AS",
        "BR",
        "CH",
        "CT",
        "DL",
        "DN",
        "GA",
        "GJ",
        "HR",
        "HP",
        "JH",
        "JK",
        "KA",
        "KL",
        "LD",
        "MP",
        "MH",
        "MN",
        "ML",
        "MZ",
        "NL",
        "OD",
        "PB",
        "PY",
        "RJ",
        "SK",
        "TN",
        "TS",
        "TR",
        "UP",
        "UK",
        "WB"
      ],
      // ISO 3166-2:IN codes (states and union territories)
      "phone_regex": r"^\+91\d{10}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Indonesia": {
      "provinces": [
        "AC",
        "BA",
        "BB",
        "BE",
        "BT",
        "GO",
        "JA",
        "JB",
        "JI",
        "JK",
        "JT",
        "JW",
        "KA",
        "KB",
        "KI",
        "KR",
        "KS",
        "KT",
        "LA",
        "MA",
        "ML",
        "MU",
        "NB",
        "NT",
        "PA",
        "PB",
        "RI",
        "SA",
        "SB",
        "SG",
        "SL",
        "SM",
        "SN",
        "SR",
        "ST",
        "SU",
        "YO"
      ],
      // ISO 3166-2:ID codes (provinces)
      "phone_regex": r"^\+62\d{8,11}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Iran": {
      "provinces": [
        "ARD",
        "ESF",
        "EAZ",
        "FA",
        "GI",
        "GO",
        "HD",
        "HO",
        "IL",
        "KE",
        "KD",
        "KH",
        "KN",
        "KO",
        "KZ",
        "LO",
        "MA",
        "MK",
        "MN",
        "NK",
        "QO",
        "QM",
        "SB",
        "SM",
        "TE",
        "YZ",
        "ZA"
      ],
      // ISO 3166-2:IR codes (provinces)
      "phone_regex": r"^\+98\d{10}$",
      "postal_code_regex": r"^\d{10}$"
    },
    "Iraq": {
      "provinces": [
        "AN",
        "AR",
        "BA",
        "BB",
        "BG",
        "BK",
        "DA",
        "DI",
        "DQ",
        "KA",
        "KI",
        "MA",
        "MU",
        "NA",
        "NI",
        "QA",
        "SD",
        "SU",
        "WA"
      ],
      // ISO 3166-2:IQ codes (governorates)
      "phone_regex": r"^\+964\d{10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Ireland": {
      "provinces": [
        "C",
        "CE",
        "CN",
        "CW",
        "D",
        "DL",
        "G",
        "KE",
        "KK",
        "KY",
        "LD",
        "LH",
        "LM",
        "LS",
        "LK",
        "MO",
        "OY",
        "RN",
        "SO",
        "TA",
        "TY",
        "WD",
        "WH",
        "WX",
        "WW"
      ],
      // ISO 3166-2:IE codes (counties)
      "phone_regex": r"^\+353\d{9}$",
      "postal_code_regex": r"^[A-Z0-9]{3,4} ?[A-Z0-9]{4}$" // Eircode
    },
    "Italy": {
      "provinces": [
        "AG",
        "AL",
        "AN",
        "AO",
        "AR",
        "AP",
        "AT",
        "AV",
        "BA",
        "BT",
        "BL",
        "BN",
        "BG",
        "BI",
        "BO",
        "BZ",
        "BS",
        "BR",
        "CA",
        "CL",
        "CB",
        "CI",
        "CE",
        "CT",
        "CZ",
        "CH",
        "CO",
        "CS",
        "CR",
        "KR",
        "CN",
        "EN",
        "FM",
        "FE",
        "FI",
        "FG",
        "FC",
        "FR",
        "GE",
        "GO",
        "GR",
        "IM",
        "IS",
        "AQ",
        "SP",
        "LT",
        "LE",
        "LC",
        "LI",
        "LO",
        "LU",
        "MC",
        "MN",
        "MS",
        "MT",
        "ME",
        "MI",
        "MO",
        "MB",
        "NA",
        "NO",
        "NU",
        "OR",
        "PD",
        "PA",
        "PR",
        "PV",
        "PG",
        "PU",
        "PE",
        "PC",
        "PI",
        "PT",
        "PN",
        "PZ",
        "PO",
        "RG",
        "RA",
        "RC",
        "RE",
        "RI",
        "RN",
        "RM",
        "RO",
        "SA",
        "SS",
        "SV",
        "SI",
        "SR",
        "SO",
        "TA",
        "TE",
        "TR",
        "TO",
        "TP",
        "TN",
        "TV",
        "TS",
        "UD",
        "VA",
        "VE",
        "VB",
        "VC",
        "VR",
        "VV",
        "VI"
      ],
      "phone_regex": r"^\+39\d{6,10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Jamaica": {
      "provinces": [
        "13",
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "14"
      ],
      // ISO 3166-2:JM parish codes (numeric or written as per local use)
      "phone_regex": r"^\+1(876|658)\d{7}$",
      //"postal_code_regex": r"^$" // Not widely used, may follow "JMAPPNN"
    },
    "Japan": {
      "provinces": [
        "JP-01",
        "JP-02",
        "JP-03",
        "JP-04",
        "JP-05",
        "JP-06",
        "JP-07",
        "JP-08",
        "JP-09",
        "JP-10",
        "JP-11",
        "JP-12",
        "JP-13",
        "JP-14",
        "JP-15",
        "JP-16",
        "JP-17",
        "JP-18",
        "JP-19",
        "JP-20",
        "JP-21",
        "JP-22",
        "JP-23",
        "JP-24",
        "JP-25",
        "JP-26",
        "JP-27",
        "JP-28",
        "JP-29",
        "JP-30",
        "JP-31",
        "JP-32",
        "JP-33",
        "JP-34",
        "JP-35",
        "JP-36",
        "JP-37",
        "JP-38",
        "JP-39",
        "JP-40",
        "JP-41",
        "JP-42",
        "JP-43",
        "JP-44",
        "JP-45",
        "JP-46",
        "JP-47"
      ],
      "phone_regex": r"^\+81\d{9,10}$",
      "postal_code_regex": r"^\d{3}-\d{4}$"
    },
    "Jordan": {
      "provinces": [
        "AJ",
        "AM",
        "AQ",
        "AT",
        "AZ",
        "BA",
        "IR",
        "JA",
        "KA",
        "MN",
        "MD",
        "MA"
      ],
      // ISO 3166-2:JO codes (governorates)
      "phone_regex": r"^\+962\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Kazakhstan": {
      "provinces": [
        "AKM",
        "AKT",
        "ALA",
        "ALM",
        "AST",
        "ATY",
        "KAR",
        "KUS",
        "KZY",
        "MAN",
        "PAV",
        "SEV",
        "VOS",
        "YUZ",
        "ZAP",
        "ZHA"
      ],
      "phone_regex": r"^\+7(7\d{9}|6\d{9})$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Kenya": {
      "provinces": [
        "KE-01",
        "KE-02",
        "KE-03",
        "KE-04",
        "KE-05",
        "KE-06",
        "KE-07",
        "KE-08",
        "KE-09",
        "KE-10",
        "KE-11",
        "KE-12",
        "KE-13",
        "KE-14",
        "KE-15",
        "KE-16",
        "KE-17",
        "KE-18",
        "KE-19",
        "KE-20",
        "KE-21",
        "KE-22",
        "KE-23",
        "KE-24",
        "KE-25",
        "KE-26",
        "KE-27",
        "KE-28",
        "KE-29",
        "KE-30",
        "KE-31",
        "KE-32",
        "KE-33",
        "KE-34",
        "KE-35",
        "KE-36",
        "KE-37",
        "KE-38",
        "KE-39",
        "KE-40",
        "KE-41",
        "KE-42",
        "KE-43",
        "KE-44",
        "KE-45",
        "KE-46",
        "KE-47"
      ],
      // 47 counties, ISO 3166-2:KE
      "phone_regex": r"^\+254\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Kiribati": {
      "provinces": ["G", "L", "P"],
      // Gilbert, Line, Phoenix island groups
      "phone_regex": r"^\+686\d{5}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Kuwait": {
      "provinces": ["AH", "FA", "HA", "JA", "KU", "MU"],
      // ISO 3166-2:KW (governorates)
      "phone_regex": r"^\+965\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Kyrgyzstan": {
      "provinces": ["B", "C", "GB", "J", "N", "O", "T", "Y"],
      // ISO 3166-2:KG
      "phone_regex": r"^\+996\d{9}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Laos": {
      "provinces": [
        "AT",
        "BK",
        "BL",
        "BP",
        "CH",
        "HO",
        "KH",
        "LM",
        "LP",
        "OU",
        "PH",
        "SL",
        "SV",
        "VT",
        "XA",
        "XE",
        "XI",
        "XS"
      ],
      // ISO 3166-2:LA codes
      "phone_regex": r"^\+856\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Latvia": {
      "provinces": [
        "LV-001",
        "LV-002",
        "LV-003",
        "LV-004",
        "LV-005",
        "LV-006",
        "LV-007"
      ],
      // Historical districts; modern Latvia doesn't use administrative regions in ISO-3166
      "phone_regex": r"^\+371\d{8}$",
      "postal_code_regex": r"^LV-\d{4}$"
    },
    "Lebanon": {
      "provinces": ["BA", "BI", "AS", "JL", "NA", "MN", "JA", "AK"],
      // ISO 3166-2:LB governorates
      "phone_regex": r"^\+961\d{7,8}$",
      "postal_code_regex": r"^\d{4}(\d{4})?$"
    },
    "Lesotho": {
      "provinces": ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K"],
      // ISO 3166-2:LS districts
      "phone_regex": r"^\+266\d{8}$",
      "postal_code_regex": r"^\d{3}$"
    },
    "Liberia": {
      "provinces": [
        "BM",
        "BG",
        "CM",
        "GB",
        "GG",
        "GK",
        "LO",
        "MG",
        "MO",
        "MY",
        "NI",
        "RI",
        "SI"
      ],
      // ISO 3166-2:LR counties
      "phone_regex": r"^\+231\d{7,8}$",
      //"postal_code_regex": r"^$" // No standard postal code system
    },
    "Libya": {
      "provinces": [
        "BA",
        "BU",
        "DR",
        "GT",
        "JA",
        "JG",
        "JH",
        "JI",
        "JU",
        "KB",
        "MI",
        "MQ",
        "NL",
        "SB",
        "SR",
        "TB",
        "WD",
        "ZA"
      ],
      // ISO 3166-2:LY
      "phone_regex": r"^\+218\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Liechtenstein": {
      "provinces": [
        "LI-01",
        "LI-02",
        "LI-03",
        "LI-04",
        "LI-05",
        "LI-06",
        "LI-07",
        "LI-08",
        "LI-09",
        "LI-10",
        "LI-11"
      ],
      // ISO 3166-2:LI municipalities
      "phone_regex": r"^\+423\d{7}$",
      "postal_code_regex": r"^949[0-9]$"
    },
    "Lithuania": {
      "provinces": ["AL", "KA", "KL", "MR", "PN", "SA", "TA", "TE", "UT", "VL"],
      // ISO 3166-2:LT counties
      "phone_regex": r"^\+370\d{8}$",
      "postal_code_regex": r"^LT-\d{5}$"
    },
    "Luxembourg": {
      "provinces": ["LU-D", "LU-G", "LU-L"],
      // ISO 3166-2:LU districts (no longer used administratively, but ISO codes still valid)
      "phone_regex": r"^\+352\d{6,9}$",
      "postal_code_regex": r"^L-\d{4}$"
    },
    "Madagascar": {
      "provinces": ["A", "F", "M", "T", "D", "U"],
      // Former provinces before decentralization
      "phone_regex": r"^\+261\d{7,9}$",
      "postal_code_regex": r"^\d{3}$"
    },
    "Malawi": {
      "provinces": ["C", "N", "S"],
      // Central, Northern, Southern regions
      "phone_regex": r"^\+265\d{7,9}$",
      //"postal_code_regex": r"^$" // No standard postal code system
    },
    "Malaysia": {
      "provinces": [
        "MY-01",
        "MY-02",
        "MY-03",
        "MY-04",
        "MY-05",
        "MY-06",
        "MY-07",
        "MY-08",
        "MY-09",
        "MY-10",
        "MY-11",
        "MY-12",
        "MY-13",
        "MY-14",
        "MY-15",
        "MY-16"
      ],
      // Includes 13 states + 3 federal territories
      "phone_regex": r"^\+60\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Maldives": {
      "provinces": ["MLE", "SE", "SW", "NO", "CE", "SU", "NS"],
      // Historical provinces (currently divided into atolls)
      "phone_regex": r"^\+960\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Mali": {
      "provinces": ["BKO", "7", "1", "8", "2", "9", "5", "3", "4", "6"],
      // ISO 3166-2:ML includes Bamako + regions (numeric codes)
      "phone_regex": r"^\+223\d{8}$",
      //"postal_code_regex": r"^$" // No standard postal code system
    },
    "Malta": {
      "provinces": ["01", "02", "03", "04", "05", "06"],
      // District codes used for statistical purposes
      "phone_regex": r"^\+356\d{8}$",
      "postal_code_regex": r"^[A-Z]{3} \d{4}$"
    },
    "Marshall Islands": {
      "provinces": [
        "ALL",
        "ALK",
        "ARN",
        "AUR",
        "EBO",
        "ENI",
        "JAB",
        "KIL",
        "LAE",
        "LIB",
        "LIK",
        "MAJ",
        "MAL",
        "MEJ",
        "NAM",
        "NMG",
        "RON",
        "UJA",
        "UTI",
        "WTH"
      ],
      // Atolls and islands
      "phone_regex": r"^\+692\d{7}$",
      "postal_code_regex": r"^969[67]$" // US ZIP codes used
    },
    "Mauritania": {
      "provinces": [
        "07",
        "03",
        "05",
        "08",
        "04",
        "10",
        "01",
        "02",
        "09",
        "11",
        "06",
        "12",
        "NKC"
      ],
      // ISO 3166-2:MR — includes Nouakchott as a capital district
      "phone_regex": r"^\+222\d{8}$",
      //"postal_code_regex": r"^$" // No formal system
    },
    "Mauritius": {
      "provinces": [
        "AG",
        "BL",
        "BR",
        "CC",
        "FL",
        "GP",
        "MO",
        "PA",
        "PE",
        "PL",
        "PW",
        "RO",
        "RR",
        "SA"
      ],
      // Districts and dependencies
      "phone_regex": r"^\+230\d{7}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Mexico": {
      "provinces": [
        "AGU",
        "BCN",
        "BCS",
        "CAM",
        "CHP",
        "CHH",
        "COA",
        "COL",
        "DIF",
        "DUR",
        "GUA",
        "GRO",
        "HID",
        "JAL",
        "MEX",
        "MIC",
        "MOR",
        "NAY",
        "NLE",
        "OAX",
        "PUE",
        "QUE",
        "ROO",
        "SLP",
        "SIN",
        "SON",
        "TAB",
        "TAM",
        "TLA",
        "VER",
        "YUC",
        "ZAC"
      ],
      "phone_regex": r"^\+52\d{10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Micronesia": {
      "provinces": ["KSA", "PNI", "TRK", "YAP"],
      // Chuuk, Kosrae, Pohnpei, Yap (state codes)
      "phone_regex": r"^\+691\d{7}$",
      "postal_code_regex": r"^969[4-5]$" // US ZIPs used
    },
    "Moldova": {
      "provinces": [
        "BA",
        "CU",
        "ED",
        "GA",
        "UN",
        "SN",
        "SD",
        "CA",
        "CH",
        "CL",
        "CM",
        "CS",
        "CT",
        "DO",
        "DR",
        "DU",
        "FA",
        "FL",
        "GL",
        "HI",
        "IA",
        "LE",
        "NI",
        "OC",
        "OR",
        "RE",
        "RI",
        "SI",
        "SO",
        "ST",
        "SV",
        "TA",
        "TE",
        "UT"
      ],
      // ISO 3166-2:MD codes for districts, municipalities, ATU Gagauzia, etc.
      "phone_regex": r"^\+373\d{8}$",
      "postal_code_regex": r"^MD-\d{4}$"
    },
    "Monaco": {
      "provinces": [
        "MC-CL",
        "MC-CO",
        "MC-FO",
        "MC-GA",
        "MC-JE",
        "MC-LA",
        "MC-MA",
        "MC-MC",
        "MC-MG",
        "MC-MO",
        "MC-MU",
        "MC-PO",
        "MC-SD",
        "MC-SO",
        "MC-SP",
        "MC-VR"
      ],
      // 17 administrative quarters
      "phone_regex": r"^\+377\d{6,8}$",
      "postal_code_regex": r"^980\d{2}$"
    },
    "Mongolia": {
      "provinces": [
        "073",
        "037",
        "041",
        "053",
        "057",
        "061",
        "065",
        "039",
        "043",
        "046",
        "049",
        "051",
        "059",
        "063",
        "067",
        "069",
        "071",
        "047",
        "035",
        "091",
        "1"
      ],
      // ISO 3166-2:MN codes
      "phone_regex": r"^\+976\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Montenegro": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23"
      ],
      // Municipalities (ISO 3166-2:ME)
      "phone_regex": r"^\+382\d{8,9}$",
      "postal_code_regex": r"^8\d{4}$"
    },
    "Morocco": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12"
      ],
      // 12 administrative regions
      "phone_regex": r"^\+212[5-7]\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Mozambique": {
      "provinces": [
        "MPM",
        "GZ",
        "IB",
        "MN",
        "MC",
        "NP",
        "A",
        "B",
        "L",
        "N",
        "P",
        "Q",
        "S",
        "T",
        "Z"
      ],
      // ISO 3166-2:MZ — includes Maputo City (MPM)
      "phone_regex": r"^\+258\d{8,9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Myanmar": {
      "provinces": [
        "07",
        "02",
        "03",
        "04",
        "01",
        "05",
        "06",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17"
      ],
      // States/Regions (ISO 3166-2:MM)
      "phone_regex": r"^\+95\d{7,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Namibia": {
      "provinces": [
        "CA",
        "ER",
        "HA",
        "KA",
        "KH",
        "KU",
        "OD",
        "OH",
        "OK",
        "ON",
        "OS",
        "OT",
        "OW",
        "ZI"
      ],
      // ISO 3166-2:NA regions
      "phone_regex": r"^\+264\d{7,8}$",
      //"postal_code_regex": r"^$" // No postal code system in use
    },
    "Nauru": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14"
      ],
      // 14 districts (ISO 3166-2:NR)
      "phone_regex": r"^\+674\d{7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Nepal": {
      "provinces": ["P1", "P2", "P3", "P4", "P5", "P6", "P7"],
      // 7 provinces (e.g., Koshi, Madhesh, etc.)
      "phone_regex": r"^\+977\d{8,10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Netherlands": {
      "provinces": [
        "DR",
        "FL",
        "FR",
        "GE",
        "GR",
        "LI",
        "NB",
        "NH",
        "OV",
        "UT",
        "ZE",
        "ZH"
      ],
      // 12 provinces (ISO 3166-2:NL)
      "phone_regex": r"^\+31\d{9}$",
      "postal_code_regex": r"^\d{4}\s?[A-Z]{2}$"
    },
    "New Zealand": {
      "provinces": [
        "AUK",
        "BOP",
        "CAN",
        "GIS",
        "HKB",
        "MBH",
        "MWT",
        "NSN",
        "NTL",
        "OTA",
        "STL",
        "TAS",
        "TKI",
        "WGN",
        "WKO",
        "WTC",
        "CHC"
      ],
      // Regions and unitary authorities (ISO 3166-2:NZ)
      "phone_regex": r"^\+64\d{8,10}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Nicaragua": {
      "provinces": [
        "BO",
        "CA",
        "CI",
        "CO",
        "ES",
        "GR",
        "JI",
        "LE",
        "MD",
        "MN",
        "MS",
        "MT",
        "NS",
        "RI",
        "SJ"
      ],
      // ISO 3166-2:NI departments
      "phone_regex": r"^\+505\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Niger": {
      "provinces": ["1", "2", "3", "4", "5", "6", "7", "8"],
      // ISO 3166-2:NE regions including Niamey
      "phone_regex": r"^\+227\d{8}$",
      //"postal_code_regex": r"^$" // No formal system
    },
    "Nigeria": {
      "provinces": [
        "AB",
        "AD",
        "AK",
        "AN",
        "BA",
        "BE",
        "BO",
        "BY",
        "CR",
        "DE",
        "EB",
        "ED",
        "EK",
        "EN",
        "FC",
        "GO",
        "IM",
        "JI",
        "KD",
        "KE",
        "KN",
        "KO",
        "KT",
        "KW",
        "LA",
        "NA",
        "NI",
        "OG",
        "ON",
        "OS",
        "OY",
        "PL",
        "RI",
        "SO",
        "TA",
        "YO",
        "ZA"
      ],
      // 36 states + Federal Capital Territory (ISO 3166-2:NG)
      "phone_regex": r"^\+234\d{10}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "North Korea": {
      "provinces": [
        "CHA",
        "HAB",
        "HAN",
        "HWB",
        "HWN",
        "KAE",
        "KAN",
        "NAM",
        "NAS",
        "NYA",
        "PHY",
        "PYG",
        "YAN"
      ],
      // ISO 3166-2:KP
      "phone_regex": r"^\+850\d{6,8}$",
      //"postal_code_regex": r"^$" // Not publicly used
    },
    "North Macedonia": {
      "provinces": ["01", "02", "03", "04", "05", "06", "07", "08"],
      // Statistical regions (ISO 3166-2:MK)
      "phone_regex": r"^\+389\d{8,9}$",
      "postal_code_regex": r"^1\d{3}$"
    },
    "Norway": {
      "provinces": [
        "03",
        "11",
        "15",
        "18",
        "30",
        "34",
        "38",
        "42",
        "46",
        "50",
        "54"
      ],
      // Counties (fylker) - ISO 3166-2:NO
      "phone_regex": r"^\+47\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Oman": {
      "provinces": ["DA", "BA", "MA", "MU", "SH", "WU", "ZA", "ZA-WU"],
      // Governorates (ISO 3166-2:OM)
      "phone_regex": r"^\+968\d{7,8}$",
      "postal_code_regex": r"^\d{3}$"
    },
    "Pakistan": {
      "provinces": ["JK", "BA", "GB", "IS", "KP", "PB", "SD"],
      // Provinces and territories (ISO 3166-2:PK)
      "phone_regex": r"^\+92\d{10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Palau": {
      "provinces": [
        "002",
        "004",
        "010",
        "050",
        "100",
        "150",
        "212",
        "214",
        "218",
        "222",
        "224",
        "226",
        "227",
        "228",
        "350",
        "370"
      ],
      // 16 states (ISO 3166-2:PW)
      "phone_regex": r"^\+680\d{7}$",
      "postal_code_regex": r"^96940$"
    },
    "Palestine": {
      "provinces": [
        "GZA",
        "HBN",
        "JEM",
        "JEN",
        "JRH",
        "KYS",
        "NBS",
        "QQA",
        "RFH",
        "SLT",
        "TBS",
        "TKM"
      ],
      // Governorates (ISO 3166-2:PS)
      "phone_regex": r"^\+970\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Panama": {
      "provinces": [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "EM",
        "KY",
        "NB",
        "NT"
      ],
      // Provinces and indigenous regions (ISO 3166-2:PA)
      "phone_regex": r"^\+507\d{7,8}$",
      "postal_code_regex": r"^\d{4,5}$"
    },
    "Papua New Guinea": {
      "provinces": [
        "CPK",
        "CPM",
        "EBR",
        "ESW",
        "GU",
        "HLA",
        "JWK",
        "MBA",
        "MPL",
        "MRL",
        "MPM",
        "MOR",
        "NCD",
        "NIK",
        "NSA",
        "SAN",
        "SHM",
        "WBK",
        "WHM"
      ],
      // Provinces, districts, and autonomous regions (ISO 3166-2:PG)
      "phone_regex": r"^\+675\d{7,8}$",
      "postal_code_regex": r"^\d{3}$"
    },
    "Paraguay": {
      "provinces": [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "ASU"
      ],
      // Departments + capital (ISO 3166-2:PY)
      "phone_regex": r"^\+595\d{7,9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Peru": {
      "provinces": [
        "AMA",
        "ANC",
        "APU",
        "ARE",
        "AYA",
        "CAJ",
        "CUS",
        "HUC",
        "HUV",
        "ICA",
        "JUN",
        "LAL",
        "LAM",
        "LIM",
        "LOR",
        "MDD",
        "MOQ",
        "PAS",
        "PIU",
        "PUN",
        "SAM",
        "TAC",
        "TUM",
        "UCA",
        "CAL"
      ],
      // Regions and Callao (ISO 3166-2:PE)
      "phone_regex": r"^\+51\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Philippines": {
      "provinces": [
        "ABR",
        "AGN",
        "AGS",
        "AKL",
        "ALB",
        "ANT",
        "APA",
        "AUR",
        "BAS",
        "BAN",
        "BTN",
        "BEN",
        "BIL",
        "BOH",
        "BUK",
        "BUL",
        "CAG",
        "CAN",
        "CAP",
        "CAM",
        "CAT",
        "CAV",
        "CEB",
        "COM",
        "DAV",
        "DIN",
        "EAS",
        "GUI",
        "IFU",
        "ILI",
        "ILN",
        "ILS",
        "ISA",
        "KAL",
        "LAG",
        "LAN",
        "LEY",
        "MAG",
        "MAD",
        "MDC",
        "MDO",
        "MPL",
        "MSR",
        "MOU",
        "MSC",
        "MOU",
        "NEC",
        "NER",
        "NSA",
        "NUE",
        "NVO",
        "OCC",
        "NCM",
        "PAM",
        "PAN",
        "QUE",
        "QUI",
        "RIZ",
        "ROM",
        "SAR",
        "SIG",
        "SLE",
        "SLU",
        "SUN",
        "SUK",
        "SUR",
        "TAR",
        "TAW",
        "WSA",
        "ZAN",
        "ZAS",
        "ZMB",
        "ZSI"
      ],
      // Provinces (ISO 3166-2:PH)
      "phone_regex": r"^\+63\d{10}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Poland": {
      "provinces": [
        "DS",
        "KP",
        "LU",
        "LB",
        "LD",
        "MA",
        "MZ",
        "OP",
        "PK",
        "PD",
        "PM",
        "SL",
        "SK",
        "WN",
        "WP",
        "ZP"
      ],
      // Voivodeships (ISO 3166-2:PL)
      "phone_regex": r"^\+48\d{9}$",
      "postal_code_regex": r"^\d{2}-\d{3}$"
    },
    "Portugal": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "20",
        "30"
      ],
      // Districts + autonomous regions (ISO 3166-2:PT)
      "phone_regex": r"^\+351\d{9}$",
      "postal_code_regex": r"^\d{4}-\d{3}$"
    },
    "Qatar": {
      "provinces": ["DA", "KH", "MS", "RA", "SH", "UL", "WA"],
      // ISO 3166-2:QA (municipalities)
      "phone_regex": r"^\+974\d{8}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Republic of the Congo": {
      "provinces": [
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "2",
        "5",
        "7",
        "8",
        "9",
        "BZV"
      ],
      // Departments (ISO 3166-2:CG)
      "phone_regex": r"^\+242\d{6,7}$",
      //"postal_code_regex": r"^$" // No formal system
    },
    "Romania": {
      "provinces": [
        "AB",
        "AR",
        "AG",
        "BC",
        "BH",
        "BN",
        "BR",
        "BT",
        "BV",
        "BZ",
        "CS",
        "CL",
        "CJ",
        "CT",
        "CV",
        "DB",
        "DJ",
        "GL",
        "GR",
        "GJ",
        "HR",
        "HD",
        "IL",
        "IS",
        "IF",
        "MM",
        "MH",
        "MS",
        "NT",
        "OT",
        "PH",
        "SM",
        "SJ",
        "SB",
        "SV",
        "TR",
        "TM",
        "TL",
        "VS",
        "VL",
        "VN",
        "B"
      ],
      // Counties + Bucharest (ISO 3166-2:RO)
      "phone_regex": r"^\+40\d{9}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Russia": {
      "provinces": [
        "AD",
        "AL",
        "ALT",
        "AMU",
        "ARK",
        "AST",
        "BA",
        "BEL",
        "BRY",
        "CE",
        "CHE",
        "CHU",
        "CU",
        "DA",
        "IN",
        "IRK",
        "IVA",
        "KAM",
        "KB",
        "KC",
        "KDA",
        "KEM",
        "KGD",
        "KGN",
        "KHA",
        "KHM",
        "KIR",
        "KK",
        "KL",
        "KLU",
        "KO",
        "KOS",
        "KR",
        "KRS",
        "KYA",
        "LEN",
        "LIP",
        "MAG",
        "ME",
        "MO",
        "MOS",
        "MOW",
        "MUR",
        "NEN",
        "NGR",
        "NIZ",
        "NVS",
        "OMS",
        "ORE",
        "ORL",
        "PER",
        "PNZ",
        "PRI",
        "PSK",
        "ROS",
        "RYA",
        "SA",
        "SAK",
        "SAM",
        "SAR",
        "SE",
        "SPE",
        "SMO",
        "STA",
        "SVE",
        "TA",
        "TAM",
        "TOM",
        "TUL",
        "TVE",
        "TY",
        "TYU",
        "UD",
        "ULY",
        "VGG",
        "VLA",
        "VLG",
        "VOR",
        "YAN",
        "YAR",
        "YEV",
        "ZAB"
      ],
      // Federal subjects (ISO 3166-2:RU)
      "phone_regex": r"^\+7\d{10}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Rwanda": {
      "provinces": ["01", "02", "03", "04", "05"],
      // Provinces (ISO 3166-2:RW)
      "phone_regex": r"^\+250\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Saint Kitts and Nevis": {
      "provinces": [
        "KN01",
        "KN02",
        "KN03",
        "KN04",
        "KN05",
        "KN06",
        "KN07",
        "KN08",
        "KN09",
        "KN10",
        "KN11",
        "KN12",
        "KN13",
        "KN14"
      ],
      // Parishes (ISO 3166-2:KN)
      "phone_regex": r"^\+1-869\d{7}$",
      //"postal_code_regex": r"^$" // No formal postal code
    },
    "Saint Lucia": {
      "provinces": [
        "LC-01",
        "LC-02",
        "LC-03",
        "LC-04",
        "LC-05",
        "LC-06",
        "LC-07",
        "LC-08",
        "LC-09",
        "LC-10",
        "LC-11"
      ],
      // Quarters (ISO 3166-2:LC)
      "phone_regex": r"^\+1-758\d{7}$",
      "postal_code_regex": r"^LC\d{2} \d{3}$"
    },
    "Saint Vincent and the Grenadines": {
      "provinces": ["VC-01", "VC-02", "VC-03", "VC-04", "VC-05", "VC-06"],
      // Parishes (ISO 3166-2:VC)
      "phone_regex": r"^\+1-784\d{7}$",
      "postal_code_regex": r"^VC\d{4}$"
    },
    "Samoa": {
      "provinces": [
        "AA",
        "AL",
        "AT",
        "FA",
        "GE",
        "GI",
        "PA",
        "SA",
        "TU",
        "VF",
        "VS"
      ],
      // Districts (ISO 3166-2:WS)
      "phone_regex": r"^\+685\d{5,7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "San Marino": {
      "provinces": ["01", "02", "03", "04", "05", "06", "07", "08", "09"],
      // Municipalities (ISO 3166-2:SM)
      "phone_regex": r"^\+378\d{6,10}$",
      "postal_code_regex": r"^4789\d$"
    },
    "Sao Tome and Principe": {
      "provinces": ["P", "S"],
      // Provinces: Príncipe and São Tomé (ISO 3166-2:ST)
      "phone_regex": r"^\+239\d{7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Saudi Arabia": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "14"
      ],
      // Regions (ISO 3166-2:SA)
      "phone_regex": r"^\+9665\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Senegal": {
      "provinces": [
        "DB",
        "DK",
        "FK",
        "KA",
        "KD",
        "KL",
        "LG",
        "MT",
        "SL",
        "SE",
        "TC",
        "TH",
        "ZG",
        "ZT"
      ],
      // Regions (ISO 3166-2:SN)
      "phone_regex": r"^\+221\d{7,8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Serbia": {
      "provinces": [
        "00",
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19"
      ],
      // Districts (ISO 3166-2:RS)
      "phone_regex": r"^\+381\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Seychelles": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27"
      ],
      // Districts (ISO 3166-2:SC)
      "phone_regex": r"^\+248\d{6}$",
      //"postal_code_regex": r"^$" // No official system
    },
    "Sierra Leone": {
      "provinces": ["E", "N", "NW", "S", "W"],
      // Provinces (ISO 3166-2:SL)
      "phone_regex": r"^\+232\d{8}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Singapore": {
      "provinces": ["SG"],
      // City-state (ISO 3166-2:SG)
      "phone_regex": r"^\+65\d{8}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Slovakia": {
      "provinces": ["BC", "BL", "KI", "NI", "PV", "TC", "ZI", "TA"],
      // Regions (ISO 3166-2:SK)
      "phone_regex": r"^\+421\d{8,9}$",
      "postal_code_regex": r"^\d{3} \d{2}$"
    },
    "Slovenia": {
      "provinces": [
        "001", "002", "003", "004", "005", "006", "007", "008", "009", "010",
        "011", "012"
        // …up to "213" (all municipalities)
      ],
      // Municipalities (ISO 3166-2:SI)
      "phone_regex": r"^\+386\d{7,8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Solomon Islands": {
      "provinces": ["CE", "CH", "GU", "IS", "MK", "ML", "RB", "TE", "WE"],
      // Provinces (ISO 3166-2:SB)
      "phone_regex": r"^\+677\d{5,7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Somalia": {
      "provinces": [
        "AW",
        "BK",
        "BN",
        "BR",
        "BY",
        "GA",
        "GE",
        "HI",
        "JD",
        "JH",
        "MU",
        "NU",
        "SA",
        "SD",
        "SH",
        "SO",
        "TO",
        "WO"
      ],
      // Regions (ISO 3166-2:SO)
      "phone_regex": r"^\+252\d{7,9}$",
      "postal_code_regex": r"^252\d{5}$" // used informally
    },
    "South Africa": {
      "provinces": ["EC", "FS", "GP", "KZN", "LP", "MP", "NC", "NW", "WC"],
      // Provinces (ISO 3166-2:ZA)
      "phone_regex": r"^\+27\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "South Korea": {
      "provinces": [
        "11",
        "26",
        "27",
        "28",
        "29",
        "30",
        "31",
        "41",
        "42",
        "43",
        "44",
        "45",
        "46",
        "47",
        "48",
        "49",
        "50"
      ],
      // Provinces and metropolitan cities (ISO 3166-2:KR)
      "phone_regex": r"^\+82\d{8,9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "South Sudan": {
      "provinces": ["BN", "BW", "EC", "EE", "EW", "JG", "LK", "NU", "UY", "WR"],
      // States (ISO 3166-2:SS)
      "phone_regex": r"^\+211\d{7,9}$",
      //"postal_code_regex": r"^$" // No official system
    },
    "Spain": {
      "provinces": [
        "AN",
        "AR",
        "AS",
        "CB",
        "CE",
        "CL",
        "CM",
        "CN",
        "CT",
        "EX",
        "GA",
        "IB",
        "MC",
        "MD",
        "ML",
        "NC",
        "PV",
        "RI",
        "VC"
      ],
      // Autonomous communities (ISO 3166-2:ES)
      "phone_regex": r"^\+34\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Sri Lanka": {
      "provinces": ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
      // Provinces (ISO 3166-2:LK)
      "phone_regex": r"^\+94\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Sudan": {
      "provinces": [
        "KH",
        "RN",
        "RS",
        "NR",
        "NB",
        "NO",
        "DN",
        "KS",
        "DW",
        "DC",
        "DE",
        "GD",
        "GK",
        "KJ",
        "NB",
        "NN",
        "RD",
        "WD"
      ],
      // States (ISO 3166-2:SD)
      "phone_regex": r"^\+249\d{9}$",
      //"postal_code_regex": r"^$" // Not widely used
    },
    "Suriname": {
      "provinces": ["BR", "CM", "CR", "MA", "NI", "PM", "PR", "SA", "SI", "WA"],
      // Districts (ISO 3166-2:SR)
      "phone_regex": r"^\+597\d{6,7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Sweden": {
      "provinces": [
        "AB",
        "AC",
        "BD",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "K",
        "M",
        "N",
        "O",
        "S",
        "T",
        "U",
        "W",
        "X",
        "Y",
        "Z"
      ],
      // Counties (ISO 3166-2:SE)
      "phone_regex": r"^\+46\d{7,9}$",
      "postal_code_regex": r"^\d{3} \d{2}$"
    },
    "Switzerland": {
      "provinces": [
        "AG",
        "AI",
        "AR",
        "BE",
        "BL",
        "BS",
        "FR",
        "GE",
        "GL",
        "GR",
        "JU",
        "LU",
        "NE",
        "NW",
        "OW",
        "SG",
        "SH",
        "SO",
        "SZ",
        "TG",
        "TI",
        "UR",
        "VD",
        "VS",
        "ZG",
        "ZH"
      ],
      // Cantons (ISO 3166-2:CH)
      "phone_regex": r"^\+41\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Syria": {
      "provinces": [
        "DI",
        "DR",
        "HA",
        "HI",
        "HL",
        "HM",
        "ID",
        "LA",
        "QU",
        "RA",
        "RD",
        "SU",
        "TA"
      ],
      // Governorates (ISO 3166-2:SY)
      "phone_regex": r"^\+963\d{7,9}$",
      "postal_code_regex": r"^\d{4,6}$"
    },
    "Taiwan": {
      "provinces": ["FZ", "KS", "KE", "LP", "TC", "TY", "CY", "TP", "YLN"],
      // Provinces and municipalities (ISO 3166-2:TW)
      "phone_regex": r"^\+886\d{9}$",
      "postal_code_regex": r"^\d{3,5}$"
    },
    "Tajikistan": {
      "provinces": ["GB", "KH", "RA", "SU", "TA", "TO"],
      // Provinces (ISO 3166-2:TJ)
      "phone_regex": r"^\+992\d{9}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Tanzania": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15"
      ],
      // Regions (ISO 3166-2:TZ)
      "phone_regex": r"^\+255\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Thailand": {
      "provinces": [
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27",
        "28",
        "29",
        "30",
        "31",
        "32",
        "33"
      ],
      // Provinces (ISO 3166-2:TH)
      "phone_regex": r"^\+66\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Timor-Leste": {
      "provinces": [
        "DILI",
        "BAUCAU",
        "AILEU",
        "LIQUIÇA",
        "ERMERA",
        "VICENTE",
        "MANUFAHI"
      ],
      // Districts (ISO 3166-2:TL)
      "phone_regex": r"^\+670\d{7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Togo": {
      "provinces": ["C", "K", "L", "M", "T"],
      // Regions (ISO 3166-2:TG)
      "phone_regex": r"^\+228\d{6}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Trinidad and Tobago": {
      "provinces": ["D", "F", "P", "S", "T"],
      // Regions (ISO 3166-2:TT)
      "phone_regex": r"^\+1-868\d{7}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Tunisia": {
      "provinces": [
        "13",
        "14",
        "21",
        "22",
        "23",
        "31",
        "32",
        "33",
        "41",
        "42",
        "43",
        "51",
        "52",
        "53",
        "61",
        "62",
        "63",
        "71",
        "72",
        "73",
        "81",
        "82",
        "83",
        "91",
        "92"
      ],
      // Governorates (ISO 3166-2:TN)
      "phone_regex": r"^\+216\d{8}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Turkey": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27",
        "28",
        "29",
        "30",
        "31",
        "32",
        "33",
        "34",
        "35",
        "36",
        "37",
        "38",
        "39",
        "40",
        "41",
        "42",
        "43",
        "44",
        "45",
        "46",
        "47",
        "48",
        "49",
        "50",
        "51",
        "52",
        "53",
        "54",
        "55",
        "56",
        "57",
        "58",
        "59"
      ],
      // Provinces (ISO 3166-2:TR)
      "phone_regex": r"^\+90\d{10}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Turkmenistan": {
      "provinces": ["AK", "BA", "DA", "LR", "MA", "MU", "NS", "SI", "TA"],
      // Provinces (ISO 3166-2:TM)
      "phone_regex": r"^\+993\d{8}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Tuvalu": {
      "provinces": ["FUNAFUTI", "NUI", "VAIKUNU", "TAFUNA", "NIULI"],
      // Islands (ISO 3166-2:TV)
      "phone_regex": r"^\+688\d{4}$",
      //"postal_code_regex": r"^$" // No formal postal code system
    },
    "Uganda": {
      "provinces": ["Central", "Eastern", "Northern", "Western"],
      // Regions (ISO 3166-2:UG)
      "phone_regex": r"^\+256\d{9}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Ukraine": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20"
      ],
      // Oblasts (ISO 3166-2:UA)
      "phone_regex": r"^\+380\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "UAE": {
      "provinces": ["AZ", "DU", "FU", "SH", "RA", "UJ"],
      // Emirates (ISO 3166-2:AE)
      "phone_regex": r"^\+971\d{9}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "UK": {
      "provinces": ["ENG", "WLS", "SCT", "NIR"],
      // Countries and regions (ISO 3166-2:GB)
      "phone_regex": r"^\+44\d{10}$",
      "postal_code_regex": r"^[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}$"
    },
    "USA": {
      "provinces": [
        "AL",
        "AK",
        "AZ",
        "AR",
        "CA",
        "CO",
        "CT",
        "DE",
        "FL",
        "GA",
        "HI",
        "ID",
        "IL",
        "IN",
        "IA",
        "KS",
        "KY",
        "LA",
        "ME",
        "MD",
        "MA",
        "MI",
        "MN",
        "MS",
        "MO",
        "MT",
        "NE",
        "NV",
        "NH",
        "NJ",
        "NM",
        "NY",
        "NC",
        "ND",
        "OH",
        "OK",
        "OR",
        "PA",
        "RI",
        "SC",
        "SD",
        "TN",
        "TX",
        "UT",
        "VT",
        "VA",
        "WA",
        "WV",
        "WI",
        "WY"
      ],
      // States (ISO 3166-2:US)
      "phone_regex": r'^\+?1?\s?(\(\d{3}\)|\d{3})(-|\s)?\d{3}(-|\s)?\d{4}$',
      "postal_code_regex": r"^\d{5}(-\d{4})?$"
    },
    "Uruguay": {
      "provinces": [
        "AR",
        "CA",
        "CO",
        "DI",
        "FD",
        "FS",
        "LA",
        "MA",
        "MO",
        "PA",
        "RI",
        "RO",
        "SA",
        "SO",
        "TA",
        "TT",
        "TT"
      ],
      // Departments (ISO 3166-2:UY)
      "phone_regex": r"^\+598\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Uzbekistan": {
      "provinces": [
        "AN",
        "BU",
        "FA",
        "JI",
        "KH",
        "NA",
        "NG",
        "SR",
        "SU",
        "TA",
        "TK",
        "UZ",
        "XO",
        "YR"
      ],
      // Regions (ISO 3166-2:UZ)
      "phone_regex": r"^\+998\d{9}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Vanuatu": {
      "provinces": ["MA", "SA", "TA", "PE", "HA", "VA"],
      // Provinces (ISO 3166-2:VU)
      "phone_regex": r"^\+678\d{4}$",
      //"postal_code_regex": r"^$" // No postal code system
    },
    "Vatican City": {
      "provinces": ["Vatican City"],
      // City-state (ISO 3166-2:VA)
      "phone_regex": r"^\+379\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Venezuela": {
      "provinces": [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U"
      ],
      // States (ISO 3166-2:VE)
      "phone_regex": r"^\+58\d{10}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Vietnam": {
      "provinces": ["SG", "HN", "HP", "HCM", "QD", "QN", "HP"],
      // Regions and municipalities (ISO 3166-2:VN)
      "phone_regex": r"^\+84\d{9}$",
      "postal_code_regex": r"^\d{6}$"
    },
    "Yemen": {
      "provinces": [
        "AD",
        "AM",
        "AL",
        "AL",
        "DA",
        "DH",
        "HA",
        "HU",
        "IB",
        "JA",
        "MA",
        "MA",
        "SH",
        "SA",
        "TA",
        "TA",
        "AD"
      ],
      // Governorates (ISO 3166-2:YE)
      "phone_regex": r"^\+967\d{8}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Zambia": {
      "provinces": [
        "01",
        "02",
        "03",
        "04",
        "05",
        "06",
        "07",
        "08",
        "09",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15"
      ],
      // Provinces (ISO 3166-2:ZM)
      "phone_regex": r"^\+260\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
    "Zimbabwe": {
      "provinces": ["BU", "MA", "ME", "MI", "MU", "MA", "MAT", "MAS"],
      // Provinces (ISO 3166-2:ZW)
      "phone_regex": r"^\+263\d{9}$",
      "postal_code_regex": r"^\d{4}$"
    },
    "Zaire": {
      "provinces": [
        "BAS",
        "EQU",
        "KIN",
        "KAT",
        "KVC",
        "MAS",
        "MBO",
        "NOR",
        "SUD",
        "ULT"
      ],
      // Provinces (ISO 3166-2:ZR)
      "phone_regex": r"^\+243\d{9}$",
      "postal_code_regex": r"^\d{5}$"
    },
  };
}
