%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lmsalgo : LMS algorithm demo
% Author : Tamer abdelazim Mellik
% Contact information : 
%Department of Electrical & Computer Engineering,
%University of Calgary,
%2500 University Drive N.W. ,
%Calgary, AB T2N 1N4 ,
%Canada .
% email :abdelasi@enel.ucalgary.ca  
% email : tabdelaz@ucalgary.ca
% Webpage : http://www.enel.ucalgary.ca/~abdelasi/
% Date    : 20-4-2003
% Version : 1.0.0
% Reference : S. Haykin, Adaptive Filter Theory. 3rd edition, Upper Saddle River, NJ: Prentice-Hall, 1996. 
% Note : The author doesn't take any responsibility for any harm caused by the use of this file
clear all
close all
hold off
%channel system order
sysorder = 5 ;
% Number of system points
N=2000;
inp = randn(N,1);
n = randn(N,1);
[b,a] = butter(2,0.25); %Low pass butterworth filter, cutoff 0.25, b and a numerator and denominator
Gz = tf(b,a,-1); % Transfer function model, ts=-1 for discrete time with unknown sample rate
%This function is submitted to make inverse Z-transform (Matlab central file exchange)
%The first sysorder weight value
%h=ldiv(b,a,sysorder)'; 
% Inverse Z-transform is computed by long division to sysorder number of
% terms giving us a sysorder'th order filter function, of the input signal 
% and sysorder-1 previous inputs. eg az^-1 + bz^-2 +...+a_sz^-(sysorder-1)
% using ldiv gives us coefficients of each of the terms giving us our
% filter weights
% if you use ldiv this will give h :filter weights to be
h=  [0.0976;
    0.2873;
    0.3360;
    0.2210;
    0.0964;];
y = lsim(Gz,inp); % output signal, simulated response from Gz transfer function model using input signal
%add some noise
n = n * std(y)/(10*std(n));
d = y + n; %noisy output
totallength=size(d,1);
%Take 60 points for training
N=60 ;	
%begin of algorithm
w = zeros ( sysorder  , 1 ) ; % weights array full of sysorder number of zeroes


for n = sysorder : N % n = increasing element of array [5,...,N]
	u = inp(n:-1:n-sysorder+1) ; % Sub-array created starting from n going backwards by 1, sysorder number of times
    y(n)= w' * u; % dot product of weights and random sub array, estimated output
    %disp(y(n))
    e(n) = d(n) - y(n); % desired output - estimated output
% Start with big mu for speeding the convergence then slow down to reach the correct weights
    if n < 20
        mu=0.32;
    else
        mu=0.15;
    end
	w = w + mu * u * e(n) ; % weights updated by adding mu * sub array * error
end 
%check of results
for n =  N+1 : totallength
	u = inp(n:-1:n-sysorder+1) ;
    y(n) = w' * u ;
    e(n) = d(n) - y(n) ;
end 
hold on
plot(d)
plot(y,'r');
title('System output') ;
xlabel('Samples')
ylabel('True and estimated output')
figure
semilogy((abs(e))) ;
title('Error curve') ;
xlabel('Samples')
ylabel('Error value')
figure
plot(h, 'k+')
hold on
plot(w, 'r*')
legend('Actual weights','Estimated weights')
title('Comparison of the actual weights and the estimated weights') ;
axis([0 6 0.05 0.35])