% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for transfer function of motor right
% Last modified date: 2022, Sep, 20
function dwdt=motor_tf(t,w)
    global ur
    K=23.186;
    a=0.5;
    b=0.023;
    dwdt = (-a*w+K*ur)/b;
end
   