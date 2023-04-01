% Coding Practical Week 3
%%
clear all; close all; clc
% 1. Calculate compound interest on £300 over 20 years where return is 23%
t = 0:20;
x_0 = 300; % 300
R = 0.23; % 23% return

% apply formula!
X = x_0*(1+R).^t;
% Compound interest each year is
disp(X)

figure;
plot(t,X,'or') ;
xlabel('Time in years');
ylabel('Interest return');

% Done in loop
for i = 1:length(t)
    X(i) = x_0*(1+R)^t(i);
end
figure
plot(t,X)
%%
clear all; close all; clc
% 2. Demonstrate using plot that natural logarithm is inverse of
% exponential
d = -1:0.1:1;

y = log(exp(d)); % come back

figure;
plot(d,y,'r','LineWidth',4) ;
%%
clear all; close all; clc
% 3. Define vector in intervals of 0.25 spanning -2:2
y = -2:0.25:2;
% A. Using for loop and if else report index of first value exceeding -0.6
for i = 1:length(y)
    if y(i) > -0.6
        index = i;
        disp(index);
        break
    end
end
% B. Use find to report all indices >-0.4 but <-0.2
z = find(y>-0.4 & y<-0.2);
disp(z)
%%
clear all; close all; clc
% 4. % decay rate of F is 0.34 per day, dose of 30mg
t = 0:20;
c_0 = 30;
k = 0.34;

c = c_0*exp(-k.*t);
figure
plot(t,c,'--g')
xlabel('time in days')
ylabel('concentration of fluoxetine in mg')
% how many days until 15mg expelled
half = find(c <= 15);
disp(half(1))
%%
clear all; close all; clc
% 5. Draw inverted U curve as quadratic function where
% 500 nM  of dopamine is low level impairing and 1000 is high that impairs
a0 = 0;
a1 = .05;
a2 = -1.3;

x = 500:20:1000; % x domain
x = x - 750; % shift so peak is central
y = a0 + a1.*(x.^1) + a2*(x.^2);
% plot
figure
plot(x,y)

%%
clear all; close all; clc
% 6.
presyn = [1 3 4 5 2];
synweight = [-44 5 -6 8 6];
in_x = presyn*synweight';
alpha = 4;

sigmoid = 1/(1-exp(-alpha*in_x));
disp('Probability of firing')
disp(sigmoid)


%%
clear all; close all; clc

a1 = (50+10)/(10+5);
a2 = (80+10)/(10+5);
b1 = 10;
b2 = 20;

x = -5:10;
y1 = a1*x + b1;
y2 = a2*x + b2;
figure 
plot(x, y1)
hold on
plot(x,y2,'r')
