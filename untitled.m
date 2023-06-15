for q = 1:Q
    for n = sysorder : N-1
        mu=1e-2;
%       u = transpose(x(q,n:-1:n-sysorder+1));
        hx = 0;
        for p = 1:P 
            u = transpose(x(p,n:-1:n-sysorder+1));
            Wpq = squeeze(W(p,q,:));
            hx = hx + Wpq.' * u;
        end
        y(q,n) = hx;
        e(q,n) = d(q,n+1) - y(q,n);
        for p = 1:P 
            u = transpose(x(p,n:-1:n-sysorder+1));
            %W(p,q,:) = W(p,q,:) + mu * e(q,n) * u;
            Wpq = squeeze(W(p,q,:));
            W(p,q,:) = Wpq + mu * e(q,n) * u;
        end
    end
end