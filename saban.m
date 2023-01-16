% Mechatronics System Design Project - Semester: 221
% Lecture: Assoc Prof, PhD. Nguyen Tan Tien
% Student: Luu Gia Phat
%          Nguyen Tien Phat
%          Ho Tuan Phat
%          Le Quy Phuong
% SUB SCRIPT: Using for drawing mapline
% Last modified date: 2022, Sep, 20
function saban()
    clf;
    format short;
    hold on;
    axis equal;
    grid on;
    %Ve sa ban%
    
    %Ve duong thang AB
    Xab = linspace(0,-2500,1000);
    Yab = Xab*0;
    plot(Xab,Yab,'k','LineWidth',1);
    
    %Ve cung tron BC
    Xbc = linspace(-2500,-3000,1000);
    Ybc = sqrt(500^2 - (Xbc + 2500).^2) + 500;
    plot(Xbc,Ybc,'k','LineWidth',1)
    
    % Ve cung tron CD
    Xcd = linspace(-2500,-3000,1000);
    Ycd = -sqrt(500^2 - (Xbc + 2500).^2) + 500;
    plot(Xcd,Ycd,'k','LineWidth',1)
    
    % Ve duong thang DE
    Xde = linspace(-2500,-2331.3708,1000);
    Yde = 1000 + Xde*0;
    plot(Xde,Yde,'k','LineWidth',1);
        
    % RED   
    % Ve duong cong EF
    Xef = linspace(-2331.3708,-1765.6854,1000);
    Yef = 1800 - sqrt(800^2 - (Xef + 2331.3708).^2);
    plot(Xef,Yef,'k','LineWidth',1,'color',[1 0 0]);
    
    % Ve duong cheo FH
    Xfh = linspace(-1765.6854,-1734.3146,1000);
    Yfh = linspace(1234.3146,1265.6854,1000);
    plot(Xfh,Yfh,'k','LineWidth',1,'color',[1 0 0]);
        
    % Ve duong cong HI
    Xhi = linspace(-1734.3146,-1168.6292,1000);
    Yhi = 700 + sqrt(800^2 - (Xhi + 1168.6292).^2);
    plot(Xhi,Yhi,'k','LineWidth',1,'color',[1 0 0]);
        
    % Ve duong thang IJ
    Xij = linspace(0,-1168.6292,1000);
    Yij = 1500 + Xij*0;
    plot(Xij,Yij,'k','LineWidth',1,'color',[1 0 0]);
     
    % BLUE
    % Ve duong cong EG
    Xeg = linspace(-2331.3708,-1765.6854,1000);
    Yeg = 200 + sqrt(800^2 - (Xeg + 2331.3708).^2);
    plot(Xeg,Yeg,'k','LineWidth',1,'color',[0 1 0]);
    
    % Ve duong cheo GK
    Xgk = linspace(-1765.6854,-1734.3146,1000); 
    Ygk = linspace(1265.6854,1234.3146,1000) - 500;
    plot(Xgk,Ygk,'k','LineWidth',1,'color',[0 1 0]);
     
    % Ve duong cong KL
    Xkl = linspace(-1765.6854,-1168.6292,1000);
    Ykl = 1300 - sqrt(800^2 - (Xkl + 1168.6292).^2);
    plot(Xkl,Ykl,'k','LineWidth',1,'color',[0 1 0]);
        
    % Ve duong thang LM
    Xlm = linspace(0,-1168.6292,1000);
    Ylm = 500 + Xlm*0;
    plot(Xlm,Ylm,'k','LineWidth',1,'color',[0 1 0]);
    
    grid on;
    xlabel('X(mm)')
    ylabel('Y(mm)')
    title('Mo hinh hoa');
    
end