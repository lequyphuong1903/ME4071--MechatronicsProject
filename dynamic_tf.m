% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for determine coordinate of robot
% Last modified date: 2022, Sep, 20
function dq=dynamic_tf(t,q)
    global d v_input w_input
            dq=zeros(3,1);
            dq(1)=cos(q(3))*v_input; %x
            dq(2)=sin(q(3))*v_input; %y
            dq(3)=w_input; %phi
 end
    