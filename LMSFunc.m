
% x is input signal
% y is predicted output signal
% k is number of samples forward predicted
% mu is step size
% sysorder is filter tap length
% w is filter weights
% e is error signal
% d is desired output (shifted forward input signal)
% mse is mean squared error


function [y,w,e,d,mse] = LMSFunc(x,k,mu,sysorder)
    
    N = length(x);
    w = zeros(sysorder,1); % weights array full of sysorder number of zeroes
    y = zeros(N-k,1);
    e = zeros(N-k,1);
    d = zeros(N-k,1);

    d(1:sysorder) = x(1+k:sysorder+k);

    for n = sysorder : N-k % n = increasing element of array [sysorder,...,N-k]
        u = x(n:-1:n-sysorder+1) ; % Sysorder length Sub-array created starting from n going backwards by 1, sysorder number of times
        y(n)= dot(w, u) ; % dot product of weights and sysorder length of sample inputs
        d(n) = x(n+k);
        e(n) = d(n) - y(n); % desired output - lms
        
	    w = w + mu * e(n) * u; % weights updated by adding mu * sub array * error
    end

    mse = mean(e.^2);
end




