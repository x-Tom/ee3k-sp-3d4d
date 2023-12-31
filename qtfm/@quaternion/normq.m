function a = normq(q)
% NORMQ Norm of a quaternion, the sum of the squares of the components.
% The norm is also equal to the product of a quaternion with its conjugate.

% Copyright © 2009, 2010 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

narginchk(1, 1), nargoutchk(0, 1) 

if isempty(q.w) % Code moved from the private function modsquared Dec 2010.
    a =          q.x.^2 + q.y.^2 + q.z.^2;
else
    a = q.w.^2 + q.x.^2 + q.y.^2 + q.z.^2;
end

end

% $Id: normq.m 1113 2021-02-01 18:41:09Z sangwine $
