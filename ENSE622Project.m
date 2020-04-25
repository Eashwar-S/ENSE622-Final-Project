
% ENSE 622 Project 
% Calculations
% Author - Oghenetekevwe Akoroda
% Submitted 05/11/2020

% Regression analysis
% Monte Carlo simulation

k = 2000; % number of Monte Carlo trials
BinSz = 10; % bin size of histogram of drone cost
manfCost = 2; % manufacturing cost 
transCost = 3; % transportation cost

DroneCost = zeros(1,k);  % Monte Carlo drone cost for design 1
for i = 1:k
    frameCost = random(frame_cost); % per unit cost of drone frame
    battCost = random(batt_cost); % per unit cost of battery
    motorCost = random(motor_cost); % per unit cost of electric motor
    escCost = random(ESC_cost); % per unit cost of electric speed controller
    propCost = random(prop_cost); % per unit cost of propeller
    mcCost = random(MC_cost); % per unit cost of microcontroller
    flcCost = random(FLC_cost); % per unit cost of flight controller
    vsCost = random(VS_cost); % per unit cost of vision system
    navCost = random(nav_cost); % per unit cost of navigation system
    commCost = random(comm_cost); % per unit cost of communication system
    % calculate unit drone cost
    DroneCost(i) = frameCost + battCost + motorCost + escCost + propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost + manfCost + transCost;
end
AveDroneCost = mean(DroneCost); % Average drone design 1 cost
histogram(DroneCost,BinSz)
title('Drone cost for Design 1')


DroneCost2 = zeros(1,k);  % Monte Carlo drone cost for design 2
for i = 1:k
    frameCost = random(frame_cost2);
    battCost = random(batt_cost2);
    motorCost = random(motor_cost2);
    escCost = random(ESC_cost2);
    propCost = random(prop_cost2);
    mcCost = random(MC_cost2);
    flcCost = random(FLC_cost2);
    vsCost = random(VS_cost2);
    navCost = random(nav_cost2);
    commCost = random(comm_cost2);
    % calculate unit drone cost
    DroneCost2(i) = frameCost + battCost + motorCost + escCost + propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost + manfCost + transCost;
end

DroneCost3 = zeros(1,k);  % Monte Carlo drone cost for design 3
for i = 1:k
    frameCost = random(frame_cost3);
    battCost = random(batt_cost3);
    motorCost = random(motor_cost3);
    escCost = random(ESC_cost3);
    propCost = random(prop_cost3);
    mcCost = random(MC_cost3);
    flcCost = random(FLC_cost3);
    vsCost = random(VS_cost3);
    navCost = random(nav_cost3);
    commCost = random(comm_cost3);
    % calculate unit drone cost
    DroneCost3(i) = frameCost + battCost + motorCost + escCost + propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost + manfCost + transCost;
end


DroneCost4 = zeros(1,k);  % Monte Carlo drone cost for design 4
for i = 1:k
    frameCost = random(frame_cost4);
    battCost = random(batt_cost4);
    motorCost = random(motor_cost4);
    escCost = random(ESC_cost4);
    propCost = random(prop_cost4);
    mcCost = random(MC_cost4);
    flcCost = random(FLC_cost4);
    vsCost = random(VS_cost4);
    navCost = random(nav_cost4);
    commCost = random(comm_cost4);
    % calculate unit drone cost
    DroneCost4(i) = frameCost + battCost + motorCost + escCost + propCost + ...
     + mcCost + flcCost + vsCost + navCost + commCost + manfCost + transCost;
end


