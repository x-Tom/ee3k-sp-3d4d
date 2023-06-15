function [mse] = SMSE(e)
    mse = mean(e.^2);
end