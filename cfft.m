function [X,f] = cfft(x,fs,NFFT)
%
% [X,f] = cfft(x,fs,NFFT)
%
% This function computes the NFFT discrete Fourier transform for input time vector x
%
% Inputs:
%      x - time series
%     fs - sampling frequency unit
%   NFFT - number of points for Fourier transform (e.g. 1024)
%
% Outputs:
%     X - Fourier transform
%     f - frequency vector (x-axis in Fourier plot)
%
%    
% CH Faham

% Number of points in input time vector
N = length(x);

% If NFFT was specified
if nargin == 3

    % Initialize the Fourier transform output
    Xtemp = 2*abs(fft(x,NFFT)/N);

    % Shift the Fourier transform so that it's symmetric about 0
    Xlong = fftshift(Xtemp);

    % Generate corresponding frequency vector
    f_tmp = fs/2*linspace(-1,1,NFFT);

% If NFFT was not specified
elseif nargin == 2
    
    % Apply inverse Fourier transform and shift so that it's symmetric about 0
    Xlong = abs(fftshift(fft(x)))/N;

    % Generate frequency vector
    if mod(N,2) == 0
        k = -N/2:N/2-1; % N even
    else
        k = -(N-1)/2:(N-2)/2; % N odd
    end

    T = N/fs;
    f_tmp = k/T;


else
    
    error('Not enough inputs!')

end

% Only output one frequency cycle
cut = inrange(f_tmp,0,fs);
X = Xlong(cut);
f = f_tmp(cut);
