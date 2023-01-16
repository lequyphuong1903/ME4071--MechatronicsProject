% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for control motor left via PID controller
% Last modified date: 2022, Sep, 20
function [int_el, vl, pre_nl] = pid_motor_left(er1l, wl, pre_nl, int_el)
    global ul;
    kp1 = 0.029;
    ki1 = 2.930;
    tsamppid = 0.02;
    r = 40;
    er2l = er1l;
    er1l = wl*30/pi - pre_nl;
    int_el = int_el + er1l*tsamppid;
    ul = kp1*er1l+ki1*int_el;
    if ul > 255
        ul = 255;
    end
    if ul<0 
        ul = 0;
    end
    [tt,y] = ode45(@motor1_tf,[0 tsamppid],pre_nl);
    pre_nl = y(length(y),1);
    pre_nl=pre_nl*4/3;
    vl = pre_nl*pi/30*r;
end