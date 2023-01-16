% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for control motor right via PID controller
% Last modified date: 2022, Sep, 20
function [int_er, vr, pre_nr] = pid_motor_right(er1r, wr, pre_nr, int_er)
    global ur;
    kp2 = 0.034;
    ki2 = 2.720;
    r = 40;
    tsamppid = 0.02;
    er2r = er1r;
    er1r = wr*30/pi-pre_nr;
    int_er = int_er+er1r*tsamppid;
    ur = kp2*er1r + ki2*int_er;
    if ur > 255 
        ur = 255;
    end
    if ur < 0 
        ur = 0;
    end
    [tt,y] = ode45(@motor2_tf,[0 tsamppid],pre_nr);
    pre_nr = y(length(y),1);
    pre_nr = pre_nr*4/3;
    vr = pre_nr*pi/30*r;
end