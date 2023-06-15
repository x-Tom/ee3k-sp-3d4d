% Multi Signal LMS, treats simply applies normal LMS to each signal, not
% multichannel!!
clear all
close all
hold on
%channel system order
sysorder = 5 ;
% Number of system points
%N=2000;
%inp = randn(N,1);
fs = 1.0e4;
t = 0:1/fs:0.5-1/fs;
x1 = cos(2*pi*100*t);
x2 = cos(2*pi*150*t);
x3 = sin(2*pi*20*t);
x4 = 0.5*(sin(2*pi*20*t) + cos(2*pi*200*t));
randn('seed',0);
%x=randn(1,5000);
% 
x1=filter([1 0.8 0.3 0.2],1,x1);
x2=filter([1 0.8 0.3 0.2],1,x2);
x3=filter([1 0.8 0.3 0.2],1,x3);
x4=filter([1 0.8 0.3 0.2],1,x4);

%x = [x1 x2 x3 x4];
x = [transpose(x1) transpose(x2) transpose(x3) transpose(x4)];
%x=x.';


d = x;

N=length(x1);


%begin of algorithm
w = zeros(sysorder,4);
% w=w.';
disp(w);


y = zeros(4,N);
y=y.';

e = zeros(4,N);
e=e.';

ec = 0;
for q = 1:4
    for n = sysorder : N-1 
        u = x(n:-1:n-sysorder+1,q);
        %u = transpose(x(n:-1:n-sysorder+1,q)); 
        %unorm2 = dot(u,u);
        %w_q = w(q,:);

        y(n,q) = dot(w(:,q),u);
        %disp(y(n))
        e(n,q) = d(n+1,q) - y(n,q);
        %en = e(n);
        %ec = conj(e);
        mu=1e-2;
        %mu=1;
        w(:,q) = w(:,q) + mu * e(n,q) * u;
	    %w = w + 3/4*mu * e(n) * conj(u); %iQLMS update
        %w = w + 1/2*mu( e(n)*conj(u) - 1/2*u*conj(e(n)) ); %HR-QLMS update
        %w = w + 1/2*mu(e(n)*conj(u) - 1/2*conj(u)*conj(e(n))); %QLMS update
    end
end


for q=1:4
    color = '';
    switch q
        case 1
            color='red';
        case 2
            color='blue';
        case 3
            color="green";
        case 4
            color="yellow";
    end
    semilogy(abs(e(:,q)),color)
end

