function []=visibilityplot(obs_data,ecc)
%load(obs_add)
%[v_mat,p_mat, nos] = visibility_extract(GPSM);

figure
for i = 1:4
    obs_add = obs_data(i).add;
    load(obs_add)
    [v_mat,p_mat, nos] = visibility_extract(GPSM);
    e = ecc(i);
    subplot(2,2,i)
    plot(v_mat','.','LineWidth',2)
    set(gca,'YTick',1:5:31,'FontName','Times New Roman')
    xlabel('Time (s)','FontName','Times New Roman')
    ylabel('PRN','FontName','Times New Roman')
    switch e
        case 0.1
            title('Orbit eccentricity 0.1')
        case 0.4
            title('Orbit eccentricity 0.4')
        case 0.7
            title('Orbit eccentricity 0.7')
        case 0.9
            title('Orbit eccentricity 0.9')
    end
end
clear v_mat p_mat nos
figure
for i = 1:4
    obs_add = obs_data(i).add;
    load(obs_add)
    [v_mat,p_mat, nos] = visibility_extract(GPSM);
    e = ecc(i);
    subplot(2,2,i)
    plot(p_mat','LineWidth',1.5)
    set(gca,'FontName','Times New Roman')
    xlabel('Time','FontName','Times New Roman')
    ylabel('Signal Power (dB)','FontName','Times New Roman')
    switch e
        case 0.1
            title('Orbit eccentricity 0.1')
        case 0.4
            title('Orbit eccentricity 0.4')
        case 0.7
            title('Orbit eccentricity 0.7')
        case 0.9
            title('Orbit eccentricity 0.9')
    end
end
clear v_mat p_mat nos
cleanfigure('targetResolution',20)
matlab2tikz('G:\My Drive\MyPapers\Conference\ICC\ICC2019\Tikz\specc_all.tikz','floatFormat', '%0.3f')
% switch e
%     case 0.1
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\specc1.tikz','floatFormat', '%0.3f')
%     case 0.4
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\specc2.tikz','floatFormat', '%0.3f')
%     case 0.7
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\specc3.tikz','floatFormat', '%0.3f')
%     case 0.9
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\specc4.tikz','floatFormat', '%0.3f')
% end

figure
for i = 1:4
    obs_add = obs_data(i).add;
    load(obs_add)
    [v_mat,p_mat, nos] = visibility_extract(GPSM);
    e = ecc(i);
    subplot(2,2,i)
    histogram(nos,30)
    set(gca,'YScale','log','FontName','Times New Roman')
    xlabel('No. of Sat.','FontName','Times New Roman')
    ylabel('No. of occurance','FontName','Times New Roman')
    ylim([0 10^6])
    yticks([10^0 10^2 10^4 10^6])
    switch e
        case 0.1
            title('Orbit eccentricity 0.1')
        case 0.4
            title('Orbit eccentricity 0.4')
        case 0.7
            title('Orbit eccentricity 0.7')
        case 0.9
            title('Orbit eccentricity 0.9')
    end
end
clear v_mat p_mat nos
% switch e
%     case 0.1
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\histecc1.tikz','floatFormat', '%0.3f')
%     case 0.4
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\histecc2.tikz','floatFormat', '%0.3f')
%     case 0.7
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\histecc3.tikz','floatFormat', '%0.3f')
%     case 0.9
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\histecc4.tikz','floatFormat', '%0.3f')
% end
figure
for i = 1:4
    obs_add = obs_data(i).add;
    load(obs_add)
    [v_mat,p_mat, nos] = visibility_extract(GPSM);
    e = ecc(i);
    subplot(2,2,i)
    stairs(nos,'LineWidth',0.2)
    set(gca,'FontName','Times New Roman')
    xlabel('Time (s)','FontName','Times New Roman')
    ylabel('No. of Nav. sat','FontName','Times New Roman')
    switch e
        case 0.1
            title('Orbit eccentricity 0.1')
        case 0.4
            title('Orbit eccentricity 0.4')
        case 0.7
            title('Orbit eccentricity 0.7')
        case 0.9
            title('Orbit eccentricity 0.9')
    end
end
cleanfigure('targetResolution',20)
matlab2tikz('G:\My Drive\MyPapers\Conference\ICC\ICC2019\Tikz\visecc_all.tikz','floatFormat', '%0.3f')
% switch e
%     case 0.1
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\visecc1.tikz','floatFormat', '%0.3f')
%     case 0.4
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\visecc2.tikz','floatFormat', '%0.3f')
%     case 0.7
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\visecc3.tikz','floatFormat', '%0.3f')
%     case 0.9
%         matlab2tikz('C:\Users\sanat\Google Drive\MyPapers\Conference\ICC\Tikz\visecc4.tikz','floatFormat', '%0.3f')
% end
