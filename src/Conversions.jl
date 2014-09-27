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
    println(minutes)
    seconds = int(split(dms, '.')[2][1:2])
    dec_degrees = degrees + (minutes / 60) + (seconds / 3600)

    if (hemi == "S" || hemi == "W")
        dec_degrees *= -1
    end

    dec_degrees
end # function _dms_to_dd

