clc
clear all
close all

srate=1024; %Hz
nyquist=srate/2; 
frange=[20 45]; % fiter frequencies between 20Hz and 45 Hz
order= 400; %number of time points in the filter kernel
shape=[0 0 1 1 0 0]; % y axis values 

%range of transition widths
transw=linspace(0.01,0.4,10);

%initialize
filtkern=zeros(length(transw),1000);
fvector=linspace(0,srate,1000);

for i=1:length(transw)
    fx= [0 frange(1)-frange(1)*transw(i) frange frange(2)+frange(2)*transw(i) nyquist]/nyquist;
    filtkern=firls(400,fx,shape);
    filtpow(i,:)=abs(fft(filtkern,1000)).^2;
    n(i)=length(filtkern);
    
    subplot(211)
    hold on
    plot((1:n(i))-n(i)/2,filtkern+0.01*i,'linew',2)
end

title('Filter kernels with different transition widths (firls)');
xlabel('Time points')

subplot(212)
plot(fx*nyquist,shape,'k','linew',2)
hold on
plot(fvector,filtpow)
set(gca,'xlim',[0 frange(1)*4])
xlabel('Frequency(Hz)')
ylabel('Filter gain')
title('Frequency Response with different transition widths (firls)')
legend('Ideal')
