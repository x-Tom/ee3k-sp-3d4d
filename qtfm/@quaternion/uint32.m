function d = uint32(~)
% UINT32 Convert to unsigned 32-bit integer (obsolete).
% (Quaternion overloading of standard Matlab function.)

% Copyright © 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

error(['Conversion to uint32 from quaternion is not possible. ',...
       'Try cast(q, ''uint32'')'])

% Note: this function was replaced from version 0.9 with the convert
% function, because it is incorrect to provide a conversion function
% that returns a quaternion result.

end

% $Id: uint32.m 1113 2021-02-01 18:41:09Z sangwine $
