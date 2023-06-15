% LMS Algorithm on S&P 500 Index for predicting future close prices on each
% day

%S&P 500 Index (SPX) Data from 7th January 2002 to 7th January

% hold on;

% dbstop if naninf

clearvars;

P=4;
Q=4;



sysorder = 16;
mu=5e-20;

STOCK = csvread("TSLA.csv",1,1);

TSLA=zeros(758,4);

TSLA(:,1)=STOCK(:,1);
TSLA(:,2)=STOCK(:,4);
TSLA(:,3)=STOCK(:,2);
TSLA(:,4)=STOCK(:,6);

%STOCK = csvread("^IXIC.csv",1,1);

% STOCK = flip(STOCK,1);

T = array2table(TSLA,'VariableNames',{'Open Price','Close Price','High Price','Trading Volume'}); 
uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);


[rows, columns] = size(STOCK)
% hold on;
% 
% title("TLSA Stock");
% plot(STOCK(:,1));
% plot(STOCK(:,4),'g');
% plot(STOCK(:,2),'magenta');
% plot(STOCK(:,6)/10e5,'red');
% xlabel("Days since 13th March 2019");
% ylabel("TSLA Stock Daily Open, Close, and High Price (USD) and Daily Trading Volume per 100k units");
% legend("Open", "Close", "High","Trading Volume per 100k units");

% title("TLSA Stock");
% plot(STOCK(:,1));
% plot(STOCK(:,4));
% plot(STOCK(:,2));
% xlabel("Days since 13th March 2019");
% ylabel("TSLA Price USD");
% legend("Open", "Close", "High")
% plot(STOCK(:,6));
%MSTOCK=STOCK% Delete rows / columns in STOCK to make a 4d signal with OCHV

% STOCK = transpose(STOCK);
[rows, columns] = size(STOCK)



%plot(STOCK);

% % --- SINGLE LMS
x = STOCK(:,4);
% % % % mu__ = 2.1759e-07;
% % % mu__ = 2.4296e-07;
k=1;
% % x=STOCK(:,6);
% mu=8.7394e-08;
% mu=3.8101e-08;
% 
% mu=3.25e-8;
% 

[y,w,e,d,mse] = LMSFunc(x,k,mu,sysorder);

% mse
% hold on;

% 
% title("TLSA Stock Trading Volume");
% % plot(x);
% 
% xlabel("Days since 13th March 2019");
% ylabel("TSLA High Price USD");
% 
% title(sprintf('TSLA Stock Close Price LMS Prediction k=%d mu=%e taplength=%d MSE=%e', k, mu, sysorder, mse))
% 
% xlabel("Days since 13th March 2019");
% ylabel("TSLA Close Price USD");
% 
% plot(d, 'r');
% plot(y, 'b');
% legend("Desired signal", "Predicted signal")

% 
% figure,
% title(sprintf('TSLA Stock Close Price Squared Error LMS Prediction k=%d mu=%e taplength=%d MSE=%e', k, mu, sysorder, mse))
% plot(e.^2);
% xlabel("Days since 13th March 2019");
% ylabel("Prediction error squared");
% plot(movmean(e.^2,100));
% legend("Error", "100 point moving average Error")

% Signal shift: D(k+1:end) = X(1:end-k);



%NAN IS CAUSED BY TOO LARGE STEP SIZE

% semilogy(abs(e),'blue'); 

% disp(w);

% x = STOCK(:,6);

% ------ MSE/step size

% i = 0;
% mumax=1/(1.2*sysorder*bandpower(x));
% for t = linspace(0,mumax,10000)
%     i = i + 1;
%     [~,~,~,~,mse] = LMSFunc(x,1,t,sysorder);
%     if isnan(mse) 
%         MSE(i)=0;
%     else
%         MSE(i) = mean(mse);
%     end
% %     MSE(i) = QLMS(t);
% end

% MSE(isnan(MSE))=[];

% [m,idx]=min(MSE(MSE>0))
% 
% semilogy(MSE);
% title('LMS TSLA Open Price Stock Data MSE against stepsize');
% xlabel(sprintf('Stepsize μ (x %e)',mumax/10000));
% ylabel('MSE');

% ------ MSE/Tap Length

% for taps = 1:200
%     [~,~,~,~,mse] = LMSFunc(x,1,mu,taps);
%     if isnan(mse) 
%         MSET(taps)=0;
%     else
%         MSET(taps) = mean(mse);
%     end
% end
% 
% plot(MSET)
% title('LMS TSLA Open Price Stock Data MSE against tap length');
% xlabel('Number of filter taps');
% ylabel('MSE');
% 
% [best,index] = min(MSET);

% ----- MSE/Prediction ahead

% for k = 1:100
%     [~,~,~,~,mse] = LMSFunc(x,k,mu,sysorder);
%     if isnan(mse) 
%         MSEP(k)=0
%     else
%         MSEP(k) = mean(mse);
%     end
% end
% 
% plot(MSEP)
% title('LMS TSLA Open Price Stock Data Prediction Horizon');
% xlabel('k samples in the future x(n+k)');
% ylabel('MSE');
% 
% [best,index] = min(MSEP);

% --- MULTI LMS

TSLA(:,4)=TSLA(:,4)/mean(TSLA(:,4));
% 
k=1;
% % 
% % mu=6.1e-18;
% % % mu=2.5e-18;
% mu=2.9248e-08;
mu=3.25e-8;
% mu=3.8101e-8;
% 
% 

% [y,W,e,d,mse] = MLMSFunc(TSLA.',k,mu,P,Q,sysorder);


% 
% mse(2);
% 
% hold on;
% 
% title(sprintf('TSLA Stock Close Price MLMS Prediction k=%d mu=%e taplength=%d MSE=%e', k, mu, sysorder, mse(2)))
% 
% 
% xlabel("Days since 13th March 2019");
% ylabel("TSLA Close Price USD");
% 
% plot(d(2,:),'r');
% plot(y(2,:),'b');
% 
% legend("Desired signal", "Predicted signal")

% hold on;
% 
% title(sprintf('TSLA Stock Close Price Squared Error MLMS Prediction k=%d mu=%e taplength=%d MSE=%e', k, mu, sysorder, mse(2)))
% plot(e(2,:).^2);
% xlabel("Days since 13th March 2019");
% ylabel("Prediction error squared");

% figure,
% hold on;
% plot(abs(e(1,:)),'r');
% plot(abs(e(2,:)),'g');
% plot(abs(e(3,:)),'b');
% plot(abs(e(4,:)),'yellow');
% set(gca,'yscale','log');

% mumax = 0.75e-8; %1e-9

% ------ MSE/step size

i = 0;

mumax = 2/(sysorder*sum(bandpower(TSLA))); 
for t = linspace(0,mumax,100)
    i = i + 1;
    [~,~,~,~,mse] = MLMSFunc(TSLA.',1,t,P,Q,sysorder);
    if isnan(mse) 
        MSE(i)=0;
    else
        MSE(i) = mean(mse);
%     mse
    end
%     MSE(i) = QLMS(t);
end

% MSE(isnan(MSE))=[];

[m,idx]=min(MSE(MSE>0))

semilogy(MSE);
title('MLMS Stock Data MSE against stepsize');
xlabel(sprintf('Stepsize μ (x %e)',mumax/100));
% ylabel('MSE');


% ------ MSE/Tap Length

for taps = 1:200
    [~,~,~,~,mse] = MLMSFunc(TSLA.',1,mu,P,Q,taps);
    if isnan(mse) 
        MSET(taps)=0
    else
        MSET(taps) = mean(mse);
    end
end

plot(MSET)
title('MLMS Stock Data MSE against tap length');
xlabel('Number of filter taps');
ylabel('MSE');

[best,index] = min(MSET)

% ----- MSE/Prediction ahead

for k = 1:100
    [~,~,~,~,mse] = MLMSFunc(TSLA.',k,mu,P,Q,sysorder);
    if isnan(mse) 
        MSEP(k)=0
    else
        MSEP(k) = mean(mse);
    end
end

plot(MSEP)
title('MLMS Stock Data Prediction Horizon');
xlabel('k samples in the future x(n+k)');
ylabel('MSE');

[best,index] = min(MSEP);

% --- QUATERNION LMS
% 


% % 
mu=3.25e-8;
% % mu=3.8101e-08;
% % 
k=1;
% 

% QSTOCK = quaternion(TSLA(:,1),TSLA(:,2),TSLA(:,3),TSLA(:,4));
% [y,w,e,d,mse] = QLMSFunc(QSTOCK,k,mu,sysorder);
% % 
hold on;

title(sprintf('TSLA Stock Close Price Squared Error QLMS Prediction k=%d mu=%e taplength=%d MSE=%e', k, mu, sysorder, mse(2)))
plot((e.x).^2);
xlabel("Days since 13th March 2019");
ylabel("Prediction error squared");


% 
% title(sprintf('TSLA Stock Close Price QLMS Prediction k=%d mu=%e taplength=%d MSE=%e', k, mu, sysorder, mse(2)))
% % % plot(e.w);
% % 
% % 
% xlabel("Days since 13th March 2019");
% ylabel("TSLA Close Price USD");
% % 
% plot(y.x, 'r');
% plot(d.x,'b');
% % % 
% legend("Desired signal", "Predicted signal")
% % 
% mse(2)

% % plot(STOCK(:,1), 'r')
% % mse


% [x,y] = fminbnd(QLMS,0,0.1)

% mse = QLMS(mu)
% fplot(@QLMS,[0,0.0000001]);
% fplot(QLMS);
% 
% 
% 
% i = 0;
% % mumax = 0.75e-8; %1e-9
% % mumin= 1/(3*sysorder*sum(bandpower(TSLA)));
% mumax = 1/(1.5*sysorder*sum(bandpower(TSLA))); 
% for t = linspace(0,mumax)
%     i = i + 1;
%     [~,e,~,~,mse] = QLMSFunc(QSTOCK,1,t,sysorder);
%     if isnan(mse) 
%         MSE(i)=0;
%     else
%         MSE(i) = mse(2);
%     end
% %     MSE(i) = QLMS(t);
% end
% 
% MSE(isnan(MSE))=[];
% 
% [m,idx]=min(MSE(MSE>0))
% 
% semilogy(MSE);
% title('QLMS Stock Data MSE against stepsize');
% xlabel(sprintf('Stepsize μ (x %e)',mumax/100));
% ylabel('MSE');

% fminsearch(QLMS,1e-12)
% 
% function m = QLMS(u)
%     sysorder = 5;
%     STOCK = csvread("S&P 500 INDEX.csv",1,1);
%     STOCK = flip(STOCK,1);
%     QSP500 = quaternion(STOCK(:,1),STOCK(:,2),STOCK(:,3),STOCK(:,4));
%     [~,~,~,~,mse] = QLMSFunc(QSP500,1,u,sysorder);
%     m = mean(mse);
% end

% ------ MSE/Tap Length
% 
% for taps = 1:200
%     [~,~,~,~,mse] = QLMSFunc(QSTOCK,1,mu,taps);
%     if isnan(mse) 
%         MSET(taps)=0
%     else
%         MSET(taps) = mean(mse);
%     end
% end
% 
% plot(MSET)
% title('QLMS Stock Data MSE against tap length');
% xlabel('Number of filter taps');
% ylabel('MSE');
% 
% [best,index] = min(MSET)

% ----- MSE/Prediction ahead

% for k = 1:30
%     [~,~,~,~,mse] = QLMSFunc(QSTOCK,k,mu,sysorder);
%     if isnan(mse) 
%         MSEP(k)=0
%     else
%         MSEP(k) = mean(mse);
%     end
% end
% 
% plot(MSEP)
% title('QLMS Stock Data Prediction Horizon');
% xlabel('k samples in the future x(n+k)');
% ylabel('MSE');
% 
% [best,index] = min(MSEP);
% ------------
% [~,~,~,~,mse] = QLMSFunc(QSP500,1,mu,sysorder)
 

