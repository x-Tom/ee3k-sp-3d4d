function compare(A, B, T, E)
% Test function to check that two quaternion arrays (real or complex)
% are equal, to within a tolerance, and if not, to output an error
% message from the string in the parameter E. (This will also work for
% non-quaternion arrays.)

% Copyright © 2005, 2006, 2010 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

narginchk(4, 4), nargoutchk(0, 0)

if any(any( abs(abs(A - B)) > T ))
    max(max(abs(abs(A - B)))) % Added 13 March 2006 to show the max error.
    error(E);
end

% $Id: compare.m 1113 2021-02-01 18:41:09Z sangwine $
