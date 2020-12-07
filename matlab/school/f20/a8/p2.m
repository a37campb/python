

%set up the function. 
%Then, do fft and apply 5th order hamming window
%inverse the fft
%Plot y against the filtered y.

t = [0:1:63];
%linear array for the time series data
y = sin(30*pi*t/64) + sin(4*pi*t/64);
%set-up for the signal to be filtered.
% Digital filtering requires a convolution, so we push it to Fourier space, multiply with window, and bring out of fourier space.
y_fft = fft(y);
% Brings the signal into Fourier space
win_len = 64;
ham_win = hamming(win_len, 'symmetric');
ham_zero_center = fftshift(ham_win');
ham_zero_center_5 = (ham_zero_center).^5;
%Sets up the window for the convolution process
filt_y_f = y_fft .* ham_zero_center_5;
% applied the fifth power of the centered hamming window to the signal in fft space.
filt_y = ifft(filt_y_f);
% Bring the signal back to the time space. 
subplot(5,1,1);
plot(t,y);
title('Unfiltered Signal');
abs_y_fft = abs(y_fft);
half_spec_y_fft = abs_y_fft(1:win_len/2);
subplot(5,1,2);
plot(half_spec_y_fft);
title('Unfiltered Signal (Fourier Space/Frequency Domain)');
subplot(5,1,3);
plot(ham_zero_center_5(1:win_len/2));
title('Window (Fourier Space/Frequency Domain)');
abs_filt_y_f = abs(filt_y_f);
half_spec_filt_y_f = abs_filt_y_f(1:win_len/2);
subplot(5,1,4);
plot(half_spec_filt_y_f);
title('Filtered Signal (Fourier Space/Frequency Domain)');
subplot(5,1,5);
plot(t,real(filt_y));
title('Filtered Signal');

