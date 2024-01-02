function UMT_GEN(Rdata,Vdata,dt,fid)
RECEFpt = Rdata;
VECEFpt = Vdata;
for i = 1:length(RECEFpt)
%     [year,month,day,hour,minute,secs,ticks] = mjd2utc(data(i,1));
    time = i*dt;
    fprintf(fid,'%d,%f,%f,%f,%f,%f,%f,0,0,0,0,0,0\n',time,RECEFpt(i,1),RECEFpt(i,2),RECEFpt(i,3),VECEFpt(i,1),VECEFpt(i,2),VECEFpt(i,3));
end
fclose(fid);