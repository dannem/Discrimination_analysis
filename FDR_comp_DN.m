function [pID,pN, pID_cnt, pN_cnt] = FDR_comp(p,q)
% FORMAT [pID,pN] = FDR(p,q)
% 
% p   - vector of p-values
% q   - False Discovery Rate level
%
% pID - p-value threshold based on independence or positive dependence
% pN  - Nonparametric p-value threshold
%______________________________________________________________________________
% $Id: FDR.m,v 1.1 2009/10/20 09:04:30 nichols Exp $

p = p(isfinite(p));  % Toss NaN's
p = sort(p(:));
%sprintf('% 1.5f', p(1:50))
 V = length(p);

I = (1:V)';

cVID = 1;
cVN = sum(1./(1:V));


%sprintf ('% 1.8f % 1.8f % 1.8f \n', [p(1:10,:) I(1:10,:)/V I(1:10,:)/V*q])
%sprintf ('% 1.8f \n', [p(1:12,:)])
% sprintf ('% 1.8f \n', I(1:10,:)/V)
% sprintf ('% 1.8f \n', I(1:12,:)/V*q)
% I(1:10,:)
% I(1:10,:)/V

% x=I/V*q/cVID;
%  [p(1:30) x(1:30)]
%  p(1:40)./x(1:40)
 %plot(p(1:50)./x(1:50))
%error


%%%find how many observations pass the thr
pID_cnt=max(find(p<=I/V*q/cVID));
pN_cnt=max(find(p<=I/V*q/cVN));

pID = p(max(find(p<=I/V*q/cVID)));
pN = p(max(find(p<=I/V*q/cVN)));


% q_vect=0:0.001:1;
% clear q_vox
% for k=1:5
%     k=k
%     p_val=p(k)
%     
%     min(find(p(k)<=I(k)/V*q_vect/cVID))
%     q_val=q_vect(min(find(p(k)<=I(k)/V*q_vect/cVID)))
% end
