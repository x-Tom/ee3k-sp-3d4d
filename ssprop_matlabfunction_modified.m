function output = ssprop_matlabfunction_modified(input)

nt = input(1);
u0 = input(2:nt+1);
dt = input(nt+2);
dz = input(nt+3);
nz = input(nt+4);
alpha_indB = input(nt+5);
betap = input(nt+6:nt+9);
gamma = input(nt+10);
maxiter = input(nt+12);
tol = input(nt+13);
tic;
% This function solves the nonlinear Schrodinger equation for
% pulse propagation in an optical fiber using the split-step
% Fourier method described in:   
% The following effects are inclu/ded in the model: group velocity
% dispersion (GVD), higher order dispersion, loss, and self-phase
% modulation (gamma).
% USAGE
% u1 = ssprop(u0,dt,dz,nz,alpha,betap,gamma);
% u1 = ssprop(u0,dt,dz,nz,alpha,betap,gamma,maxiter);
% u1 = ssprop(u0,dt,dz,nz,alpha,betap,gamma,maxiter,tol);
% INPUT
% u0 - starting field amplitude (vector)
% dt - time step - [in ps]
% dz - propagation stepsize - [in km]
% nz - number of steps to take, ie, ztotal = dz*nz
% alpha - power loss coefficient [in dB/km], need to convert to linear to have P=P0*exp(-alpha*z)
% betap - dispersion polynomial coefs, [beta_0 ... beta_m] [in ps^(m-1)/km]
% gamma - nonlinearity coefficient [in (km^-1.W^-1)]
% maxiter - max number of iterations (default = 4)
% tol - convergence tolerance (default = 1e-5)
% OUTPUT
% u1 - field at the output
% NOTES  The dimensions of the input and output quantities can
% be anything, as long as they are self consistent.  E.g., if
% |u|^2 has dimensions of Watts and dz has dimensions of
% meters, then gamma should be specified in W^-1*m^-1.
% Similarly, if dt is given in picoseconds, and dz is given in
% meters, then beta(n) should have dimensions of ps^(n-1)/m.
% Convert alpha_indB to alpha in linear domain
alpha = log(10)*alpha_indB/10;          % alpha (1/km)
ntt = length(u0);
w = 2*pi*[(0:ntt/2-1),(-ntt/2:-1)]'/(dt*ntt);
halfstep = -alpha/2;
for ii = 0:length(betap)-1;
  halfstep = halfstep - j*betap(ii+1)*(w.^ii)/factorial(ii);
end
LinearOperator = halfstep;   % Linear Operator in Split Step method
halfstep = exp(halfstep*dz/2);
u0 = u0.*rectwin(nt);      % rectangular window 
u1 = u0;
ufft = fft(u0);
iz = 0;

% Nonlinear operator will be added if the peak power is greater than the
% Nonlinear threshold  
while (iz < nz) & (max((abs(u1).^2 + abs(u0).^2)) > 25)
fprintf('Implementing SSFM \n');
iz = iz+1;
uhalf = ifft(halfstep.*ufft);
for ii = 1:maxiter,
uv = uhalf .* exp(-j*gamma*(abs(u1).^2 + abs(u0).^2)*dz/2);
uv = uv.*rectwin(nt);       % rectangular window 
ufft = halfstep.*fft(uv);
uv = ifft(ufft);
if (norm(uv-u1,inf)/norm(u1,inf) < tol)
u1 = uv;
break;
else
u1 = uv;
end
end
if (ii == maxiter)
warning('Failed to converge to %f in %d iterations',...
tol,maxiter);
end
u0 = u1; 
end
fprintf('Implementing Linear Transfer Function of the Fibre Propagation \n');
ufft = ufft.*exp(LinearOperator*(nz-iz)*dz);
u1 = ifft(ufft);
toc;
output = u1;   
