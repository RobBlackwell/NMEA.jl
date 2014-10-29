module NMEA

# public types and methods
export NMEAData,
       parse_msg!,
       GGA,
       RMC,
       GSA,
       GSV,
       SVData,
       GBS,
       VTG,
       GLL,
       ZDA,
       DTM

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
    fix_quality::String
    num_sats::Int
    HDOP::Float64
    altitude::Float64 # MSL in meters
    geoidal_seperation::Float64 # meters
    age_of_differential::Float64 # seconds since last SC104
    diff_reference_id::Int # differential reference station id
    valid::Bool

    function GGA(sys::String)
        system = sys
        time = 0
        latitude = 0.0
        longitude = 0.0
        fix_quality = "UNKNOWN"
        num_sats = 0
        HDOP = 0.0
        altitude = 0.0
        geoidal_seperation = 0.0
        age_of_differential = 0.0
        diff_reference_id = 0
        valid = false
        new(system, time, latitude,
            longitude, fix_quality, num_sats,
            HDOP, altitude, geoidal_seperation,
            age_of_differential, diff_reference_id,
            valid)
    end # constructor GGA

end # type GGA

############################################################
# GSA
# ---
# GSA message type - GNSS DOP and Active Satellites
############################################################

type GSA
    system::String
    mode::Char
    current_mode::Int
    sat_ids::Array{Int}
    PDOP::Float64
    HDOP::Float64
    VDOP::Float64
    valid::Bool

    function GSA(sys::String)
        system = sys
        mode = 'M'
        current_mode = 0
        sat_ids = []
        PDOP = 0.0
        HDOP = 0.0
        VDOP = 0.0
        valid = false
        new(system, mode, current_mode,
            sat_ids, PDOP, HDOP,
            VDOP, valid)
    end # constructor GSA

end # type GSA

############################################################
# ZDA
# ---
# ZDA message type - Time and Date
############################################################

type ZDA
    system::String
    time::Float64
    day::Int
    month::Int
    year::Int
    zone_hrs::Int
    zone_mins::Int
    valid::Bool

    function ZDA(sys::String)
        system = sys
        time = 0.0
        day = 0
        month = 0
        year = 0
        zone_hrs = 0
        zone_mins = 0
        valid = false
        new(system, time, day,
            month, year, zone_hrs,
            zone_mins, valid)
    end # constructor ZDA

end # type ZDA

############################################################
# GBS
# ---
# GBS message type - RAIM GNSS Satellite Fault Detection
############################################################

type GBS
    system::String
    time::Float64
    lat_error::Float64
    long_error::Float64
    alt_error::Float64
    failed_PRN::Int
    prob_of_missed::Float64
    excluded_meas_err::Float64
    standard_deviation::Float64
    valid::Bool

    function GBS(sys::String)
        system = sys
        time = 0.0
        lat_error = 0.0
        long_error = 0.0
        alt_error = 0.0
        failed_PRN = 0
        prob_of_missed = 0.0
        excluded_meas_err = 0.0
        standard_deviation = 0.0
        valid = false
        new(system, time, lat_error,
            long_error, alt_error, failed_PRN,
            prob_of_missed, excluded_meas_err, standard_deviation,
            valid)
    end # constructor GBS

end # type GBS

############################################################
# GLL
# ---
# GLL message type - Geographic Position –
# Latitude/Longitude
############################################################

type GLL
    system::String
    latitude::Float64
    longitude::Float64
    time::Float64
    status::Bool
    mode::Char
    valid::Bool

    function GLL(sys::String)
        system = sys
        latitude = 0.0
        longitude = 0.0
        time = 0.0
        status = false
        mode = 'N'
        valid = false
        new(system, latitude, longitude,
            time, status, mode,
            valid)
    end # constructor GLL

end # type GLL

############################################################
# SVData
# ------
# type to store SV data fields in GSV
############################################################

type SVData
    PRN::Int
    elevation::Int
    azimuth::Int
    SNR::Int

    function SVData()
        PRN = 0
        elevation = 0
        azimuth = 0
        SNR = 0
        new(PRN, elevation, azimuth,
            SNR)
    end # constructor SVData

end # type SVData

############################################################
# GSV
# ---
# type for GSV messages - GNSS Satellites In View
############################################################

type GSV
    system::String
    msg_total::Int
    msg_num::Int
    sat_total::Int
    SV_data::Array{SVData}
    valid::Bool

    function GSV(sys::String)
        system = sys
        msg_total = 0
        msg_num = 0
        sat_total = 0
        SV_data = []
        valid = false
        new(system, msg_total, msg_num,
            sat_total, SV_data, valid)
    end # constructor GSV

end # type GSV

############################################################
# RMC
# ---
# RMC message type - Recommended Minimum Specific GNSS Data
############################################################

type RMC
    system::String
    time::Float64
    status::Char
    latitude::Float64
    longitude::Float64
    sog::Float64
    cog::Float64
    date::String
    magvar::Float64
    mode::Char
    valid::Bool

    function RMC(sys::String)
        system = sys
        time = 0.0
        status = 'V'
        latitude = 0.0
        longitude = 0.0
        sog = 0.0
        cog = 0.0
        date = ""
        magvar = 0.0
        mode = 'N'
        valid = false
        new(system, time, status,
            latitude, longitude, sog,
            cog, date, magvar,
            mode, valid)
    end # constructor RMC

end # type RMC

############################################################
# VTG
# ---
# VTG message type - Course over Ground & Ground Speed
############################################################

type VTG
    CoG_true::Float64
    CoG_mag::Float64
    SoG_knots::Float64
    SoG_kmhr::Float64
    mode::Char
    valid::Bool

    function VTG(sys::String)
        CoG_true = 0.0
        CoG_mag = 0.0
        SoG_knots = 0.0
        SoG_kmhr = 0.0
        mode = 'N'
        valid = false
        new(CoG_true, CoG_mag, SoG_knots,
            SoG_kmhr, mode, valid)
    end # constructor VTG

end # type VTG

############################################################
# DTM
# ---
# DTM message type - Datum
############################################################

type DTM
    system::String
    local_datum_code::String
    local_datum_subcode::String
    lat_offset::Float64
    long_offset::Float64
    alt_offset::Float64
    ref_datum::String
    valid::Bool

    function DTM(sys::String)
        system = sys 
        local_datum_code = ""
        local_datum_subcode = ""
        lat_offset = 0.0
        long_offset = 0.0
        alt_offset = 0.0
        ref_datum = ""
        valid = false
        
        new(system, local_datum_code, local_datum_subcode,
            lat_offset, long_offset, alt_offset,
            ref_datum, valid)
    end # constructor DTM

end # type DTM

############################################################
# NMEAData
# ------------
# IO handler settings
############################################################

type NMEAData
    last_GGA::GGA
    last_RMC::RMC
    last_GSA::GSA
    last_GSV::GSV
    last_GBS::GBS
    last_VTG::VTG
    last_GLL::GLL
    last_ZDA::ZDA
    last_DTM::DTM

    function NMEAData()
        last_GGA = GGA("UNKNOWN")
        last_RMC = RMC("UNKNOWN")
        last_GSA = GSA("UNKNOWN")
        last_GSV = GSV("UNKNOWN")
        last_GBS = GBS("UNKNOWN")
        last_VTG = VTG("UNKNOWN")
        last_GLL = GLL("UNKNOWN")
        last_ZDA = ZDA("UNKNOWN")
        last_DTM = DTM("UNKNOWN")
        new(last_GGA, last_RMC, last_GSA,
            last_GSV, last_GBS, last_VTG,
            last_GLL, last_ZDA, last_DTM)
    end # constructor NMEAData

end # type NMEAData

############################################################
# start!
# ------
# open serial port and start reading NMEAData messages
############################################################

function parse_msg!(s::NMEAData, line::String)
    message = split(line, '*')[1]
    items = split(message, ',')

    # get system name
    system = _get_system(items[1])

    mtype = ""
    if (ismatch(r"DTM$", items[1]))
        s.last_DTM = _parse_DTM(items, system)
        mtype = "DTM"
   
    elseif (ismatch(r"GBS$", items[1]))
        s.last_GBS = _parse_GBS(items, system)
        mtype = "GBS"
    
    elseif (ismatch(r"GGA$", items[1]))
        s.last_GGA = _parse_GGA(items, system)
        mtype = "GGA"
    
    elseif (ismatch(r"GLL$", items[1]))
        s.last_GLL = _parse_GLL(items, system)
        mtype = "GLL"
    
    elseif (ismatch(r"GNS$", items[1]))
        mtype = "GNS"
    
    elseif (ismatch(r"GSA$", items[1]))
        s.last_GSA = _parse_GSA(items, system)
        mtype = "GSA"
    
    elseif (ismatch(r"GSV$", items[1]))
        s.last_GSV = _parse_GSV(items, system)
        mtype = "GSV"
    
    elseif (ismatch(r"RMC$", items[1]))
        s.last_RMC = parse_RMC(items, system)
        mtype = "RMC"
    
    elseif (ismatch(r"VTG$", items[1]))
        s.last_VTG = parse_VTG(items, system)
        mtype = "VTG"
    
    elseif (ismatch(r"ZDA$", items[1]))
        s.last_ZDA = _parse_ZDA(items, system)
        mtype = "ZDA"
    else
        mtype = "PROPRIETARY"
    end
    mtype
end # function start!

############################################################
# _get_system
# -----------
# determines system from message type string
############################################################

function _get_system(mtype::SubString{ASCIIString})
    system = ""

    # GPS
    if (ismatch(r"^\$GP", mtype))
        system = "GPS"

    # GLONASS
    elseif (ismatch(r"^\$GL", mtype))
        system = "GLONASS"

    # GALILEO
    elseif (ismatch(r"^\$GA", mtype))
        system = "GALILEO"

    # Combined
    elseif (ismatch(r"^\$GN", mtype))
        system = "COMBINED"

    # Proprietary (non-NMEA standard) message
    else
        system = "UNKNOWN"
    end

    system
end # function _get_system

############################################################
# _parse_GGA
# ----------
# parses GGA messages and returns populated GGA type
############################################################

function _parse_GGA(items::Array{SubString{ASCIIString}}, system::String)
    GGA_data = GGA(system)
    GGA_data.time = _hms_to_secs(items[2])
    GGA_data.latitude = _dms_to_dd(items[3], items[4])
    GGA_data.longitude = _dms_to_dd(items[5], items[6])
    
    fix_flag = try_parse(items[7], Int, 0)
    if (fix_flag == 0)
        GGA_data.fix_quality = "INVALID"
    elseif (fix_flag == 1)
        GGA_data.fix_quality = "GPS (SPS)"
    elseif (fix_flag == 2)
        GGA_data.fix_quality = "DGPS"
    elseif (fix_flag == 3)
        GGA_data.fix_quality = "PPS"
    elseif (fix_flag == 4)
        GGA_data.fix_quality = "REAL TIME KINEMATIC"
    elseif (fix_flag == 5)
        GGA_data.fix_quality = "FLOAT RTK"
    elseif (fix_flag == 6)
        GGA_data.fix_quality = "DEAD RECKONING"
    elseif (fix_flag == 7)
        GGA_data.fix_quality = "MANUAL INPUT"
    elseif (fix_flag == 8)
        GGA_data.fix_quality = "SIMULATION"
    else
        GGA_data.fix_quality = "UNKNOWN"
    end

    GGA_data.num_sats = try_parse(items[8], Int, 0)
    GGA_data.HDOP = try_parse(items[9], Float64, 0.0)
    GGA_data.altitude = try_parse(items[10], Float64, 0.0)
    GGA_data.geoidal_seperation = try_parse(items[12], Float64, 0.0)
    GGA_data.age_of_differential = try_parse(items[14], Float64, 0.0)
    GGA_data.diff_reference_id = try_parse(items[15], Int, 0)
    GGA_data.valid = true
    GGA_data
end # function _parse_GGA

############################################################
# _parse_GSA
# ----------
# parse GSA messages
############################################################

function _parse_GSA(items::Array{SubString{ASCIIString}}, system::String)
    GSA_data = GSA(system)
    GSA_data.mode = items[2][1]
    GSA_data.current_mode = try_parse(items[3], Int, 0)

    for i = 4:length(items) - 3
        if (items[i] == "")
            break
        end
        push!(GSA_data.sat_ids, try_parse(items[i], Int, 0))
    end
    
    GSA_data.PDOP = try_parse(items[end - 2], Float64, 0.0)
    GSA_data.HDOP = try_parse(items[end - 1], Float64, 0.0)
    GSA_data.VDOP = try_parse(items[end], Float64, 0.0)
    GSA_data.valid = true
    GSA_data
end # function _parse_GSA

############################################################
# _parse_ZDA
# ----------
# parse ZDA message
############################################################

function _parse_ZDA(items::Array{SubString{ASCIIString}}, system::String)
    ZDA_data = ZDA(system)
    ZDA_data.time = _hms_to_secs(items[2])
    ZDA_data.day = try_parse(items[3], Int, 0)
    ZDA_data.month = try_parse(items[4], Int, 0)
    ZDA_data.year = try_parse(items[5], Int, 0)
    ZDA_data.zone_hrs = try_parse(items[6], Int, 0)
    ZDA_data.zone_mins = try_parse(items[7], Int, 0)
    ZDA_data.valid = true
    ZDA_data
end # function _parse_ZDA

############################################################
# _parse_GBS
# ----------
# parse GBS messages
############################################################

function _parse_GBS(items::Array{SubString{ASCIIString}}, system::String)
    GBS_data = GBS(system)
    GBS_data.time = _hms_to_secs(items[2])
    GBS_data.lat_error = try_parse(items[3], Float64, 0.0)
    GBS_data.long_error = try_parse(items[4], Float64, 0.0)
    GBS_data.alt_error = try_parse(items[5], Float64, 0.0)
    GBS_data.failed_PRN = try_parse(items[6], Int, 0)
    GBS_data.prob_of_missed = try_parse(items[7], Float64, 0.0)
    GBS_data.excluded_meas_err = try_parse(items[8], Float64, 0.0)
    GBS_data.standard_deviation = try_parse(items[9], Float64, 0.0)
    GBS_data.valid = true
    GBS_data
end # function _parse_GBS

############################################################
# _parse_GLL
# ----------
# parse GLL message
############################################################

function _parse_GLL(items::Array{SubString{ASCIIString}}, system::String)
    GLL_data = GLL(system)
    GLL_data.latitude = _dms_to_dd(items[2], items[3])
    GLL_data.longitude = _dms_to_dd(items[4], items[5])
    GLL_data.time = _hms_to_secs(items[6])

    if (items[7] == "A")
        GLL_data.status = true
    else
        GLL_data.status = false
    end

    if (items[8] != "")
        GLL_data.mode = items[8][1]
    end

    GLL_data.valid = true
    GLL_data
end # function _parse_GLL

############################################################
# _parse_GSV
# ----------
# parse GSV messages
############################################################

function _parse_GSV(items::Array{SubString{ASCIIString}}, system::String)
    GSV_data = GSV(system)
    GSV_data.msg_total = try_parse(items[2], Int, 0)
    GSV_data.msg_num = try_parse(items[3], Int, 0)
    GSV_data.sat_total = try_parse(items[4], Int, 0)

    i = 5
    while i < length(items)
        svd = SVData()
        svd.PRN = try_parse(items[i], Int, 0)
        svd.elevation = try_parse(items[i + 1], Int, 0)
        svd.azimuth = try_parse(items[i + 2], Int, 0)
        svd.SNR = try_parse(items[i + 3], Int, 0)
        push!(GSV_data.SV_data, svd)
        i += 4
    end
    
    GSV_data.valid = true
    GSV_data
end # function _parse_GSV

############################################################
# _parse_RMC
# ----------
# parse RMC messages and return populated type struct RMC
############################################################

function parse_RMC(items::Array{SubString{ASCIIString}}, system::String)
    RMC_data = RMC(system)
    RMC_data.time = _hms_to_secs(items[2])

    if (items[3] == "A")
        RMC_data.status = true
    else
        RMC_data.status = false
    end

    RMC_data.latitude = _dms_to_dd(items[4], items[5])
    RMC_data.longitude = _dms_to_dd(items[6], items[7])
    RMC_data.sog = try_parse(items[8], Float64, 0.0)
    RMC_data.cog = try_parse(items[9], Float64, 0.0)
    RMC_data.date = string(items[10][3:4], '/', items[10][1:2], '/', items[10][5:6])

    if (items[12] == "W" || items[12] == "S")
        RMC_data.magvar = try_parse(items[11], Float64, 0.0) * -1
    else
        RMC_data.magvar = try_parse(items[11], Float64, 0.0)
    end
    RMC_data.mode = items[13][1]
    RMC_data.valid = true
    RMC_data
end # function parse_RMC

############################################################
# parse_VTG
# ---------
# parses VTG messages
############################################################

function parse_VTG(items::Array{SubString{ASCIIString}}, system::String)
    VTG_data = VTG(system)
    VTG_data.CoG_true = try_parse(items[2], Float64, 0.0)
    VTG_data.CoG_mag = try_parse(items[4], Float64, 0.0)
    VTG_data.SoG_knots = try_parse(items[6], Float64, 0.0)
    VTG_data.SoG_kmhr = try_parse(items[8], Float64, 0.0)
    VTG_data.mode = items[10][1]
    VTG_data.valid = true
    VTG_data
end # function parse_VTG

############################################################
# _parse_DTM
# ----------
# parse DTM messages
############################################################

function _parse_DTM(items::Array{SubString{ASCIIString}}, system::String)
    DTM_data = DTM(system)
    DTM_data.local_datum_code = try_parse(items[2], String, "")
    DTM_data.local_datum_subcode = items[3]
    lat_offset = try_parse(items[4], Float64, 0.0)
    if (items[5] == "S")
        DTM_data.lat_offset = lat_offset * -1
    else
        DTM_data.lat_offset = lat_offset
    end

    long_offset = try_parse(items[6], Float64, 0.0)
    if (items[7] == "W")
        DTM_data.long_offset = long_offset * -1
    else
        DTM_data.long_offset = long_offset
    end

    DTM_data.alt_offset = try_parse(items[8], Float64, 0.0)
    DTM_data.ref_datum = items[9]
    DTM_data.valid = true
    DTM_data
end # function _parse_DTM

############################################################
# _dms_to_dd
# ----------
# convert degrees minutes seconds to decimal degrees
############################################################

function _dms_to_dd(dms::SubString{ASCIIString}, hemi::SubString{ASCIIString})
    if (dms[1:1] == "0")
        dms = dms[2:end]
    end

    degrees = int(dms[1:2])
    minutes = int(dms[3:4])
    seconds = int(split(dms, '.')[2])
    dec_degrees = degrees + (minutes / 60) + (seconds / 360000)

    if (hemi == "S" || hemi == "W")
        dec_degrees *= -1
    end

    dec_degrees
end # function _dms_to_dd

############################################################
# _hms_to_secs
# ------------
# hhmmss.s-s to time of day in seconds
############################################################

function _hms_to_secs(hms::SubString{ASCIIString})
    hours = int(hms[1:2])
    minutes = int(hms[3:4])
    seconds = float(hms[5:end])
    (hours * 3600) + (minutes * 60) + seconds
end # function _hms_to_secs

############################################################
# try_parse
# ---------
# try to parse item as specific type and return; if parsing
# fails return the default
############################################################

function try_parse(item::SubString{ASCIIString}, dtype::DataType, default::Any)
    try
        if (item == "" || item == nothing)
            return default
        end

        if (dtype == Float64)
            return float(item)
        end

        if (dtype == Int)
            return int(item)
        end

        if (dtype == String)
            return string(item)
        end
    catch
        default
    end
end # function try_parse

end # module NMEA
