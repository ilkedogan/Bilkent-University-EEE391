%% Part 1.2
Number = [0 5 0 7 6 5 6 6 5 6 7];
x = DTMFTRA(Number);
soundsc(x,16384);

%% Part 1.3
Number = [0 2 2 1 5];
x = DTMFTRA(Number);
X = FT(x);
omega=linspace(-16384*pi,16384*pi,16384*2.5+1);
omega=omega(1:end-1);

plot(omega,abs(X)), title("Fourier Transform");
xlabel("Frequency");
ylabel("Magnitude");

%% Part 1.4 & 1.5 & 1.6
% index 3
rectangle3 = [zeros(1, 16384) ones(1, 0.5*16384), zeros(1,16384)];
x3 = x.*rectangle3;
X = FT(x3);
omega=linspace(-16384*pi,16384*pi,16384*2.5+1);
omega=omega(1:end-1); 
plot(omega,abs(X));

% index 2
rectangle2 = [zeros(1, 0.5*16384) ones(1, 0.5*16384), zeros(1,1.5*16384)];
x2 = x.*rectangle2;
X = FT(x2);
omega=linspace(-16384*pi,16384*pi,16384*2.5+1);
omega=omega(1:end-1); 
plot(omega,abs(X));

% index 1
rectangle1 = [ones(1, 0.5*16384), zeros(1,2*16384)];
x1 = x.*rectangle1;
X = FT(x1);
omega=linspace(-16384*pi,16384*pi,16384*2.5+1);
omega=omega(1:end-1); 
plot(omega,abs(X));

% index 4
rectangle4 = [zeros(1, 1.5*16384) ones(1, 0.5*16384) zeros(1,0.5*16384)];
x4 = x.*rectangle4;
X = FT(x4);
omega=linspace(-16384*pi,16384*pi,16384*2.5+1);
omega=omega(1:end-1); 
plot(omega,abs(X));

% index 5
rectangle5 = [zeros(1, 2*16384) ones(1, 0.5*16384)];
x5 = x.*rectangle5;
X = FT(x5);
omega=linspace(-16384*pi,16384*pi,16384*2.5+1);
omega=omega(1:end-1); 
plot(omega,abs(X));
%% Part 1.1 - General view of the Question1
function [x] = DTMFTRA(Number)
Fr=[697 770 852 941];
Fc=[1209 1336 1477 1633];
numLength = length(Number);
x = [];
t = 0;
index = 1;
while (t < 0.5 * numLength)
    toAdd = 0;
    switch Number(index)
        case 0
            toAdd = cos(2 * pi * Fr(4) * t) + cos(2 * pi * Fc(2) * t);
        case 1
            toAdd = cos(2 * pi * Fr(1) * t) + cos(2 * pi * Fc(1) * t);
        case 2
            toAdd = cos(2 * pi * Fr(1) * t) + cos(2 * pi * Fc(2) * t);
        case 3
            toAdd = cos(2 * pi * Fr(1) * t) + cos(2 * pi * Fc(3) * t);
        case 4
            toAdd = cos(2 * pi * Fr(2) * t) + cos(2 * pi * Fc(1) * t);
        case 5
            toAdd = cos(2 * pi * Fr(2) * t) + cos(2 * pi * Fc(2) * t);
        case 6
            toAdd = cos(2 * pi * Fr(2) * t) + cos(2 * pi * Fc(3) * t);
        case 7
            toAdd = cos(2 * pi * Fr(3) * t) + cos(2 * pi * Fc(1) * t);
        case 8
            toAdd = cos(2 * pi * Fr(3) * t) + cos(2 * pi * Fc(2) * t);
        case 9
            toAdd = cos(2 * pi * Fr(3) * t) + cos(2 * pi * Fc(3) * t);
        otherwise
            disp('Enter in the range 0 to 9 only')
    end
    x = [x, toAdd];
    if(t > index/2)
        index = index + 1;
    end
    t = t + 1/16384;
end
end