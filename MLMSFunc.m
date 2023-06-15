
% x is input multichannel data, 4XN
% k is prediction forward
% mu is step size
% P is inputs P=4
% Q is outputs Q=4
% sysorder is filter tap length = 16

function [y,W,e,d,mse] = MLMSFunc(x,k,mu,P,Q,sysorder)
    %x is P rows by N columns double
    % Wpq or Ĥpq is P by Q WEIGHT MATRIX of sysorder length vectors
    % for adaptive LMS filter
    % Sysorder number of prev inputs
    % filter with sysorder weights for each input to output connection
    W = zeros(P,Q,sysorder);
    N=length(x(1,:));
    d = zeros(Q,N-k);
    y = zeros(Q,N-k);
    e = zeros(Q,N-k);

    d(:,1:sysorder) = x(:,1+k:sysorder+k); % make sure desired output is properly initialised

    for q = 1:Q % loop through outputs
        for n = sysorder : N-k % iterate over signal
%             mu=1e-2;
            hx = 0; % estimated qth output initialised at zero
            for p = 1:P % loop through inputs
                u = transpose(x(p,n:-1:n-sysorder+1)); % take pth input subarray of sysorder length
                Wpq = squeeze(W(p,q,:)); % take pqth filter and squeeze to become 1d array of filter weights
                hx = hx + Wpq.' * u; % dot weights with subarray
            end
            y(q,n) = hx; % estimated qth output
            d(q,n) = x(q,n+k); % desired signal is input shifted k forward
            e(q,n) = d(q,n) - y(q,n); % qth error signal
            for p = 1:P  % loop through inputs again
                u = transpose(x(p,n:-1:n-sysorder+1)); % take pth input subarray of sysorder length
                Wpq = squeeze(W(p,q,:)); % take pqth filter and squeeze to become 1d array of filter weights
                W(p,q,:) = Wpq + mu * e(q,n) * u; % take pqth fitler and update weights by incrementing by mu * error * subarray
            end
        end
    end

    mse = [mean(e(1,:).^2), mean(e(2,:).^2), mean(e(3,:).^2), mean(e(4,:).^2)]; % array of mean squared errors for each channel
end



