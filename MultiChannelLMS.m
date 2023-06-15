% Multi Channel LMS algorithm

% MIMO SYSTEM P INPUTS Q OUTPUTS

P = 4;
Q = 4;

sysorder = 5; % number of filter taps for adaptive LMS filter

% Wpq or Ĥpq is P by Q WEIGHT MATRIX of sysorder length vectors
% for adaptive LMS filter
% Sysorder number of prev inputs
% weight for each input to output connection
% 3rd order tensor
% W = zeros(P,Q,sysorder);

fs = 1.0e4;
t = 0:1/fs:0.5-1/fs;
x1 = cos(2*pi*100*t);
x2 = cos(2*pi*150*t);
x3 = sin(2*pi*20*t);
x4 = 0.5*(sin(2*pi*20*t) + cos(2*pi*200*t));
randn('seed',0);
%x=randn(1,5000);
%
%x(q,n)

% [rows, columns] = size(x)
x1=filter([1 0.8 0.3 0.2],1,x1);
x2=filter([1 0.8 0.3 0.2],1,x2);
x3=filter([1 0.8 0.3 0.2],1,x3);
x4=filter([1 0.8 0.3 0.2],1,x4);
%       u = transpose(x(q,n:-1:n-sysorder+1));
%W(p,q,:) = W(p,q,:) + mu * e(q,n) * u;

W = zeros(P,Q,sysorder);
x = transpose([transpose(x1) transpose(x2) transpose(x3) transpose(x4)]);
N=length(x(1,:));
d = x;
y = zeros(Q,N);
e = zeros(Q,N);

for q = 1:Q
    for n = sysorder : N-1
        mu=1e-2;
        hx = 0;
        for p = 1:P 
            u = transpose(x(p,n:-1:n-sysorder+1));
            Wpq = squeeze(W(p,q,:));
            hx = hx + Wpq.' * u;
        end
        y(q,n) = hx;
        e(q,n) = d(q,n+1) - y(q,n);
        for p = 1:P 
            u = transpose(x(p,n:-1:n-sysorder+1));
            Wpq = squeeze(W(p,q,:));
            W(p,q,:) = Wpq + mu * e(q,n) * u;
        end
    end
end


% for q = 1:Q
    %eq = e(q,:);
%     eq(q) = e(q,:);
    %plot(abs(eq), 'red');
    %semilogy(abs(eq),'red')
%     semilogy(movmean(abs(eq),1000), 'red');
% end
hold on;
plot(abs(e(1,:)),'r');
plot(abs(e(2,:)),'g');
plot(abs(e(3,:)),'b');
plot(abs(e(4,:)),'yellow');
set(gca,'yscale','log')




% Transpose 2d matrix page of W
% pagetranspose(W);


% for n = sysorder : N-1 
%     u = x(:,n:-1:n-sysorder+1); 
%     
% %     WT = pagetranspose(W);
% %     g = pagemtimes(WT,u);
%     y(:,n) = g;
%     e(:,n) = d(:,n+1) - y(:,n);
% end


