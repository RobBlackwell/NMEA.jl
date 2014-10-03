module NMEA

# public types and methods
export NMEASettings,
       parse_line!,
       GGA,
       RMC,
       GSA,
       GSV,
       SVData,
       GBS,
       VTG,
       GLL,
       ZDA

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
        new(system, time, latitude,
            longitude, flag, num_sats,
            HDOP, altitude, geoidal_seperation,
            age_of_differential, diff_reference_id)
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

    function GSA(sys::String)
        system = sys
        mode = 'M'
        current_mode = 0
        sat_ids = []
        PDOP = 0.0
        HDOP = 0.0
        VDOP = 0.0
        new(system, mode, current_mode,
            sat_ids, PDOP, HDOP,
            VDOP)
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

    function ZDA(sys::String)
        system = sys
        time = 0.0
        day = 0
        month = 0
        year = 0
        zone_hrs = 0
        zone_mins = 0
        new(system, time, day,
            month, year, zone_hrs,
            zone_mins)
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
        new(system, time, lat_error,
            long_error, alt_error, failed_PRN,
            prob_of_missed, excluded_meas_err, standard_deviation)
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

    function GLL(sys::String)
        system = sys
        latitude = 0.0
        longitude = 0.0
        time = 0.0
        status = false
        mode = 'N'
        new(system, latitude, longitude,
            time, status, mode)
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

    function GSV(sys::String)
        system = sys
        msg_total = 0
        msg_num = 0
        sat_total = 0
        SV_data = []
        new(system, msg_total, msg_num,
            sat_total, SV_data)
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
    status::Bool
    latitude::Float64
    longitude::Float64
    sog::Float64
    cog::Float64
    date::String
    magvar::Float64
    mode::Char

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
        new(system, time, status,
            latitude, longitude, sog,
            cog, date, magvar,
            mode)
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

    function VTG(sys::String)
        CoG_true = 0.0
        CoG_mag = 0.0
        SoG_knots = 0.0
        SoG_kmhr = 0.0
        mode = 'N'
        new(CoG_true, CoG_mag, SoG_knots,
            SoG_kmhr, mode)
    end # constructor VTG

end # type VTG

############################################################
# NMEASettings
# ------------
# IO handler settings
############################################################

type NMEASettings
    last_GGA::GGA
    last_RMC::RMC
    last_GSA::GSA
    last_GSV::GSV
    last_GBS::GBS
    last_VTG::VTG
    last_GLL::GLL
    last_ZDA::ZDA

    function NMEASettings()
        last_GGA = GGA("UNKNOWN")
        last_RMC = RMC("UNKNOWN")
        last_GSA = GSA("UNKNOWN")
        last_GSV = GSV("UNKNOWN")
        last_GBS = GBS("UNKNOWN")
        last_VTG = VTG("UNKNOWN")
        last_GLL = GLL("UNKNOWN")
        last_ZDA = ZDA("UNKNOWN")
        new(last_GGA, last_RMC, last_GSA,
            last_GSV, last_GBS, last_VTG,
            last_GLL, last_ZDA)
    end # constructor NMEASettings

end # type NMEASettings

############################################################
# start!
# ------
# open serial port and start reading NMEASettings messages
############################################################

function parse_line!(s::NMEASettings, line::String)
    message = split(line, '*')[1]
    items = split(message, ',')

    # get system name
    system = _get_system(items[1])

    mtype = ""
    if (ismatch(r"DTM$", items[1]))
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
    
    elseif (ismatch (r"Q$", items[1]))
        mtype = "Q"
    
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
    GGA_data.flag = tryint(items[7])
    GGA_data.num_sats = tryint(items[8])
    GGA_data.HDOP = tryfloat(items[9])
    GGA_data.altitude = tryfloat(items[10])
    GGA_data.geoidal_seperation = tryfloat(items[12])
    GGA_data.age_of_differential = tryfloat(items[14])
    GGA_data.diff_reference_id = tryint(items[15])

    return GGA_data
end # function _parse_GGA

############################################################
# _parse_GSA
# ----------
# parse GSA messages
############################################################

function _parse_GSA(items::Array{SubString{ASCIIString}}, system::String)
    GSA_data = GSA(system)
    GSA_data.mode = items[2][1]
    GSA_data.current_mode = tryint(items[3])

    for i = 4:length(items) - 3
        if (items[i] == "")
            break
        end
        push!(GSA_data.sat_ids, tryint(items[i]))
    end
    GSA_data.PDOP = tryfloat(items[end - 2])
    GSA_data.HDOP = tryfloat(items[end - 1])
    GSA_data.VDOP = tryfloat(items[end])

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
    ZDA_data.day = tryint(items[3])
    ZDA_data.month = tryint(items[4])
    ZDA_data.year = tryint(items[5])
    ZDA_data.zone_hrs = tryint(items[6])
    ZDA_data.zone_mins = tryint(items[7])
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
    GBS_data.lat_error = tryfloat(items[3])
    GBS_data.long_error = tryfloat(items[4])
    GBS_data.alt_error = tryfloat(items[5])
    GBS_data.failed_PRN = tryint(items[6])
    GBS_data.prob_of_missed = tryfloat(items[7])
    GBS_data.excluded_meas_err = tryfloat(items[8])
    GBS_data.standard_deviation = tryfloat(items[9])
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

    GLL_data
end # function _parse_GLL

############################################################
# _parse_GSV
# ----------
# parse GSV messages
############################################################

function _parse_GSV(items::Array{SubString{ASCIIString}}, system::String)
    GSV_data = GSV(system)
    GSV_data.msg_total = tryint(items[2])
    GSV_data.msg_num = tryint(items[3])
    GSV_data.sat_total = tryint(items[4])

    i = 5
    while i < length(items)
        svd = SVData()
        svd.PRN = tryint(items[i])
        svd.elevation = tryint(items[i + 1])
        svd.azimuth = tryint(items[i + 2])
        svd.SNR = tryint(items[i + 3])
        push!(GSV_data.SV_data, svd)
        i += 4
    end
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
    RMC_data.sog = tryfloat(items[8])
    RMC_data.cog = tryfloat(items[9])
    RMC_data.date = string(items[10][3:4], '/', items[10][1:2], '/', items[10][5:6])

    if (items[12] == "W" || items[12] == "S")
        println(items[11])
        RMC_data.magvar = tryfloat(items[11]) * -1
    else
        RMC_data.magvar = tryfloat(items[11])
    end

    RMC_data.mode = items[13][1]

    RMC_data
end # function parse_RMC

############################################################
# parse_VTG
# ---------
# parses VTG messages
############################################################

function parse_VTG(items::Array{SubString{ASCIIString}}, system::String)
    VTG_data = VTG(system)
    VTG_data.CoG_true = tryfloat(items[2])
    VTG_data.CoG_mag = tryfloat(items[4])
    VTG_data.SoG_knots = tryfloat(items[6])
    VTG_data.SoG_kmhr = tryfloat(items[8])
    VTG_data.mode = items[10][1]
    VTG_data
end # function parse_VTG

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
# hhmmss.s-s to time in seconds
############################################################

function _hms_to_secs(hms::SubString{ASCIIString})
    hours = int(hms[1:2])
    minutes = int(hms[3:4])
    seconds = float(hms[5:end])
    (hours * 3600) + (minutes * 60) + seconds
end # function _hms_to_secs

############################################################
# tryfloat
# --------
# return parsed float or 0
############################################################

function tryfloat(item::SubString{ASCIIString})
    try
        float(item)
    catch
        0
    end
end # function tryfloat

############################################################
# tryint
# ------
# return parsed int or 0
############################################################

function tryint(item::SubString{ASCIIString})
    try
        int(item)
    catch
        0
    end
end # function tryint

end # module NMEA
