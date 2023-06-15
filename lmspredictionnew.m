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
%N=2000;
%inp = randn(N,1);
fs = 1.0e4;
t = 0:1/fs:0.5-1/fs;
x = cos(2*pi*100*t);

%x=randn(1,5000);
 
x=filter([1 0.8 0.3 0.2],1,x);

d = x;
%x = delayseq(x,1);

totallength=size(d,1);
disp(totallength);
%Take 60 points for training
%N=60 ;	

N=length(x);


%begin of algorithm
%w = zeros(1,sysorder) ; % weights array full of sysorder number of zeroes

kmax = 16;
esum = zeros(kmax);

for k = 0 : kmax
    w = zeros(1,sysorder) ; % weights array full of sysorder number of zeroes
    %e = zeros(N);
    for n = sysorder : N-k % n = increasing element of array [5,...,N]
	    u = x(n:-1:n-sysorder+1) ; % Sub-array created starting from n going backwards by 1, sysorder number of times
        unorm2 = dot(u,u);
        y(n)= dot(w, u) ; % dot product of weights and random sub array, estimated output
        %disp(y(n))
        e(n) = d(n+k) - y(n); % desired output - lms
    % Start with big mu for speeding the convergence then slow down to reach the correct weights
        
        %mu=2e-2;
        mu=2e-2;
        
	    w = w + mu * e(n) * u; % weights updated by adding mu * sub array * error
    end
    switch k
        case 0
            figure("Name","K="+k), semilogy(abs(e),'r');
            continue
        case {1,2}
            figure("Name","K="+k), semilogy(abs(e),'blue')
    end
    esum(k) = sum(abs(e));
%    esum(k) = abs(sum(e));
end


%semilogy(abs(e),'r')
fg1 = figure("Name","Sum of abs error with further forward prediction in k"); 
plot(esum)
xlabel("1 <= k <= kmax. Further forward prediction d(n+k)");
ylabel("Sum of abs error at each k");

% %check of results
% for n =  N+1 : totallength
% 	u = x(n:-1:n-sysorder+1) ;
%     y(n) = dot(w,u) ;
%     e(n) = d(n) - y(n) ;
% end 
% hold on
% %plot(d)
% plot(y,'r');
% title('System output') ;
% xlabel('Samples')
% ylabel('True and estimated output')
% figure
% semilogy((abs(e))) ;
% title('Error curve') ;
% xlabel('Samples')
% ylabel('Error value')
% figure
% %plot(h, 'k+')
% hold on
% plot(w, 'r*')
% legend('Actual weights','Estimated weights')
% title('Comparison of the actual weights and the estimated weights') ;
% axis([0 6 0.05 0.35])