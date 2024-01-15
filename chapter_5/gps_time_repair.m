function gpst = gps_time_repair(t)
%repairs over- and underflow of GPS time

 half_week = 302400;
 gpst = t;

 if t >  half_week
     gpst = t-2*half_week;
 else
    if t < -half_week
        gpst = t+2*half_week;
    end
 end
end