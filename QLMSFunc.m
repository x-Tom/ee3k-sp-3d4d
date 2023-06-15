
% x is quaternion input, each part of quaternion is a signal channel
% y is quaternion estimated output
% k is number of samples predicted forward in future 
% mu is step size
% sysorder is filter tap length
% w is quaternion weights, sysorder length on each part
% e is error quaternion
% d is desired ouptut quaternion, forward shifted input
% mse is mean of error quaternion squared

function [y,w,e,d,mse] = QLMSFunc(x,k,mu,sysorder)
    % x is expected to be a 1 row by N columns of quaternion
    N = length(x);
    w = quaternion(zeros(1,sysorder),zeros(1,sysorder),zeros(1,sysorder),zeros(1,sysorder)) ; % weights quaternion full of sysorder number of zeroes in each part of quaternion
    w=w.';
    y = quaternion(zeros(1,N-k),zeros(1,N-k),zeros(1,N-k),zeros(1,N-k)) ; %  estimated ouptut quaternion signal initialised to zero
    y=y.';
    e = quaternion(zeros(1,N-k),zeros(1,N-k),zeros(1,N-k),zeros(1,N-k)); % error quaternion initialised to zero
    e=e.';
    
%     d = quaternion(zeros(1,N-k),zeros(1,N-k),zeros(1,N-k),zeros(1,N-k));
%     d=d.';

    x1 = x.w;
    x2 = x.x;
    x3 = x.y;
    x4 = x.z;

    d_ = zeros(4,N-k);

    d_(1,1:sysorder) = x1(1+k:sysorder+k);
    d_(2,1:sysorder) = x2(1+k:sysorder+k);
    d_(3,1:sysorder) = x3(1+k:sysorder+k);
    d_(4,1:sysorder) = x4(1+k:sysorder+k);

    % ensures desired signal is properly shifted.

    d = quaternion(d_(1,:),d_(2,:),d_(3,:),d_(4,:));
    d=d.';

    %Ensure signal lengths are correct, N-k

    for n = sysorder : N-k 
        u = x(n:-1:n-sysorder+1);

%         disp(norm(u));

        y(n) = w.'*u; % Quaternion multiplication to get estimated output
        d(n) = x(n+k);
        e(n) = d(n) - y(n);
        esquared(n) = scalar(e(n)*conj(e(n)));
     
        %mu=1e-2;
        w = w + 3/4*mu * e(n) * conj(u); %iQLMS update
        %w = w + 1/2*mu( e(n)*conj(u) - 1/2*u*conj(e(n)) ); %HR-QLMS update
        %w = w + 1/2*mu(e(n)*conj(u) - 1/2*conj(u)*conj(e(n))); %QLMS update
    end
    

%       mse = [mean((e.w).^2), mean((e.x).^2), mean((e.y).^2), mean((e.z).^2)];

    mse = mean(esquared);

end


