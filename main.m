% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% MAIN SCRIPT
% Last modified date: 2022, Sep, 20
%% CREATE PROJECT
clc;
clear all;
close all;
global ul ur R v_input w_input d;
syms z;
%% DRAW MAPLINE
saban;
hold on
xlim([-3100,100]);
ylim([-200,1650]);
grid on
%% MECHANICAL PAPAMETERS
b = 200;
d = 55;
r = 80/2; 
%% INIT COORDINATE
xM(1) = 0;
yM(1) = 0;
phi(1) = pi;
pre_pos = [xM(1); yM(1); phi(1)];
xC(1)=xM(1) + d*cos(phi(1));
yC(1)=yM(1) + d*sin(phi(1));

%% MODEL ROBOT
h1 = plot(1, 1, 'black');
h2 = plot(1,1, 'black');
h3 = plot(1,1, 'black');
h4 = plot(1,1, 'black');
obit = animatedline('Color','b','LineWidth',2);
%% PID SYSTEM CONTROLLER
pre_err =0;
iPart = 0;
pPart = 0;
dPart = 0;
%% PID MOTOR CONTROLLER
% Motor left
pre_nl = 0;
er1l = 0;
int_el = 0;
% Motor right
pre_nr = 0;
er1r = 0;
int_er = 0;
%% INIT SETUP
color = 0;
tsamp = 0.2;
tsamppid = 0.02;
R = 800;
line = 1;
stop = 0;
jj = round(tsamp/tsamppid);
if jj == 0
   jj = 1;
end
%% Line detection
for i =1:100
    t(i)=i*tsamp;
    % GET E2
    [line, i, j, e(i), stop, color] = get_e2(line, xC(i), yC(i), phi(i), i, j, color);
    if (stop == 1)
        break;
    end
    % GET VELOCITY FOR MOTORS
    [e(i), pre_err, wl(i), wr(i), vl(i), vr(i)] = pid_system_controller(e(i), pre_err, iPart);
    for j=1:(jj)
        % MOTOR LEFT PID CONTROL
        [int_el, vl(i), pre_nl] = pid_motor_left(er1l, wl(i), pre_nl, int_el);
        % MOTOR RIGHT PID CONTROL
        [int_er, vr(i), pre_nr] = pid_motor_right(er1r, wr(i), pre_nr, int_er);
        % EMBEDDED
        v(i)=(vl(i)+vr(i))/2;
        v_input=v(i);
        w_input=(vr(i)-vl(i))/b;
        % GET COORDINATES
        [tt,y] = ode45(@dynamic_tf,[0 tsamppid],pre_pos);
        xM(i+1)= y(length(y),1);
        yM(i+1)= y(length(y),2);
        phi(i+1)= y(length(y),3);
        pre_pos=[ xM(i+1); yM(i+1); phi(i+1)];
        xC(i+1) = xM(i+1) + d*cos(phi(i+1));
        yC(i+1) = yM(i+1) + d*sin(phi(i+1));
        % DRAW ROBOT POSITION
        delete(h1);
        delete(h2);
        delete(h3);
        delete(h4);
        xs = linspace(xC(i) + d*sin(phi(i)-pi/2), xC(i) + 0*d*sin(phi(i)-pi/2),2);
        ys = linspace(yC(i) - d*cos(phi(i)-pi/2), yC(i) - 0*d*cos(phi(i)-pi/2),2);
        xm = linspace(xC(i) + d*sin(phi(i)-pi/2)- b*sin(phi(i)), xC(i) + d*sin(phi(i)-pi/2) + b*sin(phi(i)),2);
        ym = linspace(yC(i) - d*cos(phi(i)-pi/2)+ b*cos(phi(i)), yC(i) - d*cos(phi(i)-pi/2) - b*cos(phi(i)),2);
        xa = linspace(xC(i) - 80*sin(phi(i)), xC(i) + 80*sin(phi(i)),2);
        ya = linspace(yC(i) + 80*cos(phi(i)), yC(i) - 80*cos(phi(i)),2);
        h1=plot(xs, ys, 'k','LineWidth',2);
        h2=plot(xm, ym, 'black','Linewidth',2);
        h3=plot(xa, ya, 'blue','Linewidth',2);
        addpoints(obit,xC(i), yC(i));
        drawnow;
        movieVector(i) = getframe;
    end
end
%% PLOT DATA
vl(1) = 0; vr(1) = 0;
wl(1) = 0; wr(1) = 0;
vl(i) = 0; vr(i) = 0;
wl(i) = 0; wr(i) = 0;
wl = wl*10; wr = wr*10;
xlabel('mm');
xlim([-3100,100]);
ylim([-200,1650]);
title('Mo hinh hoa');
figure();
plot(t,e);
hold on;
y=zeros(1,length(t));
plot(t,y,'r');
grid on;
xlabel('time(s)');
ylabel('Tracking error e_2 (mm)');
title('Plot e_2 ');
figure();
plot(t,wl);
hold on;
plot(t,wr);
grid on;
legend('\omega_l', '\omega_r ');
xlabel('Time(s)');
ylabel('Omega (RPM)');
title('Angular velocity of robot');
figure();
plot(t,vl);
hold on;
plot(t,vr);
grid on;
legend('v_l', 'v_r ');
xlabel('Time(s)');
ylabel('Speed (mm/s)');
title('Speed of robot ');
ylim([0 900]);
%% SAVE VIDEO
% if (color == 1)
%     myWriter = VideoWriter('Line Tracking Red', 'MPEG-4');
% elseif (color == 2)
%     myWriter = VideoWriter('Line Tracking Green', 'MPEG-4');
% end
% myWriter.FrameRate = 3;
% open(myWriter);
% writeVideo(myWriter,movieVector);
% close(myWriter);