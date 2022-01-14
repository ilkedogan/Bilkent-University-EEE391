clear
clc
[x,Fs] = audioread("ilke.m4a");
x_ = x(1:length(x)/81920:length(x), :);
figure
plot(x) %my normal speech
legend("normal speech")
xlabel("t")
ylabel("normal speech signal")
figure
plot(x_) %my speech with 8192 sampling
legend("speech with 8192 sampling")
xlabel("t")
ylabel("speech with 8192 sampling signal")
A = [0.8 0.6 0.4 0.2 0.05];
ti = [0.5 1 1.5 2 3];
M = 5;
for i=1:M
  x_(i) = 0;
end
y = zeros(81920,2);
delayed_signal = zeros(81920,2);
for t=1:81920/2-1
  for j=1:M
      y(2*t,:) = x_(2*t,:) + A(j)*x_(abs(2*(t - ti(j)))+1,:);
        delayed_signal(2*t,:) = A(j)*x_(abs(2*(t - ti(j)))+1,:);
  end
end
figure
plot(1:1:81920, x_(:,1))
title("x and Delayed Signal")
legend("x(t)")
xlabel("t")
ylabel("x(t)")
hold on
plot(1:1:81920, delayed_signal)
legend("x(t)", "Delayed signal")
figure
plot(1:1:81920, y(:,1))
title("y and Delayed Signal")
hold on
plot(1:1:81920, delayed_signal)
legend("y(t)", "Delayed signal")
xlabel("t")
ylabel("y(t)")
omega=linspace(-8192*pi,8192*pi,8192*10+1);
omega=omega(1:end-1);

y = y(1: 10 * 8192);
yw = FT(y);

omega = linspace(-8192 * pi, 8192 * pi, 8192 * 10 + 1);
omega = omega(1:end - 1);

% H is computed
H = 1;
for i = 1:M
    H = H + A(i) * exp(-1i*omega*ti(i));
end
h = IFT(H);
figure(4);
tx = 0:1/8192:10-1/8192;
plot(tx,h), title("h(t) vs t");
ylabel("h(t)");
xlabel("t");

plot(omega, abs(H));
ylabel("| H(w) |"); xlabel("omega");

Xe = yw./H;
xe = IFT(Xe);
plot(tx, xe);
xlabel("t"); ylabel("Xe(t)");