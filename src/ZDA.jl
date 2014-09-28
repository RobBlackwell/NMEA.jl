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
# parse_ZDA
# ---------
# parse ZDA message
############################################################

function parse_ZDA(items::Array{SubString{ASCIIString}}, system::String)
    ZDA_data = ZDA(system)
    ZDA_data.time = hms_to_secs(items[2])
    ZDA_data.day = tryint(items[3])
    ZDA_data.month = tryint(items[4])
    ZDA_data.year = tryint(items[5])
    ZDA_data.zone_hrs = tryint(items[6])
    ZDA_data.zone_mins = tryint(items[7])
    ZDA_data
end # function parse_ZDA
