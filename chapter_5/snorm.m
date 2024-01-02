function en = snorm(data)
en = nan(1,length(data));
for i = 1:length(data)
    en(i) = norm(data(i,:));
end