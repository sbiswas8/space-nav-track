function obs_info = meaurement_selection(i, IDSN, GS, MD, CB)
if GS.E_meas(i) > 10
            Azimuth = GS.A_meas(i)*pi/180;
            Elevation = GS.E_meas(i)*pi/180;
            Range = GS.range1(i);
            Range_Rate = GS.range_rate(i);
            phi = GS.phi;
            lambda = GS.lambda;
            RR_delay = GS.TAU(i);
            range_delay = (GS.tau_up1(i) + GS.tau_down1(i))/2;
            flag = 'GS';
else
    if MD.E_meas(i) > 10
        Azimuth = MD.A_meas(i)*pi/180;
        Elevation = MD.E_meas(i)*pi/180;
        Range = MD.range1(i);
        Range_Rate = MD.range_rate(i);
        phi = MD.phi;
        lambda = MD.lambda;
        RR_delay = MD.TAU(i);
        range_delay = (MD.tau_up1(i) + MD.tau_down1(i))/2;
        flag = 'MD';
    else
        if IDSN.E_meas(i) > 10
            Azimuth = IDSN.A_meas(i)*pi/180;
            Elevation = IDSN.E_meas(i)*pi/180;
            Range = IDSN.range1(i);
            Range_Rate = IDSN.range_rate(i);
            phi = IDSN.phi;
            lambda = IDSN.lambda;
            RR_delay = IDSN.TAU(i);
            range_delay = (IDSN.tau_up1(i) + IDSN.tau_down1(i))/2;
            flag = 'IDSN';
        else
            if CB.E_meas(i) > 10
                Azimuth = CB.A_meas(i)*pi/180;
                Elevation = CB.E_meas(i)*pi/180;
                Range = CB.range1(i);
                Range_Rate = CB.range_rate(i);
                phi = CB.phi;
                lambda = CB.lambda;
                RR_delay = CB.TAU(i);
                range_delay = (CB.tau_up1(i) + CB.tau_down1(i))/2;
                flag = 'CB';
            else
                Elevation = 0;
            end
        end
    end
end
if Elevation > 0
    obs_info = struct('Azimuth', Azimuth, 'Elevation', Elevation, 'Range', Range, ...
        'Range_Rate', Range_Rate, 'phi', phi, 'lambda', lambda, 'RR_delay', RR_delay,...
        'range_delay', range_delay, 'flag', flag);
else
    obs_info = struct('Elevation', Elevation);
end