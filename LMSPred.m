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

%System order, number of LMS filter taps
sysorder = 5 ;
k = 1; % predict k steps forward
fs = 1.0e4;
t = 0:1/fs:0.5-1/fs;
x = cos(2*pi*100*t);
x=filter([1 0.8 0.3 0.2],1,x);
d = x;
N=length(x);
w = zeros(1,sysorder) ; % weights array full of sysorder number of zeroes
for n = sysorder : N-k % n = increasing element of array [5,...,N]
    u = x(n:-1:n-sysorder+1) ; % Sub-array created starting from n going backwards by 1, sysorder number of times
    y(n)= dot(w, u) ; % dot product of weights and sub array, estimated output from LMS filter
    e(n) = d(n+k) - y(n); % desired output - lms filter outputs
    mu=2e-2;
    w = w + mu * e(n) * u; % weights updated by adding mu * sub array * error
end
semilogy(abs(e),'r');
