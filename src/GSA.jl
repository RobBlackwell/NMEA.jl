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
# parse_GSA
# ---------
# parse GSA messages
############################################################

function parse_GSA(items::Array{SubString{ASCIIString}}, system::String)
    gsa_data = GSA(system)
    gsa_data.mode = items[2][1]
    gsa_data.current_mode = tryint(items[3])

    for i = 4:length(items) - 3
        if (items[i] == "")
            break
        end
        push!(gsa_data.sat_ids, tryint(items[i]))
    end
    gsa_data.PDOP = tryfloat(items[end - 2])
    gsa_data.HDOP = tryfloat(items[end - 1])
    gsa_data.VDOP = tryfloat(items[end])

    gsa_data
end # function parse_GSA
