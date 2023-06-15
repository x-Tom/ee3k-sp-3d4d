function [mse,mvec] = MMSE(e)
    mvec = mean(e.^2);
    mse = mean(mvec);
end