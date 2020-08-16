clc
clear all
close all

srate=1024; %Hz
nyquist=srate/2; 
frange=[20 45]; % fiter frequencies between 20Hz and 45 Hz
transw= 10/100; % 10 percent transition width

shape=[0 0 1 1 0 0]; % y axis values 
fx= [0 frange(1)-frange(1)*transw frange frange(2)+frange(2)*transw nyquist]/nyquist; 
%x axis values in fractions of nyquist

% order of the filter from 1 to 15
order_up= (1*srate/frange(1))/(srate/1000);
order_low=(15*srate/frange(1))/(srate/1000);
orders=round(linspace(order_up,order_low,10));

%initialize
filtkern=zeros(length(orders),1000);
fvector=linspace(0,srate,1000);

for i=1:length(orders)
    filtkern=firls(orders(i),fx,shape);
    filtpow(i,:)=abs(fft(filtkern,1000)).^2;
    n(i)=length(filtkern);
    
    subplot(211)
    hold on
    plot((1:n(i))-n(i)/2,filtkern+0.01*i,'linew',2)
end

title('Filter kernels with different orders (firls)');
xlabel('Time points')

subplot(212)
plot(fx*nyquist,shape,'k','linew',2)
hold on
plot(fvector,filtpow)
set(gca,'xlim',[0 frange(1)*4])
xlabel('Frequency(Hz)')
ylabel('Filter gain')
title('Frequency Response with different orders (firls)')
legend('Ideal')


