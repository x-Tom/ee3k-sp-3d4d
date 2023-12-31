function Y = ifft(X)
% IFFT Discrete Quaternion Fourier transform.
% (Quaternion overloading of standard Matlab function, but only one parameter.)
% (The parameters N and dim of the standard function are not yet implemented.)
% 
% This function implements a default quaternion inverse FFT.  See the related
% function IQFFT, which implements inverse transforms with left or right
% exponentials and a user-specified axis.

% Copyright © 2005 Stephen J. Sangwine and Nicolas Le Bihan.
% See the file : Copyright.m for further details.

% Implementation note: keeping QFFT separate means that the quaternion-specific
% parameters (axis and left/right) are kept separate from the Matlab standard
% parameters (N and dim) which might be added here at a later date.

narginchk(1, 1), nargoutchk(0, 1) 

Y = iqfft(X, dft_axis(isreal(X)), 'L');

end

% $Id: ifft.m 1113 2021-02-01 18:41:09Z sangwine $
