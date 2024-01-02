%% GPS data read
function [gps] = GPS_data_read(data_file)
gps = struct();
for i =1:31
   R1 = (i-1)*150;
   R2 = i*150-1-4;
   gps(i).R = csvread(data_file,R1,4,[R1, 4, R2, 6]);
end