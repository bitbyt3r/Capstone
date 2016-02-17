function [ outputbuff] = scratchfilt( inputsample)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outputbuff = [];
output = 0;
y_cyc = zeros(12) ;
x_cyc = zeros(11) ; 
ac = [1,    -9.30079109286,    39.47322652289,   -100.6111990575,170.4932496417,   -200.6646209816,    166.1127610004,    -95.5076150327, 36.50818996156,   -8.381153611238,   0.8779717568645, 0
];
bc = [3.080932235165e-09,  0,-1.540466117583e-08, 0,3.080932235165e-08,0,-3.080932235165e-08,0,1.540466117583e-08,0,-3.080932235165e-09];

for i = 1:1:length(inputsample)
     y_cyc(12)=y_cyc(11);
    y_cyc(11)=y_cyc(10);
    y_cyc(10)=y_cyc(9);
    y_cyc(9)=y_cyc(8);
    y_cyc(8)=y_cyc(7);
    y_cyc(7)=y_cyc(6);
    y_cyc(6)=y_cyc(5);
    y_cyc(5)=y_cyc(4);
    y_cyc(4)=y_cyc(3);
    y_cyc(3)=y_cyc(2);
    y_cyc(2)=y_cyc(1);
    y_cyc(1) = output;


    x_cyc(11)=x_cyc(10);
    x_cyc(10)=x_cyc(9);
    x_cyc(9)=x_cyc(8);
    x_cyc(8)=x_cyc(7);
    x_cyc(7)=x_cyc(6);
    x_cyc(6)=x_cyc(5);
    x_cyc(5)=x_cyc(4);
    x_cyc(4)=x_cyc(3);
    x_cyc(3)=x_cyc(2);
    x_cyc(2)=x_cyc(1);
    x_cyc(1)=inputsample(i);
    disp('here')
    
    output = (1/ac(1))*((bc(1)*x_cyc(1)+bc(2)*x_cyc(2)+bc(3)*x_cyc(3)+bc(4)*x_cyc(4)+bc(5)*x_cyc(5)+bc(6)*x_cyc(6)+bc(7)*x_cyc(7)+bc(8)*x_cyc(8)+bc(9)*x_cyc(9)+bc(10)*x_cyc(10)+bc(11)*x_cyc(11))-(ac(2)*y_cyc(1)+ac(3)*y_cyc(2)+ac(4)*y_cyc(3)+ac(5)*y_cyc(4)+ac(6)*y_cyc(5)+ac(7)*y_cyc(6)+ac(8)*y_cyc(7)+ac(9)*y_cyc(8)+ac(10)*y_cyc(9)+ac(11)*y_cyc(10)+ac(12)*y_cyc(11)));
    outputbuff= [outputbuff output];
end


end

