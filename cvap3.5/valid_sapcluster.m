stepfold = 1;
supervise = 1;
[idx,label,NC,Sil] = sapcluster(data,dtype,stepfold,supervise, ...
    'convits', 300,'maxits',2000);%,'plot'

if dtype == 1
   [Dist, dmax] = similarity_euclid(data);
else
   Dist = 1-(1+similarity_pearson(data'))/2;
   dmax = 1;
end
