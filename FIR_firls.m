clc
clear all
close all

srate=1024; %Hz
nyquist=srate/2; 
frange=[20 45]; % fiter frequencies between 20Hz and 45 Hz
transw= 10/100; % 10 percent transition width
order= round(10*srate/frange(1)); %number of time points in the filter kernel

shape=[0 0 1 1 0 0]; % y axis values 
fx= [0 frange(1)-frange(1)*transw frange frange(2)+frange(2)*transw nyquist]/nyquist; 
%x axis values in fractions of nyquist

%filter kernel
filtkern=firls(order,fx,shape);

%power spectrum of filter kernel
filtpow=abs(fft(filtkern)).^2;

%frequency vector
fvector=linspace(0,nyquist,floor(length(filtkern)/2)+1);
filtpow=filtpow(1:length(fvector));

%% Plotting
subplot(131)
plot(filtkern,'linew',2)
xlabel('Time points')
title('Filter Kernel (firls)')
axis square

subplot(132)
plot(fvector,filtpow,'ks-','linew',2,'markerfacecolor','w')
hold on
plot(fx*nyquist,shape,'ro-','linew',2,'markerfacecolor','w')
set(gca,'xlim',[0 frange(1)*4])
axis square
xlabel('Frequency(Hz)')
ylabel('Filter gain')
title('Frequency Response (firls)')
legend('Actual','Ideal')

subplot(133)
plot(fvector,filtpow,'ks-','linew',2,'markerfacecolor','w')
title('Actual Frequency Response (firls)')
set(gca,'xlim',[0 frange(1)*4])
axis square
xlabel('Frequency(Hz)')
ylabel('Filter gain')


