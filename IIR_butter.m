clc
clear all
close all

srate=1024; %Hz
nyquist=srate/2; 
frange=[20 45]; % fiter frequencies between 20Hz and 45 Hz
order=4;

%create filter coefficients
[filtkernA filtkernB]=butter(order,frange/nyquist);

subplot(131)
plot(filtkernB,'bs-','linew',2)
hold on
plot(filtkernA,'gs-','linew',2)
legend('B','A')
title('Time-domain filter coefficients')
xlabel('Time points')

%how to evaluate an IIR filter: filter an implulse
imp=[zeros(1,500) 1 zeros(1,500)];
filterimp=filter(filtkernA,filtkernB,imp);

%power spectrum
filtpow=abs(fft(filterimp)).^2;
fvector=linspace(0,nyquist,floor(length(imp)/2)+1); 

subplot(132)
plot(imp,'k','linew',2)
hold on
plot(filterimp,'r','linew',2)
legend('Impulse','Filterted impulse')
title('Filtering an impulse')
xlabel('Time points')
set(gca,'xlim',[1 length(imp)],'ylim',[-1 1]*.06);

subplot(133)
plot(fvector,filtpow(1:length(fvector)),'rs-','linew',2)
hold on
plot([0 frange(1) frange frange(2) nyquist],[0 0 1 1 0 0],'k','linew',2)
set(gca,'xlim',[0 100])
legend('Implulse','Filterred impluse')
title('Frequency response')
xlabel('Frequency (Hz)')
