% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for verify e2 of robot
% Last modified date: 2022, Sep, 20
function [line, i, j, e, stop, color] = get_e2(line, xC, yC, phi, i, j, color)
    global R;
    stop = 0;
    switch line
        case 1
            if xC<-2500
                line=2;
            end
            if (xC<-2000 && color == 0)
                answer = questdlg('What color of package?', ...
	                              'Choose Color', ...
	                              'Red', 'Green', 'Red');
                if answer == "Red"
                    color = 1;
                else
                    color = 2;
                end
            end
        case 2
            if yC > 500 
                line=3;
            end
        case 3
            if xC> -2500
                line=4;
            end
        case 4
            if xC>=-2331.3705
                line=5;
            end
        case 5
            if xC>=-1765.6854
                line=6;
            end
        case 6
            if xC>=-1734.3146
                line=7;
            end
        case 7
            if xC>=-1168.1292
                line = 8;
            end
        case 8
            if xC > 20
                stop = 1;
                e2 = 0;
            end
    end
    switch line
        case 1
            fline=@(z)0;
            x0 = xC;
        case 2
            fline=@(z) 500 - sqrt(500^2 - (z + 2500)^2);
            x0 = xC - 10;
        case 3
            fline=@(z) sqrt(500^2 - (z + 2500)^2) + 500;
            x0 = xC;
        case 4
            fline=@(z) 1000;
            x0 = xC;
        case 5
            if (color == 1)
                fline=@(z) 1800 - sqrt(800^2 - (z + 2331.3708).^2);
                x0 = xC;
            elseif (color == 2)
                fline=@(z) 200 + sqrt(800^2 - (z + 2331.3708).^2);
                x0 = xC;
            end
        case 6
            if(color==1)
                fline=@(z) z+3000;
                x0 = xC;
            elseif (color == 2)
                fline=@(z) z+2450;
                x0 = xC;
            end
        case 7
            if (color == 1)
                fline = @(z) 700 + sqrt(800^2 - (z + 1168.6292).^2);
                x0 = xC;
            elseif (color ==2)
                fline = @(z) 1300 - sqrt(800^2 - (z + 1168.6292).^2);
                x0 = xC;
            end
        case 8
            if (color == 1)
                fline=@(z)1500;
                x0 = xC;
            elseif (color == 2)
                fline=@(z)500;
                x0 = xC;
            end
        otherwise
    end
    % Get coordinate
    if x0 <= -3000 
        x0 = -3000;
    elseif x0 >= 0
        x0 = 0;
    end
    
    phiK = phi- pi/2;
    if (mod(phiK,pi)~=0) && (line ~= 6)
        fxe = @(z) tan(phiK)*(z-xC) + yC;
        fun = @(z) fline(z) - fxe(z); % function
        xK = fzero(fun,x0);
    else
        xK = xC;
    end
    yK = fline(xK);
    xR = xK;
    yR= yK;
    phiR = pi/2;
    if (i==2) j=1; 
    end
    % XAC DINH GOC CUA SA BAN
    if (line ==1 && i>=2 )
        phiR = pi;
    end
    t2 = 0;
    if(line ==2) 
        if (t2==0) j=i-1;
        end
        phiR = pi+(i-j)/R;
        t2 = 1;
    end
    t3 = 0; 
    if t3 == 0; j = i -1; end
    if (line == 3)
        phiR = 3*pi/2 +(i-j)/R;
    end
    if (line ==4)
        phiR = 2*pi;
    end
    if (line ==5)
        phiR = 2*pi+(i-j)/R;
    end
    if (line ==6)
        if (color==1)
            phiR = 9/4*pi;
        elseif (color==2)
            phiR = -9/4*pi;
        end
    end
    if (line ==7)
        phiR = 2*pi+(i-j)/R;
    end
     if (line ==8)
        phiR = 2*pi+(i-j)/R;
    end
     
    
    % CALCULATE ERROR                                    
    e = -(xR - xC)* sin(phi) + (yR - yC)*cos(phi) + (-2.5 + 5 * rand(1, 1));
end