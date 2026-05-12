function [frequency, amplitude] = myFFT(time, signal)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
deltat   = mean(diff(time));
samplefre= 1/deltat;
untime   = time(1):deltat:time(end);
unsignal = interp1(time, signal, untime, "spline");
fourier  = fft(unsignal);
datalen  = length(unsignal);
totalamp = abs(fourier/datalen);
amplitude= totalamp(1:floor(datalen/2)+1);
frequency= samplefre*(0:datalen/2)/datalen;
end