include("TryParse.jl")

############################################################
# GGA
# ---
# type for GGA message - Global Positioning System Fix Data
############################################################

type GGA
    system::String # GPS, GLONASS, GALILEO, or Combined
    time::Float64 # in seconds
    latitude::Float64 # decimal degrees
    longitude::Float64 # decimal degrees
    flag::Int
    num_sats::Int
    HDOP::Float64
    altitude::Float64 # MSL in meters
    geoidal_seperation::Float64 # meters
    age_of_differential::Float64 # seconds since last SC104
    diff_reference_id::Int # differential reference station id

    function GGA(sys::String)
        system = sys
        time = 0
        latitude = 0.0
        longitude = 0.0
        flag = 0
        num_sats = 0
        HDOP = 0.0
        altitude = 0.0
        geoidal_seperation = 0.0
        age_of_differential = 0.0
        diff_reference_id = 0
        data_validity = false
        new (system, time, latitude,
             longitude, flag, num_sats,
             HDOP, altitude, geoidal_seperation,
             age_of_differential, diff_reference_id)
    end # constructor GGA

end # type GGA

############################################################
# parse_GGA
# ---------
# parses GGA messages and returns populated GGA type
############################################################

function parse_GGA(items::Array{SubString{ASCIIString}}, system::String)
    fix_data = GGA(system)
    fix_data.time = _hms_to_secs(items[2])
    fix_data.latitude = _dms_to_dd(items[3], items[4])
    fix_data.longitude = _dms_to_dd(items[5], items[6])
    fix_data.flag = tryint(items[7])
    fix_data.num_sats = tryint(items[8])
    fix_data.HDOP = tryfloat(items[9])
    fix_data.altitude = tryfloat(items[10])
    fix_data.geoidal_seperation = tryfloat(items[12])
    fix_data.age_of_differential = tryfloat(items[14])
    fix_data.diff_reference_id = tryint(items[15])

    return fix_data
end # function parseGPSFixData
