function n = length(q)
% LENGTH   Length of vector.
% (Quaternion overloading of standard Matlab function.)

% Copyright © 2005 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

% This was written because length appears not to work correctly for arrays
% of structs, as can be demonstrated by:
%
% a.x = randn(5,1), length(a)
%
% which gives 1, and
%
% a = randn(5,1), length(a)
%
% which gives 5, as expected.

narginchk(1, 1), nargoutchk(0, 1)

% We use the length of the x component, not the length of the scalar part,
% since if q is pure, there is no scalar part.

n = length(q.x);

end

% $Id: length.m 1113 2021-02-01 18:41:09Z sangwine $
