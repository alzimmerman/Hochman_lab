function [params]=compile_Jacob
files={'','',''}

for i=1:length(files)
    name=files{i};
    [area1,area2,peak,time2peak,DRPduration]=forJacob(name);
    params(i,:)=[area1 area2 peak time2peak DRPduration];
end