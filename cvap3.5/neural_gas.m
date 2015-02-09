function [Neurons] = neural_gas(D,n,epochs,alpha0,lambda0,dtype)

%NEURAL_GAS Quantizes the data space using the neural gas algorithm.
%
% Neurons = neural_gas(D, n, epochs, [alpha0], [lambda0])
%
%   C = neural_gas(D,50,10);
%   sM = som_map_struct(sD); 
%   sM.codebook = neural_gas(sD,size(sM.codebook,1),10);
%
%  Input and output arguments ([]'s are optional):
%   D          (matrix) the data matrix, size dlen x dim
%              (struct) a data struct
%   n          (scalar) the number of neurons
%   epochs     (scalar) the number of training epochs (the number of
%                       training steps is dlen*epochs)
%   [alpha0]   (scalar) initial step size, 0.5 by default
%   [lambda0]  (scalar) initial decay constant, n/2 by default
%
%   Neurons    (matrix) the neuron matrix, size n x dim

% References: 
%  T.M.Martinetz, S.G.Berkovich, and K.J.Schulten. "Neural-gas" network
%  for vector quantization and its application to time-series prediction. 
%  IEEE Transactions on Neural Networks, 4(4):558-569, 1993.

% Copyright (c) by Juha Vesanto

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Check arguments and initialize

if isstruct(D), D = D.data; end
[dlen,dim] = size(D);
Neurons = (rand(n,dim)-0.5)*10e-5; % small initial values
train_len = epochs*dlen;

if nargin<4 | isempty(alpha0) | isnan(alpha0), alpha0 = 0.5; end
if nargin<5 | isempty(lambda0) | isnan(lambda0), lambda0 = n/2; end

% random sample order
rand('state',sum(100*clock));
sample_inds = ceil(dlen*rand(train_len,1));

% lambda
lambda = lambda0 * (0.01/lambda0).^([0:(train_len-1)]/train_len);

% alpha
alpha = alpha0 * (0.005/alpha0).^([0:(train_len-1)]/train_len);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Action

for i=1:train_len,

  % sample vector
  x = D(sample_inds(i),:); % sample vector
  known = ~isnan(x);       % its known components
  X = x(ones(n,1),known);  % we'll need this 

  % neighborhood ranking
  if dtype == 1
     Dx = Neurons(:,known) - X;  % difference between vector and all map units
     R = (Dx.^2)*known'; 
  else
    for j =1:n
     R(j) = similarity_pearsonC(Neurons(j,known)', X(j,:)');
    end
  end
  [qerrs, inds] = sort(R); % 1-BMU, 2-BMU, etc.
  ranking(inds) = [0:(n-1)];             
  h = exp(-ranking/lambda(i));
  H = h(ones(length(known),1),:)';

  % update 
  Neurons = Neurons + alpha(i)*H.*(x(ones(n,1),known) - Neurons(:,known));

  % track
  %fprintf(1,'%d / %d \r',i,train_len);
  if 0 & mod(i,50) == 0, 
    hold off, plot3(D(:,1),D(:,2),D(:,3),'bo')
    hold on, plot3(Neurons(:,1),Neurons(:,2),Neurons(:,3),'r+')
    drawnow
  end
end

fprintf(1,'\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%