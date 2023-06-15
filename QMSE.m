function [mse, mvec] = QMSE(q)
    e = [q.w, q.x, q.y, q.z];
    [mse,mvec] = MMSE(e);
end