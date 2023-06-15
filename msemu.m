function [mse_] = msemu(mu_)
    global wind1;
    global sysorder;
    [~,~,~,~,msee] = LMSFunc(wind1,1,mu_,sysorder);
    mse_ = msee;
end