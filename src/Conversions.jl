############################################################
# dms_to_dd
# ----------
# convert degrees minutes seconds to decimal degrees
############################################################

function dms_to_dd(dms::SubString{ASCIIString}, hemi::SubString{ASCIIString})
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
end # function dms_to_dd

############################################################
# hms_to_secs
# ------------
# hhmmss.s-s to time in seconds
############################################################

function hms_to_secs(hms::SubString{ASCIIString})
    hours = int(hms[1:2])
    minutes = int(hms[3:4])
    seconds = float(hms[5:end])
    (hours * 3600) + (minutes * 60) + seconds
end # function hms_to_secs
