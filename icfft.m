function [x,t] = icfft(X,fs,NFFT)
%
% [x,t] = icfft(X,fs,NFFT)
%
% This function computes the inverse discrete Fourier transform for input Fourier vector X
%
% Inputs:
%      X - Fourier transform vector
%     fs - sampling frequency unit
%   NFFT - number of points for inverse Fourier transform
%
% Outputs:
%     x - inverse Fourier transform
%     t - time vector (x-axis in time series plot)
%    
% CH Faham

% Number of points in input time vector
N = length(X);

% Delta time corresponding to specified sample frequency
dt = 1/fs;

% If NFFT was specified
if nargin == 3

    % Initialize the inverse Fourier transform output
    xtemp = 2*abs(ifft(X,NFFT)/N);

    % Shift the inverse Fourier transform so that it's symmetric about 0
    xlong = fftshift(xtemp);

    % Generate corresponding frequency vector
    t_tmp = dt*linspace(-1,1,NFFT);

% If NFFT was not specified
elseif nargin == 2
    
    % Apply inverse Fourier transform and shift so that it's symmetric about 0
    Xlong = abs(fftshift(fft(x)))/N;

    % Generate time vector
    if mod(N,2) == 0
        k = -N/2:N/2-1; %N even
    else
        k = -(N-1)/2:(N-2)/2; %N odd
    end
    T = N/fs;

    f_tmp = k/T;

else
    
    error('Not enough inputs!')

end

% Only output once cycle
cut = inrange(t_tmp,0,max(t_tmp));
x = xlong(cut);
t = t_tmp(cut);
