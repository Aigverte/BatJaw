M=load('NonUniformT100.csv');
%M2 = load('UniformT500.csv');
vid=1;
M = M';M(1:2,:) = [];
%M2 = M2';M2(1:2,:) = [];
Tn = size(M,1);
TEnd=2e5;
t = linspace(0,TEnd,Tn);
n=250;
if(vid)
    vidObj = VideoWriter('NonUniform.avi');
    vidObj.FrameRate=50;
    open(vidObj);
end
%1D
Ly=20;
Lx=20*5;
Lxi=Lx/5;
r = (Lx-Lxi)/TEnd;
%gt=10;
%Nonlinear
%Lf = @(t)(Lx-Lxi)*exp(-gt/t)*(1+tanh(gt*(t-TEnd/2)/TEnd))/2;
%L = @(t)Lxi+Lf(t);
%Linear
L = @(t)Lxi+r*t;
'beep'

%figure;
V = interp2(reshape(M(end,:),n,n)',2);
imagesc(V, 'XData', [0,L(t(end))], 'YData', [0,Ly]);
ax = gca;
XLim = ax.XLim;
YLim = ax.YLim;
close all;
f = figure('units','normalized','outerposition',[0 0 1 XLim/YLim]);

for i=1:Tn
    %subplot(2,1,1);
    V = interp2(reshape(M(i,:),n,n)',2);
    imagesc(V, 'XData', [0,L(t(i))], 'YData', [0,Ly]);
    axis image; ax = gca; ax.XLim = XLim; ax.YLim = YLim; ax.YTick=[];
    ax.XTick =[];% [0, L(t(i))];
    if(mod(i,2)==0)
    %subplot(2,1,2);
    %V = interp2(reshape(M2(i/2,:),n,n)',2);
    %imagesc(V, 'XData', [0,L(t(i))], 'YData', [0,Ly]);
    %axis image; ax = gca; ax.XLim = XLim; ax.YLim = YLim; ax.YTick=[];
    %ax.XTick =[];% [0, L(t(i))];
    end
    if(vid)
        currFrame = getframe(f);
        writeVideo(vidObj,currFrame);
    end
    pause(0.000000001);
    
end
if(vid)
    for i=1:vidObj.FrameRate
        writeVideo(vidObj,currFrame);
    end
    close(vidObj);
end
