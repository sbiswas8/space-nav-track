function extime = extcalc(PR,FilterType)
for i = 1: length(PR.FunctionTable)
    tstr(i) = cellstr(PR.FunctionTable(i).FunctionName);
end
index = find(strcmp(tstr,FilterType));
extime = PR.FunctionTable(index).TotalTime/PR.FunctionTable(index).NumCalls;