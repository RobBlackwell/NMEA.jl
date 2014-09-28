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
# parse_GBS
# ---------
# parse GBS messages
############################################################

function parse_GBS(items::Array{SubString{ASCIIString}}, system::String)
    GBS_data = GBS(system)
    GBS_data.time = hms_to_secs(items[2])
    GBS_data.lat_error = tryfloat(items[3])
    GBS_data.long_error = tryfloat(items[4])
    GBS_data.alt_error = tryfloat(items[5])
    GBS_data.failed_PRN = tryint(items[6])
    GBS_data.prob_of_missed = tryfloat(items[7])
    GBS_data.excluded_meas_err = tryfloat(items[8])
    GBS_data.standard_deviation = tryfloat(items[9])
    GBS_data
end # function parse_GBS
