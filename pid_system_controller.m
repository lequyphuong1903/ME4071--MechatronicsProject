% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for determine omega and velocity robot via PID controller
% Last modified date: 2022, Sep, 20
function [err, pre_err, wl, wr, vl, vr]= pid_system_controller(err, pre_err, iPart)
    vR = 500;
    b = 200;
    r = 40;
    kI = 0;
    kP = 0.09;
    kD = 0;
    tsamp = 0.2;
    pPart = err;
    iPart = iPart + (err + pre_err)*tsamp;
    dPart = (err - pre_err)/tsamp;
    w = kP*pPart + kD*dPart + kI*iPart;  
    vl= vR - w*b/2;
    vr= vR + w*b/2;
    pre_err = err;
    wl = vl/r;
    wr = vr/r;
end