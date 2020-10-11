function [Re theta] = resDO(map,sigma,angles,weights)
% function [Re theta] = resDO(map,sigma,angles,weights)
% compute the response of oriented double-oponent cells
% and the optimal orientation of each pixel
% inputs:
%         map ------ RGB color map.
%         sigma ---- Local scale (the size of cones' RF).
%         angles --- the number of orientation.
%         weights -- one of the cone weights(the other one is 1).
% outputs:
%        Re  ------- final responses of double-opponent cells across
%                    all opponent channels
%        theta ----- optimal orientation map
%
%
% Kaifu Yang <yang_kf@163.com>
% March 2013
%=========================================================================%

if nargin < 4, weights= -0.6; end
if nargin < 3,  angles = 8;  end

[w h d] = size(map);
theta = zeros(w,h);
Re = zeros(w,h);

[Drg Dgr]= OrientedDoubleOpponent(map,'RG',sigma,angles,weights);
[Dby Dyb]= OrientedDoubleOpponent(map,'BY',sigma,angles,weights);

[CBrg(:,:),Orients(:,:,1)] = max(Drg,[],3);
[CBgr(:,:),Orients(:,:,2)] = max(Dgr,[],3);
[CBby(:,:),Orients(:,:,3)] = max(Dby,[],3);
[CByb(:,:),Orients(:,:,4)] = max(Dyb,[],3);

CBrg = CBrg./max(CBrg(:));   % normlization
CBgr = CBgr./max(CBgr(:));
CBby = CBby./max(CBby(:));
CByb = CByb./max(CByb(:));

Boundary(:,:,1) = CBrg;
Boundary(:,:,2) = CBgr;
Boundary(:,:,3) = CBby;
Boundary(:,:,4) = CByb;

% max-pool
[Re(:,:),idx(:,:)]= max(Boundary,[],3);

% obtain the optimal orientation
for i = 1:w
    for j =1:h
        theta(i,j) = Orients(i,j,idx(i,j));
    end
end
%=========================================================================%
