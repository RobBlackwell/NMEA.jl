############################################################
# GGA
# ---
# type for GGA message - Global Positioning System Fix Data
############################################################

type GGA
    system::String # GPS, GLONASS, GALILEO, or Combined
    fix_time::Float64 # in seconds
    latitude::Float64 # decimal degrees
    longitude::Float64 # decimal degrees
    fix_flag::Int
    num_satellites::Int
    HDOP::Float64
    altitude::Float64 # MSL in meters
    geoidal_seperation::Float64 # meters
    age_of_differential::Float64 # seconds since last SC104
    diff_reference_id::Int # differential reference station id
    data_validity::Bool

    function GGA()
        system = "UNKNOWN"
        fix_time = 0
        latitude = 0.0
        longitude = 0.0
        fix_flag = 0
        num_satellites = 0
        HDOP = 0.0
        altitude = 0.0
        geoidal_seperation = 0.0
        age_of_differential = 0.0
        diff_reference_id = 0
        data_validity = false
        new (system, fix_time, latitude,
             longitude, fix_flag, num_satellites,
             HDOP, altitude, geoidal_seperation,
             age_of_differential, diff_reference_id, data_validity)
    end # constructor GGA

end # type GGA

############################################################
# _parseGGA
# ---------
# parses GGA messages and returns populated GGA type
############################################################

function _parseGPSFixData(items::Array{SubString{ASCIIString}}, system::String)
    fix_data = GGA()
    fix_data.system = system
    return fix_data
end # function parseGPSFixData
