
% ENSE 622 Project 
% Calculations
% Author - Oghenetekevwe Akoroda
% Submitted 05/11/2020

clear; clc; close all
% Drone components Weight table
Component = {'Drone frame';'Propeller';'Motor';'Battery';'Navigation System'...
    ;'Electronic Speed Controller';'Microcontroller';'Flight Controller' ...
    ;'Communication System';'Vision System'};
Design1_Weight = [460,7.7*4,83.63*4,230,20.6,2,1.541,7.6,18.14,379]'; % Weight in grams
Design2_Weight = [460,7.7*4,83.63*4,330,6.8,6.9,1.541,7.6,16.22,375]';
Design3_Weight = [460,7.7*4,83.63*4,330,16.4,14.4,1.541,7.4,20.68,380]';
Design4_Weight = [460,7.7*4,83.63*4,230,16.4,14.4,0.657,7.4,20.68,390]';

CompWeights = table(Component,Design1_Weight,Design2_Weight,Design3_Weight  ...
 ,Design4_Weight);

% DroneWeight is in Newton 1.1 accounts for other components like wires, 
% package holder, propeller guard that are not included in system description
DroneWeight = 9.81e-3*[sum(CompWeights.Design1_Weight),sum(CompWeights.Design2_Weight) ...
    ,sum(CompWeights.Design3_Weight),sum(CompWeights.Design4_Weight)]*1.1;

BattCap = [2.2,3.2,3.2,2.2]; % battery capacity(Ah) of designs 1 - 4

% Response Equations 

% single motor Torque, Q(N-m) = Aq*w^2 where w is angular speed(rpm)
Aq = 2e-9;

% drone Thrust, T(N) = At*w^2 where w is angular speed(rpm)
At = 8e-7*4;  % 4 is for 4 motors
Cd = 0.04; % drag coefficient Drag = 0.5*Cd*1.2*A*V^2 where v is drone speed
CdLow = 0.04-0.0035;
CdHigh = 0.04 + 0.0035;
Atop = pi*0.45^2/4; % top area of the drone in meter square
Afront = (0.45/2)*0.11; % front area of the drone in meter square
Q0 = 0.9; % stall torque (N-m) at rated voltage
w_nl = 3500; % no load speed (rpm) at rated voltage
i_nl = 3; % no load current(A)
Qcons = 0.04; % torque constant (change in torque(N-m)/change in current(A))

wmax = (-(Q0/w_nl)+sqrt((Q0/w_nl)^2 + 4*Aq*Q0))/(2*Aq); % maximum rotational speed
Tmax = At*wmax^2; % maximum torque 

% DroneWeight is a vector containing the drone weight for the four designs.

% rated lifting capacity, LiftCap (in N)
LiftCap = (Tmax/2) - DroneWeight; %thrust-to-weight ratio of 2


% maximum speed, Vmax (in m/s)
A = (Atop*sqrt(Tmax^2 - DroneWeight.^2) + Afront*DroneWeight)/Tmax; % drone frontal area
Vmax = sqrt(2./(Cd*1.2*A)) .* (Tmax^2 - DroneWeight.^2).^0.25;

% maximum flight time (rated at 3 m/s), Ftmax (in hour)

% current drawn by motor at maximum flight time condition
imaxft = (sqrt(DroneWeight.^2 + 0.6*Cd*A*3^2)*Aq/At)/Qcons + i_nl;

Ftmax = BattCap./imaxft; 



% Monte Carlo simulation

k = 2000; % number of Monte Carlo trials

DroneCost = zeros(1,k);  % Monte Carlo drone cost for design 1
CRMCost = zeros(1,k); % Cumulative running mean of the drone cost for design 1
for i = 1:k
    frameCost = random3(28.78,46.89,145.99,0.35,0.5); % per unit cost of drone frame
    battCost = random3(39.99,59.99,109.99,0.3,0.5); % per unit cost of battery
    motorCost = random3(44.99,104.00,199.99,0.3,0.55); % per unit cost of electric motor
    escCost = random3(16.99,19.99,23.99,0.35,0.4); % per unit cost of electric speed controller
    propCost = random3(3.99,5.69,14.99,0.35,0.45); % per unit cost of propeller
    mcCost = random3(9.99,13.00,15.00,0.35,0.4); % per unit cost of microcontroller
    flcCost = random3(28.69,32.99,36.99,0.3,0.4); % per unit cost of flight controller
    vsCost = random3(112.99,148,186,0.35,0.4); % per unit cost of vision system
    navCost = random3(20.99,36.99,50.99,0.35,0.4); % per unit cost of navigation system
    commCost = random3(40.55,61.94,90.55,0.35,0.4); % per unit cost of communication system
    % calculate unit drone cost
    DroneCost(i) = frameCost + battCost + 4*motorCost + escCost + 4*propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost;
    if i == 1
        CRMCost(i) = DroneCost(i);
    else
        CRMCost(i) = ((i-1)*CRMCost(i-1)+DroneCost(i))/i;
    end
end
AveDroneCost1 = mean(DroneCost); % Average drone design 1 cost
StdDroneCost1 = std(DroneCost); % Standard deviation of drone design 1 cost
SEDroneCost1 = StdDroneCost1/sqrt(k); % Standard error of the average drone design 1 cost

DroneCost2 = zeros(1,k);  % Monte Carlo drone cost for design 2
CRMCost2 = zeros(1,k); % Cumulative running mean of the drone cost for design 2
for i = 1:k
    frameCost = random3(28.78,46.89,145.99,0.35,0.5);
    battCost = random3(59.99,79.99,109.99,0.3,0.5);
    motorCost = random3(44.99,104.00,199.99,0.3,0.55);
    escCost = random3(23.69,29.69,32.99,0.3,0.4);
    propCost = random3(3.99,5.69,14.99,0.35,0.45);
    mcCost = random3(9.99,13.00,15.00,0.35,0.4);
    flcCost = random3(28.69,32.99,36.99,0.3,0.4);
    vsCost = random3(198,269,346,0.3,0.4);
    navCost = random3(48.35,185,212.60,0.3,0.4);
    commCost = random3(50.69,78.76,100.99,0.3,0.4);
    % calculate unit drone cost
    DroneCost2(i) = frameCost + battCost + 4*motorCost + escCost + 4*propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost;
    if i == 1
        CRMCost2(i) = DroneCost2(i);
    else
        CRMCost2(i) = ((i-1)*CRMCost2(i-1)+DroneCost2(i))/i;
    end
end

AveDroneCost2 = mean(DroneCost2); % Average drone design 2 cost
StdDroneCost2 = std(DroneCost2); % Standard deviation of drone design 2 cost
SEDroneCost2 = StdDroneCost2/sqrt(k); % Standard error of the average drone design 2 cost

DroneCost3 = zeros(1,k);  % Monte Carlo drone cost for design 3
CRMCost3 = zeros(1,k); % Cumulative running mean of the drone cost for design 3
for i = 1:k
    frameCost = random3(28.78,46.89,145.99,0.35,0.5);
    battCost = random3(59.99,79.99,109.99,0.3,0.5);
    motorCost = random3(44.99,104.00,199.99,0.3,0.55);
    escCost = random3(29.69,32.99,36.99,0.3,0.4);
    propCost = random3(3.99,5.69,14.99,0.35,0.45);
    mcCost = random3(9.99,13.00,15.00,0.35,0.4);
    flcCost = random3(47.99,51.99,55.99,0.3,0.4);
    vsCost = random3(190.20,259,350,0.3,0.4);
    navCost = random3(10.45,29.99,48.99,0.3,0.4);
    commCost = random3(55.99,81.40,110.99,0.3,0.4);
    % calculate unit drone cost
    DroneCost3(i) = frameCost + battCost + 4*motorCost + escCost + 4*propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost;
    if i == 1
        CRMCost3(i) = DroneCost3(i);
    else
        CRMCost3(i) = ((i-1)*CRMCost3(i-1)+DroneCost3(i))/i;
    end
end

AveDroneCost3 = mean(DroneCost3); % Average drone design 3 cost
StdDroneCost3 = std(DroneCost3); % Standard deviation of drone design 3 cost
SEDroneCost3 = StdDroneCost3/sqrt(k); % Standard error of the average drone design 3 cost


DroneCost4 = zeros(1,k);  % Monte Carlo drone cost for design 4
CRMCost4 = zeros(1,k); % Cumulative running mean of the drone cost for design 1

for i = 1:k
    frameCost = random3(28.78,46.89,145.99,0.35,0.5);
    battCost = random3(39.99,59.99,109.99,0.3,0.5);
    motorCost = random3(44.99,104.00,199.99,0.3,0.55);
    escCost = random3(45.99,50.99,55.99,0.3,0.4);
    propCost = random3(3.99,5.69,14.99,0.35,0.45);
    mcCost = random3(22.00,24.40,29.99,0.35,0.4);
    flcCost = random3(47.99,51.99,55.99,0.3,0.4);
    vsCost = random3(244,345,450,0.3,0.4);
    navCost = random3(10.45,29.99,48.99,0.3,0.4);
    commCost = random3(55.99,81.40,110.99,0.3,0.4);
    % calculate unit drone cost
    DroneCost4(i) = frameCost + battCost + 4*motorCost + escCost + 4*propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost;
    if i == 1
        CRMCost4(i) = DroneCost4(i);
    else
        CRMCost4(i) = ((i-1)*CRMCost4(i-1)+DroneCost4(i))/i;
    end
end

AveDroneCost4 = mean(DroneCost4); % Average drone design 4 cost
StdDroneCost4 = std(DroneCost4); % Standard deviation of drone design 4 cost
SEDroneCost4 = StdDroneCost4/sqrt(k); % Standard error of the average drone design 4 cost

Metric = {'Drone unit cost($)';'Rated lifting capacity(N)';'Maximum speed(m/s)'...
    ;'Maximum flight time(hour)'};

Design1 = [AveDroneCost1;LiftCap(1);Vmax(1);Ftmax(1)];
Design2 = [AveDroneCost2;LiftCap(2);Vmax(2);Ftmax(2)];
Design3 = [AveDroneCost3;LiftCap(3);Vmax(3);Ftmax(3)];
Design4 = [AveDroneCost4;LiftCap(4);Vmax(4);Ftmax(4)];

% FinTab is a table with the metric values for each design
FinTab = table(Metric,Design1,Design2,Design3,Design4); 

Drone1WeightLow = DroneWeight(1)*1.05/1.1;  % low end of design 1 drone weight
Drone1WeightHigh = DroneWeight(1)*1.15/1.1;  % high end of design 1 drone weight

LiftCapHigh = (Tmax/2) - Drone1WeightLow;  % low end of design 1 rated lifting capacity
LiftCapLow = (Tmax/2) - Drone1WeightHigh;  % high end of design 1 rated lifting capacity

% low end of design 1 maximum speed
VmaxLow = sqrt(2./(CdHigh*1.2*A(1))) .* (Tmax^2 - Drone1WeightHigh.^2).^0.25;
% high end of design 1 maximum speed
VmaxHigh = sqrt(2./(CdLow*1.2*A(1))) .* (Tmax^2 - Drone1WeightLow.^2).^0.25;

imaxftLow = (sqrt(Drone1WeightLow.^2 + 0.6*CdLow*A(1)*3^2)*Aq/At)/Qcons + i_nl;
imaxftHigh = (sqrt(Drone1WeightHigh.^2 + 0.6*CdHigh*A(1)*3^2)*Aq/At)/Qcons + i_nl;

% low end of design 1 maximum flight time
FtmaxLow = BattCap(1)./imaxftHigh;
% high end of design 1 maximum flight time
FtmaxHigh = BattCap(1)./imaxftLow;

plot(1:k,CRMCost,1:k,CRMCost2,1:k,CRMCost3,1:k,CRMCost4)
legend('Design 1','Design 2','Design 3','Design 4')
xlabel('count')
ylabel('cumulative running mean, $')
title('cumulative running mean of the costs of the drone designs')

% random3 is a function that substitutes for a probability distribution
% in generating the random cost variables

function randval = random3(Low,Med,High,pLow,pMed)

% Low is the low cost, Med is the medium cost and High is the high cost 
% pLow is the probability of getting the low cost
% pMed is the probability of getting the medium cost
% pHigh is the probability of getting the high cost

rand22 = rand;
if rand22 < pLow
    randval = Low;
elseif rand22 >= pLow && rand22 < pLow + pMed
    randval = Med;
else
    randval = High;
end
end

