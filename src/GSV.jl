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
# parse_GSV
# ---------
# parse GSV messages
############################################################

function parse_GSV(items::Array{SubString{ASCIIString}}, system::String)
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
end # function parse_GSV
