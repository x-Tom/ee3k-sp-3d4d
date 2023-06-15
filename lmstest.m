fs = 1.0e4;
t = 0:1/fs:0.5-1/fs;
x = cos(2*pi*100*t);
randn('seed',0);
% x=randn(1,5000);
% 
x=filter([1 0.8 0.3 0.2],1,x);

x = x.';
[rows columns] = size(x)

mu = 2e-2;

sysorder = 5;

[y,w,e] = LMSFunc(x, 1, mu, sysorder);

% plot(abs(e));

[mse]=SMSE(e)