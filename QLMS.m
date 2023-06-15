
clear all
close all
hold off
%channel system order
sysorder = 5 ;
% Number of system points
%N=2000;
%inp = randn(N,1);
fs = 1.0e4;
t = 0:1/fs:0.5-1/fs;
x = cos(2*pi*100*t);
xi = cos(2*pi*150*t);
xj = sin(2*pi*20*t);
xk = 0.5*(sin(2*pi*20*t) + cos(2*pi*200*t));
randn('seed',0);
%x=randn(1,5000);
% 
x=filter([1 0.8 0.3 0.2],1,x);
xi=filter([1 0.8 0.3 0.2],1,xi);
xj=filter([1 0.8 0.3 0.2],1,xj);
xk=filter([1 0.8 0.3 0.2],1,xk);

x = quaternion(x,xi,xj,xk);
x=x.';


d = x;

N=length(x);

%qzero = quaternion(0,0,0,0);

%begin of algorithm
w = quaternion(zeros(1,sysorder),zeros(1,sysorder),zeros(1,sysorder),zeros(1,sysorder)) ; % weights array full of sysorder number of zeroes
w=w.';
disp(w);


y = quaternion(zeros(1,N),zeros(1,N),zeros(1,N),zeros(1,N)) ; % weights array full of sysorder number of zeroes
y=y.';
e = quaternion(zeros(1,N),zeros(1,N),zeros(1,N),zeros(1,N));
e=e.';
ec = 0;

for n = sysorder : N-1 
	u = x(n:-1:n-sysorder+1); 
    %unorm2 = dot(u,u);
    y(n) = w.'*u;
    %disp(y(n))
    e(n) = d(n+1) - y(n);
    %en = e(n);
    %ec = conj(e);
    mu=1e-2;
    %mu=1;

	w = w + 3/4*mu * e(n) * conj(u); %iQLMS update
%     w = w + 1/2*mu( e(n)*conj(u) - 1/2*u*conj(e(n)) ); %HR-QLMS update
    %w = w + 1/2*mu(e(n)*conj(u) - 1/2*conj(u)*conj(e(n))); %QLMS update
end


% plot(abs(e),'r')
hold on;
plot(abs(part(e,1)), 'g');
plot(abs(part(e,2)), 'b');
plot(abs(part(e,3)), 'r');
plot(abs(part(e,4)), 'yellow');
% set(gca,'yscale','log')

