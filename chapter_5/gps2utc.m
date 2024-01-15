function [UTC_time, leap_sec, day_of_year] = gps2utc(GPS_time, offset)

% [UTC_time, leap_sec] = gps2utc(GPS_time, offset); 
%
% Converts a GPS time into an equivalent UTC time (matrices). 
%
% Input:  
%   GPS_time - GPS time (nx2) [GPS_week GPS_sec]
%                    or (nx3) [GPS_week GPS_sec rollover_flag]
%               valid GPS_week values are 1-1024
%               valid GPS_sec values are 0-604799
%               GPS week values are kept in linear time accounting for
%               1024 rollovers. Include a rollover_flag of 0 for any times
%               prior to August 22, 1999. Default rollover_flag=1
%               indicating time since August 22, 1999.
%   offset   - leap seconds for the GPS times (optional) (1x1 or nx1)
%               valid offset values are 0-500
% Output: 
%   UTC_time - matrix of the form [year month day hour minute second]
%               with 4-digit year (1980), nx6 matrix
%   leap_sec - leap seconds applied to UTC relative to GPS (optional)

% Initialize the output variables
UTC_time=[]; leap_sec=[];

offset = offset * ones(size(GPS_time,1),1);
 
% Check inputs for rollover flag. Assume rollover flag=1 if not provided
% rollover flag=1 for times later than August 22, 1999.
dim_time = size(GPS_time);
if dim_time(2)==3,
    rollover_flag = GPS_time(:,3);
else
    rollover_flag = ones(dim_time(1),1);
end

% Break out GPS week and seconds into separate variable
GPS_week = GPS_time(:,1) + rollover_flag*1024;
GPS_sec = GPS_time(:,2);

% allocate the momory for the UTC_time working matrix
UTC_time = ones(size(GPS_week,1),6) * inf;

% compute gpsday and gps seconds since start of GPS time 
gpsday = GPS_week * 7 + GPS_sec ./ 86400;
gpssec = GPS_week * 7 * 86400 + GPS_sec;

% get the integer number of days
total_days = floor(gpsday);
temp = floor((rem((total_days+5),1461)-1) ./ 365);
I_temp=find(temp < 0);
if any(I_temp), 
  temp(I_temp) = zeros(size(temp(I_temp))); 
end % if

% compute the year
UTC_time(:,1) = 1980 + 4 * floor((total_days + 5) ./ 1461) + temp;

% data matrix with the number of days per month for searching 
% for the month and day
% days in full months for leap year
leapdays =   [0 31 60 91 121 152 182 213 244 274 305 335 366];  
% days in full months for standard year
noleapdays = [0 31 59 90 120 151 181 212 243 273 304 334 365];                                                      

% Leap year flag
% determine which input years are leap years
leap_year = ~rem((UTC_time(:,1)-1980),4);     
I_leap = find(leap_year == 1);                % find leap years
I_no_leap = find(leap_year == 0);             % find standard years

% establish the number of days into the current year
% leap year
if any(I_leap)
  day_of_year(I_leap) = rem((total_days(I_leap) + 5),1461) + 1;                        
end % if any(I_leap)

% standard year
if any(I_no_leap)
  day_of_year(I_no_leap) = ...
      rem(rem((total_days(I_no_leap) + 5),1461) - 366, 365) + 1;  
end % if any(I_no_leap)

% generate the month, loop over the months 1-12 and separate out leap years
for iii = 1:12
  if any(I_leap)
    I_day = find(day_of_year(I_leap) > leapdays(iii));
    UTC_time(I_leap(I_day),2) = ones(size(I_day')) * iii;
    clear I_day
  end % if any(I_leap) 
  
  if any(I_no_leap)
    I_day = find(day_of_year(I_no_leap) > noleapdays(iii));
    UTC_time(I_no_leap(I_day),2) = ones(size(I_day')) * iii;
    clear I_day
  end % if any(I_no_leap)
end % for

% use the month and the matrix with days per month to compute the day 
if any(I_leap)
  UTC_time(I_leap,3) = day_of_year(I_leap)' - leapdays(UTC_time(I_leap,2))';
end % if any(I_leap)

if any(I_no_leap)
  UTC_time(I_no_leap,3) = day_of_year(I_no_leap)' - ...
                          noleapdays(UTC_time(I_no_leap,2))';
end % if any(I_no_leap)

% compute the hours
fracday = rem(GPS_sec, 86400);              % in seconds!

UTC_time(:,4) = fix(fracday ./ 86400 .* 24);

% compute the minutes 
UTC_time(:,5) = fix((fracday - UTC_time(:,4) .* 3600) ./ 60 );

% compute the seconds
UTC_time(:,6) = fracday - UTC_time(:,4) .* 3600 - UTC_time(:,5) .* 60;

% Compensate for leap seconds
leap_sec = offset;


UTC_time(:,6) = UTC_time(:,6) - leap_sec;

% Check to see if leap_sec offset causes a negative number of seconds
I_shift = find(UTC_time(:,6) < 0);
UTC_time(I_shift,5) = UTC_time(I_shift,5) - 1;
UTC_time(I_shift,6) = UTC_time(I_shift,6) + 60;

% Check to see if the leap second offset causes a negative number of minutes
I_shift = find(UTC_time(:,5) < 0);
UTC_time(I_shift,4) = UTC_time(I_shift,4) - 1;
UTC_time(I_shift,5) = UTC_time(I_shift,5) + 60;

% Check to see if the leap second offset causes a negative number of hours
I_shift = find(UTC_time(:,4) < 0);
UTC_time(I_shift,3) = UTC_time(I_shift,3) - 1;
UTC_time(I_shift,4) = UTC_time(I_shift,4) + 24;

% Check to see if this causes a 0 day value
I_shift = find(UTC_time(:,3) <= 0);
UTC_time(I_shift,2) = UTC_time(I_shift,2) - 1;
I_yr_shift = find(UTC_time(:,2) <= 0);
UTC_time(I_yr_shift,1) = UTC_time(I_yr_shift,1) - 1;
UTC_time(I_yr_shift,2) = UTC_time(I_yr_shift,2) + 12;

% Leap year flag
 % determine which input years are leap years
leap_year = ~rem((UTC_time(I_shift,1)-1980),4);    
I_leap = find(leap_year == 1);                % find leap years
I_no_leap = find(leap_year == 0);             % find standard years

if any(I_leap),
  UTC_time(I_shift(I_leap),3) = leapdays(UTC_time(I_shift(I_leap),2) + 1)' ...
                               -leapdays(UTC_time(I_shift(I_leap),2))';
end;
if any(I_no_leap),
  UTC_time(I_shift(I_no_leap),3) = ...
         noleapdays(UTC_time(I_shift(I_no_leap),2) + 1)' ...
         -noleapdays(UTC_time(I_shift(I_no_leap),2))';
end;

day_of_year = day_of_year';
end