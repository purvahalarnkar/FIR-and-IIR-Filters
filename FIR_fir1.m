clc
clear all
close all

srate=1024; %Hz
nyquist=srate/2; 
frange=[20 45]; % fiter frequencies between 20Hz and 45 Hz
transw= 10/100; % 10 percent transition width
order= round(9*srate/frange(1)); %number of time points in the filter kernel
fx=[0 frange(1) frange frange(2) nyquist];
shape=[0 0 1 1 0 0];

%filter kernel
filtkern=fir1(order,frange/nyquist);

%power spectrum of filter kernel
filtpow=abs(fft(filtkern)).^2;

%frequency vector
fvector=linspace(0,nyquist,floor(length(filtkern)/2)+1);
filtpow=filtpow(1:length(fvector));

%% Plotting
subplot(131)
plot(filtkern,'linew',2)
xlabel('Time points')
title('Filter Kernel (fir1)')
axis square

subplot(132)
plot(fvector,filtpow,'ks-','linew',2,'markerfacecolor','w')
hold on
plot(fx,shape,'ro-','linew',2,'markerfacecolor','w')
set(gca,'xlim',[0 frange(1)*4])
axis square
xlabel('Frequency(Hz)')
ylabel('Filter gain')
title('Frequency Response (fir1)')
legend('Actual','Ideal')

subplot(133)
plot(fvector,filtpow,'ks-','linew',2,'markerfacecolor','w')
title('Actual Frequency Response (fir1)')
set(gca,'xlim',[0 frange(1)*4])
axis square
xlabel('Frequency(Hz)')
ylabel('Filter gain')