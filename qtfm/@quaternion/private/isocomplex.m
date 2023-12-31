function z = isocomplex(q, a)
% ISOCOMPLEX    Construct a complex number from a quaternion, with the same
%               modulus and argument as those of the quaternion. The result
%               will be in the upper half of the complex plane unless the
%               second (optional) parameter is supplied - in this case, the
%               optional parameter must be a reference unit vector defining
%               the direction of the positive imaginary axis of q (actually
%               the direction of the north pole of one hemisphere of
%               3-space, so that any direction in this hemisphere is taken
%               as positive, resulting in a complex result in the upper
%               half plane).
%               The optional argument must be either the same size as q or
%               be a scalar (in which case the same value is used for all
%               elements of q).

% Copyright © 2006 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

% Mathematical note: the mathematical basis for this function is provided
% by the Peirce decomposition, implemented in the file peirce.m (q.v.) and
% due to Roger M. Oba (see reference in peirce.m). At the time this
% function was written, Oba's paper was more than 10 years in the future,
% so the mathematical basis was unknown.

narginchk(1, 2), nargoutchk(0, 1)

if nargin == 2
    if ~isa(a, 'quaternion')
        error(['Second argument to private function isocomplex ' ...
               'must be a quaternion (array).']);
    end
    if ~isreal(a)
        error(['Second argument to private function isocomplex ' ...
               'must be a real quaternion (array).']);
    end
    if ~ispure(a) || any(any(abs(a) - 1 > eps))
        error(['Second argument to private function isocomplex ' ...
               'must be a pure unit quaternion (array).']);
    end
    if ~(all(size(q) == size(a)) || all(size(a) == [1, 1]))
        error(['The two parameters to private function isocomplex ' ...
               'must be the same size, or the second one must be a scalar.']);
    end
end

s = scalar(q);
v = vector(q); m = abs(v);

% Either or both of s and m may be complex, in which case we cannot create
% an isomorphic complex number.

if ~isreal(s) || ~isreal(m)
    error('QTFM:limitation', ...
          ['Private function isocomplex is undefined ' ...
           'for complex quaternion arguments.'])
end

if nargin == 1
    
    % The second parameter was not supplied, so the result defaults to the
    % upper half of the complex plane (because m = abs(v) will be positive).
    
    if isnumeric(s) && isnumeric(m)
        z = complex(s, m);
    else
        % The complex function isn't implemented for symbolic or logical
        % arguments. In these cases we resort to the following, which is
        % probably not the best way to do it in the numeric case, but this
        % could be checked. TODO?
        
        z = s + m .* 1i;
    end
else
    
    % The second parameter was supplied, so we can provide a result in the
    % full complex plane dependent on the direction of v relative to a.
    % However for axes, v, perpendicular to a (i.e. on the equator of the
    % sphere with a as the north pole), the result is indeterminate. In
    % this case, we arbitrarily choose the result as if m = abs(v) was
    % positive.
    
    t = sign(scalar_product(v, a)); % The scalar product works for the case
                                    % where a is scalar, so we need not do
                                    % anything explicit to make an array
                                    % the same size as v.
    n = t == 0; % Find the indexes of any values where v(q) is perp to a.
                % TODO Surely this should be a comparison with eps or like?
    if any(any(n)) % If there are any such values...
        
        t(n) = 1; % Alter t at those locations to be one and not zero.

        warning('QTFM:information', ...
                ['Some elements of the first parameter to private '    ...
                 'function isocomplex have axis perpendicular to the ' ...
                 'axis of the second parameter and the results in '    ...
                 'these elements are somewhat arbitrary.']);
    end
    z = complex(s, m .* t); % TODO This won't work for symbolic or logical,
                            % see above for solution.
end

end

% Implementation note: the warning at line 92 is given because any
% quaternion with an axis perpendicular to the reference axis defined by
% the second parameter cannot be unambiguously converted to a complex
% number, since the quaternion axis could be taken to be positive or
% negative when converted to the isomorphic complex number. The choice made
% here is to use the positive sense, so that the quaternions for which a
% warning has been given will have values in the upper half of the complex
% plane. They could equally well have been given values in the lower half.
% Note that this is not dependent on the argument of the quaternion, but
% only on the relationship between the axis of the quaternion q and the
% reference vector a. Steve Sangwine 6 March 2008.

% TODO In the special case where all the quaternions are in the same plane,
% i.e. they all have the same axis, there is a simplification possible,
% which could be studied (it may be that this function is used in a more
% general way than this special case permits):
%
% z = complex(s(q), -v(q) .* mu)  where mu is the common axis.
%
% Source: discussion with Todd Ell, 25 July 2014.

% $Id: isocomplex.m 1125 2021-08-15 20:43:38Z sangwine $
