Fs = 1000;
Ts = 1/Fs;
order = 12;
t = 0:Ts:1-Ts;
x = sin(2*pi*4*t);
x_orig = x;
noise = randn(size(x));
x = x + noise;
x = x/max(x);
x = x';
b = fir1(order,0.3,'low');
d = filter(b,1,x);
mu = 0.8;
lms = dsp.LMSFilter(order+1, 'StepSize',mu,'WeightsOutputPort',true);
[y,e,w] = step(lms,x,d);

zoom on;
hold on;
stem(b.');
%stem(w, 'r');
title('LMS Filter');

fvtool(b);
fvtool(w);


plot(e);
