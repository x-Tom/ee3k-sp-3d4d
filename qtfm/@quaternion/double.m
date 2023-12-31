function d = double(~) %#ok<STOUT>
% DOUBLE Convert quaternion to double precision (obsolete).
% (Quaternion overloading of standard Matlab function.)

% Copyright © 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

error(['Conversion to double from quaternion is not possible. ',...
       'Try cast(q, ''double'')'])

% Note: this function was replaced from version 0.9 with the convert
% function, because it is incorrect to provide a conversion function
% that returns a quaternion result. The convert function provides the
% same functionality, but will not be called implicitly by Matlab to
% implement an assignment like X(1,2) = quaternion(1,2,3,4) which gave
% erroneous results prior to version 0.9 and now raises an error.

end

% $Id: double.m 1113 2021-02-01 18:41:09Z sangwine $
