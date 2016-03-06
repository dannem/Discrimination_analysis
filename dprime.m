function [H, FA, d] = dprime(hits, signal_n, fas, noise_n, task_type)
%dL computes sensitivity and bias.
%   usage: [hits n_signal fa's n_noise]
%   output: [corrected_hits corrected_fa's dl Cl]


if nargin ~= 5
     error('Usage: dl(hits, n_signal, fas, n_noise, task_type]');
end

if hits == signal_n || hits == 0
    H = (hits + 0.5) / (signal_n + 1.0);
else H = hits / signal_n;
end

if fas==noise_n || fas==0
    FA = (fas + 0.5) / (noise_n + 1.0);
else FA = fas/ noise_n;
end


zH = icdf('Normal', H,0,1);
zFA = icdf('Normal', FA,0,1);
d=zH-zFA; %%d for yes-no experiments

if strcmp(task_type, '2AFC')
    d=d/sqrt(2);
end

%Cl = 0.5 * log( (1.0 - FA) * (1.0 - H) / (H * FA) );

%temp = sprintf('Hits: %4.3f, FAs: %4.3f, dl: %4.3f, Cl: %4.3f', H, FA, dl, Cl);
%disp(temp);



